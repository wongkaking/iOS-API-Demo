import Foundation
import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView {

    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell {

    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }

}

extension UITableViewHeaderFooterView {

    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }

}
