//
//  Extension+UITableView.swift
//  Amfixo
//
//  Created by admin on 11/03/21.
//

import UIKit

public extension UITableView {
    
    /**
     Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
     - Parameter type: UITableViewCell.Type
     - Parameter identifier: String?
     */
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }
    
    /**
     DequeueCell by passing the type of UITableViewCell
     - Parameter type: UITableViewCell.Type
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    /**
     DequeueCell by passing the type of UITableViewCell and IndexPath
     - Parameter type: UITableViewCell.Type
     - Parameter indexPath: IndexPath
     */
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
    /**
     Reload UITableViewCell without scroll
     - Parameter
     */
    func reloadDataWithoutScroll() {
        self.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(self.contentOffset, animated: false)
        
    }
    
    /**
     This method returns the indexPath of the cell that contains the specified view
     
     - Parameter view: The view to find.
     
     - Returns: The indexPath of the cell containing the view, or nil if it can't be found
     
     */
    
    //- USE: self.tableView.indexPathForView(button)
    
    func indexPathForView(_ view: UIView) -> IndexPath? {
        let center = view.center
        let viewCenter = self.convert(center, from: view.superview)
        let indexPath = self.indexPathForRow(at: viewCenter)
        return indexPath
    }
}

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
