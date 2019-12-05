//
//  UIViewController+Extensions.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit
extension UIViewController{
    func showError(error: AppError, errorTitle: String="Error", cancelTitle: String="OK") {
        let controller = UIAlertController.init(title: errorTitle, message: error.error, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction.init(title: cancelTitle, style: .cancel) { (action) in
        }
        controller.addAction(cancel)
        self.present(controller, animated: true, completion: nil)
    }
}
// Bar Button Handling
extension UIViewController{
    func addRightBarButton(title: String? = nil, image: UIImage? = nil, target: Any? = nil,selector: Selector? = nil,backgroundColor:UIColor = UIColor.universalColor3 ){
        if let sel = selector {
            let button = barButton(title: title, image: image, target: target, selector: sel,backgroundColor: backgroundColor)
            self.navigationItem.rightBarButtonItem = button
        }else{
            let button = barButton(title: title, image: image, target: self, selector: #selector(rightBarButtonAction),backgroundColor: backgroundColor)
            self.navigationItem.rightBarButtonItem = button
        }
    }
    
    func addLeftBarButton(title: String? = nil, image: UIImage? = nil, target: Any? = nil,selector: Selector? = nil){
        self.navigationItem.leftBarButtonItem = selectorSetup(title: title, image: image, target: target, selector: selector)
    }
    
    private func selectorSetup(title: String? = nil, image: UIImage? = nil, target: Any? = nil,selector: Selector? = nil) -> UIBarButtonItem{
        if let sel = selector, let tar = target {
            return barButton(title: title, image: image, target: tar, selector: sel)
        }else{
            return barButton(title: title, image: image, target: self, selector: #selector(leftBarButtonAction))
        }
    }
    
    func addBackButton()  {
        let barButton = selectorSetup(title: nil, image: UIImage(named: "back_w"), target: nil, selector: nil)
        barButton.imageInsets = UIEdgeInsets.init(top: 0, left: -8, bottom: 0, right: 0)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func makeBarButtonVisible(barButton: UIBarButtonItem) {
        barButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        barButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
    }
    
    private func barButton(title: String?, image: UIImage?, target: Any?,selector: Selector?,backgroundColor:UIColor = UIColor.universalColor3) -> UIBarButtonItem{
        var barButtonItem: UIBarButtonItem
        
        if title != nil, image != nil {
            let addButton = UIButton(type: .system)
            addButton.setImage(image, for: .normal)
            addButton.setTitle(" " + title!, for: .normal)
            //            addButton.titleLabel?.font = UIFont.appFont(ofSize: FontSize.large, weight: .medium)
            addButton.sizeToFit()
            addButton.addTarget(self, action: selector!, for: .touchUpInside)
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: addButton.frame.size.width + 15, height: addButton.frame.size.height + 10))
            view.backgroundColor = backgroundColor
            view.layer.cornerRadius = view.frame.size.height / 2.0
            addButton.center = view.center
            view.addSubview(addButton)
            
            barButtonItem = UIBarButtonItem(customView: view)
        } else if title != nil {
            barButtonItem = UIBarButtonItem(title: title!, style: .plain, target: target, action: selector)
           // barButtonItem.tintColor = .white
            makeBarButtonVisible(barButton: barButtonItem)
        } else if image != nil {
            barButtonItem = UIBarButtonItem(image: image, style: .plain, target: target, action: selector)
           // barButtonItem.tintColor = .white
            
        } else {
            barButtonItem = UIBarButtonItem()
        }
        return barButtonItem
    }
    
    @objc func rightBarButtonAction() {
        
    }
    @objc func leftBarButtonAction() {
        
    }
    
}
extension UIViewController {
    func addAndShowActivity() {
        addActivityIndicatory()
        showActivityIndicatory()
    }
    
    
    func addActivityIndicatory() {
        DispatchQueue.main.async {
            let container: UIView = UIView()
            container.frame = self.view.frame
            container.center = CGPoint(x: self.view.center.x,y: self.view.center.y - 100)
            container.tag = 999
            container.backgroundColor = UIColor.clear
            container.isHidden = true
            
            let loadingView: UIView = UIView()
            loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            loadingView.center = self.view.center
            loadingView.backgroundColor = UIColor.universalColor4
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            
            let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
            activityIndicator.style =
                UIActivityIndicatorView.Style.large
            activityIndicator.color = UIColor.universalColor2
            activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,
                                               y: loadingView.frame.size.height / 2);
            loadingView.addSubview(activityIndicator)
            container.addSubview(loadingView)
            self.view.addSubview(container)
        
         activityIndicator.startAnimating()
        }
    }
    
    func showActivityIndicatory() {
        DispatchQueue.main.async {
            guard let activity = self.view.viewWithTag(999) else {
                return
            }
            activity.isHidden = false
        }
    }
    
    func removeActivity(){
        DispatchQueue.main.async {
            guard let activity = self.view.viewWithTag(999) else {
                return
            }
            activity.isHidden = true
        }
    }
}
