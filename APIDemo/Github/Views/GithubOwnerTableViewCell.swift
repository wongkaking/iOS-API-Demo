import UIKit
import SnapKit
import SDWebImage

final class GithubOwnerTableViewCell: UITableViewCell {

    private let avatarWidth: CGFloat = 80.0
    private let iconWidth: CGFloat = 24.0

    private lazy var avatatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = avatarWidth / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var ownerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()

    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()

    private lazy var follersLabel: UILabel = {
        let label = UILabel()
        label.text = "Foller: 0"
        label.isHidden = true
        return label
    }()
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = "Following: 0"
        label.isHidden = true
        return label
    }()

    private lazy var companyView: IconAndLabelView = {
        let companyView = IconAndLabelView()
        companyView.icon = UIImage(named: "company")
        companyView.iconHeight = iconWidth
        companyView.iconWidth = iconWidth
        companyView.setSpace(16)
        companyView.isHidden = true
        return companyView
    }()

    private lazy var locationView: IconAndLabelView = {
        let locationView = IconAndLabelView()
        locationView.icon = UIImage(named: "location")
        locationView.iconHeight = iconWidth
        locationView.iconWidth = iconWidth
        locationView.setSpace(16)
        locationView.isHidden = true
        return locationView
    }()

    private lazy var emailView: IconAndLabelView = {
        let emailView = IconAndLabelView()
        emailView.icon = UIImage(named: "email")
        emailView.iconHeight = iconWidth
        emailView.iconWidth = iconWidth
        emailView.setSpace(16)
        emailView.isHidden = true
        return emailView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [avatatImageView, ownerNameLabel, loginLabel, follersLabel, followingLabel, companyView, locationView, emailView].forEach {
            contentView.addSubview($0)
        }

        avatatImageView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(avatarWidth)
        }

        ownerNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(avatatImageView.snp.trailing).offset(32)
            make.trailing.greaterThanOrEqualToSuperview().inset(24)
//            make.centerY.equalTo(avatatImageView).offset(-8)
            make.top.equalTo(avatatImageView).offset(8)
        }

        loginLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(ownerNameLabel)
//            make.centerY.equalTo(avatatImageView).offset(16)
            make.bottom.equalTo(avatatImageView).offset(-8)
        }

        follersLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(ownerNameLabel)
            make.centerY.equalTo(avatatImageView)
        }

        followingLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(ownerNameLabel)
            make.centerY.equalTo(avatatImageView).offset(24)
        }

        companyView.snp.makeConstraints { (make) in
            make.top.equalTo(avatatImageView.snp.bottom).offset(16)
            make.leading.equalTo(avatatImageView)
            make.trailing.greaterThanOrEqualToSuperview().inset(16)
        }

        locationView.snp.makeConstraints { (make) in
            make.top.equalTo(companyView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(companyView)
        }

        emailView.snp.makeConstraints { (make) in
            make.top.equalTo(locationView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(companyView)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    func setupCell(user: User) {
        loginLabel.text = user.login
        ownerNameLabel.text = user.name.capitalized
        if let followerCount = user.followers {
            follersLabel.text = "Follers: \(formatCount(count: followerCount))"
        }
        if let followingCount = user.following {
            followingLabel.text = "Following: \(formatCount(count: followingCount))"
        }
        avatatImageView.sd_setImage(with: URL(string: user.avatarURL ?? ""),
                                    placeholderImage: UIImage(named: "avatar"),
                                    options: .retryFailed,
                                    completed: nil)

        if let company = user.company {
            companyView.text = company
            companyView.isHidden = false
        }
        if let location = user.location {
            locationView.text = location
            locationView.isHidden = false
        }
        if let email = user.email {
            emailView.text = email
            emailView.isHidden = false
        }
    }

    func formatCount(count: Int) -> String {
        if count > 1000 {
            let double: Double = Double(count / 1000)
            return "\(double)k"
        }
        return "\(count)"
    }
}
