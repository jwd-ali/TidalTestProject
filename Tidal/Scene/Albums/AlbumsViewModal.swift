//
//  AlbumsViewModal.swift
//  Tidal
//
//  Created by Jawad on 01/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
protocol AlbumsViewModal {
    func numberOfRows()->Int
    func viewModel(for indexPath: IndexPath) -> AlbumCollectionCellViewModal
    func loadMore(indexPath: IndexPath) -> Bool
    func albumSelected(at indexPath:IndexPath)
    func artistName()->String
}
class AlbumsViewModalImp: AlbumsViewModal {
    private var coordinator : AlbumsCoordinator
    private let artist:sendArtistProtocol
    private lazy var albumsDataHandler = {return AlbumsDataHandler()}()
    private lazy var viewModels: [AlbumCollectionCellViewModal] = {return []}()
    init(coordinator:AlbumsCoordinator,artist:sendArtistProtocol) {
        self.artist = artist
        self.coordinator = coordinator
        searchAlbums()
    }
    func artistName()->String {
        return artist.name ?? ""
    }
    func numberOfRows()->Int{
        return viewModels.count
    }
    func viewModel(for indexPath: IndexPath) -> AlbumCollectionCellViewModal {
        return viewModels[indexPath.row]
    }
    private func searchAlbums(){
        if let id = artist.id {
            albumsDataHandler.searchAlbums(for: id) { [weak self] (albums, refresh, error) in
                DispatchQueue.main.async {
                    self?.handleResults(albums: albums, resetArray: refresh, error: error)
                    self?.coordinator.endRefreshing()
                }
            }
        } else {
            coordinator.showError(error: AppError(error: "Artist ID not found"))
        }
    }
    // MARK: - handle Search results and generate viewmodals
    private func handleResults(albums: [Album],resetArray: Bool, error: AppError?) {
        
        if let error = error {
            self.coordinator.showError(error: error)
            return
        }
        var newViewModels: [AlbumCollectionCellViewModal] = []
        for album in albums {
            let vm = AlbumCollectionCellViewModalImp(with: album, artistName: artist.name ?? "")
            newViewModels.append(vm)
        }
        if resetArray {
            self.viewModels.removeAll()
        }
        let oldSize = self.viewModels.count
        self.viewModels.append(contentsOf: newViewModels)
        if resetArray {
            self.coordinator.reloadViews()
            
        } else {
            var newIndexPaths : [IndexPath] = []
            for index in oldSize..<self.viewModels.count {
                newIndexPaths.append(IndexPath(item: index, section: 0))
            }
            
            self.coordinator.insertViews(indexPaths: newIndexPaths)
            
        }
        
    }
    func loadMore(indexPath: IndexPath) -> Bool {
        if indexPath.row >= numberOfRows() - 1 {
            if  albumsDataHandler.nextFeedsPage() {
                searchAlbums()
                return true
            }
        }
        return false
    }
    func resetSearch() {
        self.viewModels.removeAll()
        self.coordinator.reloadViews()
    }
    func refreshFeeds() {
        albumsDataHandler.resetFeedsPaging()
    }
    func albumSelected(at indexPath:IndexPath) {
        if let albumID  = viewModel(for: indexPath).getAlbumID() {
            coordinator.showAlbumDetail(albumID: albumID)
        }else {
            coordinator.showError(error: AppError(error: "album id not found"))
        }
        
    }
    
}
