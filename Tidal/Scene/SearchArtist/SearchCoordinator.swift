//
//  SearchCoordinator.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit
class SearchCoordinator: BaseCoordinator<Void> {
    private weak var window: UIWindow?
    private weak var rootViewController : UIViewController!
   init(window: UIWindow) {
       self.window = window
       super.init(rootVC: rootViewController)
   }
    
    override func start() {
        let viewController = SearchViewController.initFromStoryboard()
        let viewModel: SearchViewModal = SearchViewModalImp(coordinator: self)
        viewController.viewModel = viewModel
        rootViewController = viewController
        let navigationController = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
extension SearchCoordinator {
    func reloadViews() {
        if let controller = rootViewController as? SearchViewController {
            controller.reloadView()
        }
    }
    func insertViews(indexPaths: [IndexPath]) {
        if let controller = rootViewController as? SearchViewController {
            controller.insertViews(indexPaths: indexPaths)
        }
    }
    func endRefreshing() {
        if let controller = rootViewController as? SearchViewController {
            controller.endRefresh()
        }
    }
    func showProgress() {
        if let controller = rootViewController as? SearchViewController {
            controller.showProgress()
        }
    }
}
extension SearchCoordinator {
    func showAlbums(artist:sendArtistProtocol){
        rootViewController.navigationItem.title = ""
        let albums = AlbumsCoordinator(rootViewController: rootViewController, artist:artist)
        coordinate(to: albums)
    }
    
}
