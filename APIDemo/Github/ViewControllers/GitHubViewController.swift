import UIKit
import SnapKit

final class GitHubViewController: UIViewController {

    let repositories = [Repository(name: "Github",
                                   id: 1,
                                   fullName: "Github",
                                   owner: User(login: "kary", id: 1, avatarURL: nil, url: nil, name: "kary", followers: 0, following: 0, createdAt: "2010-11-16T22:52:40Z", updatedAt: "2020-03-23T14:26:24Z", company: "@globocom", email: "qq.com", location: "Brazil"),
                                   description: nil,
                                   language: "Swift",
                                   starCount: 0,
                                   forksCount: 0)]

    private lazy var tableView: UITableView =  {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Swift", "Java", "Python", "JavaScript"])
        segmentedControl.addTarget(self, action: #selector(didTapSegmentedControl), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
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
    }

    @objc func didTapSegmentedControl() {
        print(segmentedControl.selectedSegmentIndex)
    }
}

extension GitHubViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return segmentedControl
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}

extension GitHubViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SectionType(rawValue: section) else {
            return 0
        }
        switch section {
        case .repository, .userProfile:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SectionType(rawValue: indexPath.section) else {
            fatalError("Section Initiation Failed!")
        }
        switch section {
        case .repository:
            let cell: GitHubRepositoryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupCell(repository: repositories[indexPath.row])
            return cell
        case .userProfile:
            let cell: GithubOwnerTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupCell(user: repositories[indexPath.row].owner)
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
}
