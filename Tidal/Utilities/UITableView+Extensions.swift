//
//  UITableView+Extensions.swift
//  Tidal
//
//  Created by Jawad on 01/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit
extension UITableView {
    
    func addLoadingFooter() {
        
        if self.tableFooterView == nil {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.bounds.width, height: CGFloat(44))
            
            self.tableFooterView = spinner
            self.tableFooterView?.isHidden = false
        }
    }
    
    func removeLoadingFooter() {
        if self.tableFooterView != nil {
            self.tableFooterView = nil
            self.tableFooterView?.isHidden = true
        }
    }
    
    func hideEmptyRows() {
        self.tableFooterView = UIView(frame: .zero)
    }
}
