//
//  BaseCoordinator.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//


import Foundation
import UIKit
class BaseCoordinator<ResultType> {
    typealias CoordinationResult = ResultType
    
    private let identifier = UUID()

    private weak var rootViewController : UIViewController?
    
    init(rootVC: UIViewController?) {
        rootViewController = rootVC
        
    }
    
    private func store<T>(coordinator: BaseCoordinator<T>) {
        //            childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func free<T>(coordinator: BaseCoordinator<T>) {
        //            childCoordinators[coordinator.identifier] = nil
    }
    
    func coordinate<T>(to coordinator: BaseCoordinator<T>, shouldStore : Bool = false) {
        if shouldStore {
            store(coordinator: coordinator)
        }
        coordinator.start()
    }
    
    func start() {
        #if DEBUG
        fatalError("init(coder:) has not been implemented. Should be instantiated from code.")
        #endif
        
    }
}
extension BaseCoordinator {
    func showError(error: AppError) {
        if let controller = rootViewController{
            controller.showError(error: error)
        }else {
            UIViewController().showError(error: error)
        }
    }
}
