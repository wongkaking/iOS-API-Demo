import UIKit
import SnapKit

final class GitHubRepositoryTableViewCell: UITableViewCell {

    private let iconWidth: CGFloat = 12.0

    private var nameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var languageLabel = UILabel()
    private var starCountLabel = UILabel()
    private var forkCountLabel = UILabel()

    private lazy var languageColorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = iconWidth / 2
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        return imageView
    }()

    private lazy var forkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fork")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        descriptionLabel.numberOfLines = 0

        [nameLabel, descriptionLabel, languageColorImage, languageLabel, starCountLabel, forkCountLabel, starImageView, forkImageView].forEach {
            contentView.addSubview($0)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(16)
            make.trailing.greaterThanOrEqualToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel)
            make.trailing.equalToSuperview().inset(24)
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
        }

        languageColorImage.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel)
            make.height.width.equalTo(iconWidth)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }

        languageLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(languageColorImage.snp.trailing).offset(8)
            make.centerY.equalTo(languageColorImage)
            make.bottom.equalToSuperview().inset(8)
        }

        forkImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(iconWidth)
            make.trailing.equalTo(forkCountLabel.snp.leading).offset(-8)
            make.centerY.equalTo(languageColorImage)
        }

        forkCountLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(starImageView.snp.leading).offset(-16)
            make.centerY.equalTo(languageColorImage)
        }

        starImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(iconWidth)
            make.trailing.equalTo(starCountLabel.snp.leading).offset(-8)
            make.centerY.equalTo(languageColorImage)
        }

        starCountLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalTo(languageColorImage)
        }
    }

    private func matchLanguageColor(_ languageString: String?) -> UIColor {
        switch languageString {
        case "Swift":
            return .orange
        case "Java":
            return .brown
        case "Python":
            return .blue
        case "JavaScript":
            return .yellow
        default:
            return .darkGray
        }
    }

    func setupCell(repository: Repository) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description
        languageLabel.text = repository.language
        forkCountLabel.text = "\(repository.forksCount)"
        starCountLabel.text = "\(repository.starCount)"
        languageColorImage.backgroundColor = matchLanguageColor(repository.language)
    }
}
