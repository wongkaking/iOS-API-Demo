import UIKit
import SnapKit

final class GitHubViewController: UIViewController {

    var repositories: [Repository]?

    private lazy var tableView: UITableView =  {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [LanguageType.swift.title, LanguageType.java.title, LanguageType.python.title, LanguageType.javaScript.title])
        segmentedControl.addTarget(self, action: #selector(didTapSegmentedControl), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = LanguageType.swift.rawValue
        segmentedControl.backgroundColor = .white
        return segmentedControl
    }()

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(GitHubRepositoryTableViewCell.self)
        tableView.register(GithubOwnerTableViewCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Github"
        setupTableView()
        fetchData(language: LanguageType.swift.title, page: 1)
    }

    @objc func didTapSegmentedControl() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: SectionType.userProfile.rawValue), at: .top, animated: true)
        fetchData(language: segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) ?? "", page: 1)
    }

    private func fetchData(language: String, page: Int) {
        NetworkHelper.share.fetchGithubRepos(language: "language:\(language)", sort: "stars", page: page) { (repositories) in
            self.repositories = repositories.items
            self.tableView.reloadData()
        }
    }
}

extension GitHubViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = SectionType(rawValue: section) else { return nil }
        switch section {
        case .userProfile: return nil
        case .repository: return segmentedControl
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = SectionType(rawValue: section) else { return CGFloat.leastNormalMagnitude }
        switch section {
        case .userProfile: return CGFloat.leastNormalMagnitude
        case .repository: return 30.0
        }
    }
}

extension GitHubViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SectionType(rawValue: section) else {
            return 0
        }
        switch section {
        case .userProfile:
            return 1
        case .repository:
            return repositories?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SectionType(rawValue: indexPath.section), let repositories = repositories else {
            return UITableViewCell()
        }
        switch section {
        case .userProfile:
            let cell: GithubOwnerTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupCell(user: repositories[indexPath.row].owner)
            return cell
        case .repository:
            let cell: GitHubRepositoryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupCell(repository: repositories[indexPath.row])
            return cell
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
}

extension GitHubViewController {
    enum SectionType: Int, CaseIterable {
        case userProfile
        case repository
    }

    enum LanguageType: Int, CaseIterable {
        case swift
        case java
        case python
        case javaScript

        var title: String {
            switch self {
            case .swift:
                return "Swift"
            case .java:
                return "Java"
            case .python:
                return "Python"
            case .javaScript:
                return "JavaScript"
            }
        }
    }
}
