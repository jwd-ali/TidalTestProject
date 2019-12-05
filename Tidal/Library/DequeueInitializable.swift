//
//  DequeueInitializable.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
import UIKit

protocol DequeueInitializable {
    static var reuseableIdentifier: String { get }
}

extension DequeueInitializable where Self: UITableViewCell {
    
    static var reuseableIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func dequeue(tableView: UITableView) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseableIdentifier) else {
            return UITableViewCell() as! Self
        }
        return cell as! Self
    }
    static func register(tableView: UITableView)  {
        let cell = UINib(nibName: self.reuseableIdentifier, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: self.reuseableIdentifier)
    }
}

extension DequeueInitializable where Self: UICollectionViewCell {
    
    static var reuseableIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func dequeue(collectionView: UICollectionView,indexPath: IndexPath) -> Self {
        
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseableIdentifier, for: indexPath)
        
        return cell as! Self
    }
     static func register(collectionView: UICollectionView)  {
          let cell = UINib(nibName: self.reuseableIdentifier, bundle: nil)
          collectionView.register(cell, forCellWithReuseIdentifier: self.reuseableIdentifier)
      }
}
