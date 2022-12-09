// **********************************************************
//    Copyright © 2022 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit

public protocol TableViewCellRegisterable: ClassIdentifiable { }

extension UITableViewCell: TableViewCellRegisterable { }

public extension TableViewCellRegisterable {
    
    static func registerIn(tableView: UITableView) {
        tableView.register(UINib(nibName: identifier, bundle: Bundle(for: self)), forCellReuseIdentifier: identifier)
    }
    
    static func dequeueIn(tableView: UITableView, for indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Self
    }
    
}
