import UIKit

extension UIView {
    @nonobjc public static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }

    @nonobjc public static var reuseId: String { return String(describing: self) }

    var isVisibleOnScreen: Bool { return frame.origin.y < UIScreen.main.bounds.height}

    class func delay(seconds: Double, completion:@escaping (() -> Void)) {
         DispatchQueue.main.asyncAfter(
             deadline: DispatchTime.now() + seconds, execute: completion)
     }
}

extension UICollectionView {
    public func register(_ cellClass: UICollectionViewCell.Type) {
        register(cellClass.self, forCellWithReuseIdentifier: String(describing: cellClass))
    }

    public func registerNib(for cellClass: UICollectionViewCell.Type) {
        register(cellClass.nib, forCellWithReuseIdentifier: cellClass.defaultReuseIdentifier)
    }

    public func registerSectionHeaderNib<T: UICollectionReusableView>(for cellClass: T.Type) {
        let nib = UINib(nibName: cellClass.nibName, bundle: Bundle(for: T.self))
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellClass.defaultReuseIdentifier)
    }

    public func registerSectionFooter(for cellClass: UICollectionReusableView.Type) {
        register(cellClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellClass.defaultReuseIdentifier)
    }

    public func dequeueReusableCell<CellClass: UICollectionViewCell>(for indexPath: IndexPath) -> CellClass {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CellClass.defaultReuseIdentifier, for: indexPath) as? CellClass else {
            fatalError("Cannot dequeueReusableCell of \(CellClass.self) type!")
        }
        return cell
    }

    public func dequeueReusableSupplementaryView<ViewClass: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath) -> ViewClass {
        guard let view = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: ViewClass.defaultReuseIdentifier, for: indexPath) as? ViewClass else {
            fatalError("Cannot dequeueReusableSupplementaryView of \(ViewClass.self) type!")
        }
        return view
    }

    public func dequeueReusableCell<CellClass: UICollectionViewCell>(
        of classType: CellClass.Type,
        for indexPath: IndexPath,
        defaultCell: UICollectionViewCell? = nil,
        configure: (CellClass) -> Void = { _ in }) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CellClass.defaultReuseIdentifier, for: indexPath)
        if let typedCell = cell as? CellClass {
            configure(typedCell)
            return typedCell
        }
        return defaultCell ?? cell
    }
}

extension UICollectionReusableView {
    @nonobjc public static var nibName: String { return String(describing: self) }
}

extension UITableView {

    func register(_ cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.defaultReuseIdentifier)
    }

    func register(_ view: UITableViewHeaderFooterView.Type) {
        register(view, forHeaderFooterViewReuseIdentifier: view.defaultReuseIdentifier)
    }

    func registerNib<T: UITableViewCell>(_ cellType: T.Type) {
        register(UINib(nibName: T.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func dequeueReusableCell<CellClass: UITableViewCell>(for indexPath: IndexPath) -> CellClass {
        guard let cell = dequeueReusableCell(withIdentifier: CellClass.defaultReuseIdentifier, for: indexPath) as? CellClass else {
            fatalError("Cannot dequeueReusableCell of \(CellClass.self) type!")
        }
        return cell
    }

    func dequeueReusableCell<CellClass: UITableViewCell>(
        of classType: CellClass.Type,
        for indexPath: IndexPath,
        defaultCell: UITableViewCell? = nil,
        configure: (CellClass) -> Void = { _ in }) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: CellClass.defaultReuseIdentifier, for: indexPath)
        if let typedCell = cell as? CellClass {
            configure(typedCell)
            return typedCell
        }
        return defaultCell ?? cell
    }

    public func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Could not deque cell of type: \(cellType.reuseId)")
        }
        return cell
    }
}
