//
//  AlbumDetailCoordinator.swift
//  Tidal
//
//  Created by Jawad on 02/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit
class AlbumDetailCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: UIViewController!
    private weak var albumDetailController: AlbumDetailViewController?
    private let albumId: Int
    
    
    init(rootViewController: UIViewController,albumId:Int) {
           self.rootViewController = rootViewController
           self.albumId = albumId
           super.init(rootVC: rootViewController)
       }
    override func start() {
              let controller = AlbumDetailViewController.initFromStoryboard()
              controller.viewModel = viewModal()
              albumDetailController = controller
              rootViewController.show(controller, sender: nil)
          }
          
          private func viewModal()->AlbumDetailViewModal {
            return  AlbumDetailViewModalImp(coordinator: self, service: DeezerServiceImp(), albumId:albumId)
          }
}
extension AlbumDetailCoordinator {
    func reloadViews() {
        albumDetailController?.reloadView()
    }
    func goToSearch() {
        albumDetailController?.navigationController?.popToRootViewController(animated: true)
    }
}
