import UIKit
import SnapKit

final class IconAndLabelView: UIView {
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    }()

    private var iconImageView = UIImageView()
    private var cachedIconColor: UIColor?

    public var icon: UIImage? {
        set {
            iconImageView.image = cachedIconColor != nil
                ? newValue?.withRenderingMode(.alwaysTemplate)
                : newValue
        }
        get {
            return iconImageView.image
        }
    }

    public var iconColor: UIColor? {
        set {
            iconImageView.image = iconImageView.image?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = newValue
            cachedIconColor = newValue
        }
        get {
            return iconImageView.tintColor
        }
    }

    public var iconWidth: CGFloat {
        set {
            iconImageView.snp.updateConstraints { (make) in
                make.width.equalTo(newValue)
            }
        }
        get {
            return iconImageView.bounds.width
        }
    }

    public var iconHeight: CGFloat {
        set {
            iconImageView.snp.updateConstraints { (make) in
                make.height.equalTo(newValue)
            }
        }
        get {
            return iconImageView.bounds.height
        }
    }

    public var text: String? {
        set {
            contentLabel.text = newValue
        }
        get {
            return contentLabel.text
        }
    }

    public var textColor: UIColor {
        set {
            contentLabel.textColor = newValue
        }
        get {
            return contentLabel.textColor
        }
    }

    public var textFont: UIFont {
        set {
            contentLabel.font = newValue
        }
        get {
            return contentLabel.font
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        addSubview(contentLabel)
        addSubview(iconImageView)

        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20.0)
            make.leading.equalToSuperview()
            make.top.bottom.centerY.equalToSuperview()
        }

        contentLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(iconImageView.snp.trailing)
            make.bottom.equalToSuperview()
            make.trailing.centerY.equalToSuperview()
        }
    }

    func setSpace(_ space: CGFloat) {
        contentLabel.snp.updateConstraints { (make) in
            make.leading.equalTo(iconImageView.snp.trailing).offset(space)
        }
    }
}
