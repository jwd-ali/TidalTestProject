//
//  AlbumsCoordinator.swift
//  Tidal
//
//  Created by Jawad on 01/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit
class AlbumsCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: UIViewController!
    private weak var albumController: AlbumsViewController?
    private let artist: sendArtistProtocol
    
    
    init(rootViewController: UIViewController,artist:sendArtistProtocol) {
        self.rootViewController = rootViewController
        self.artist = artist
        super.init(rootVC: rootViewController)
    }
    
    override func start() {
        let controller = AlbumsViewController.initFromStoryboard()
        controller.viewModel = viewModal()
        albumController = controller
        rootViewController.show(controller, sender: nil)
    }
    
    private func viewModal()->AlbumsViewModal {
        return  AlbumsViewModalImp(coordinator: self, artist:artist)
    }
    
}
extension AlbumsCoordinator {
    func reloadViews() {
        albumController?.reloadView()
    }
    func insertViews(indexPaths: [IndexPath]) {
        albumController?.insertViews(indexPaths: indexPaths)
    }
    func endRefreshing() {
        albumController?.endRefresh()
    }
    func showProgress() {
        albumController?.showProgress()
    }
}
extension AlbumsCoordinator {
    func showAlbumDetail(albumID:Int){
        rootViewController.navigationItem.title = ""
        let albumDetail = AlbumDetailCoordinator(rootViewController: rootViewController, albumId:albumID)
        coordinate(to: albumDetail)
    }
}
