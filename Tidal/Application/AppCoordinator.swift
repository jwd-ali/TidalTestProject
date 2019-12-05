//
//  AppCoordinator.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit
class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init(rootVC: nil)
    }
    
    override func start() {
        let searchCoordinator = SearchCoordinator(window: self.window)
        coordinate(to: searchCoordinator)
    }
}
    
    
