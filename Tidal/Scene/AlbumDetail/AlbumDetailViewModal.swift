//
//  AlbumDetailViewModal.swift
//  Tidal
//
//  Created by Jawad on 02/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
protocol AlbumDetailViewModal {
    func numberOfRows()-> Int
    func getAlbumName()-> String
    func getArtistName()->String
    func getCoverImage()->URL?
    func viewModel(for indexPath: IndexPath) -> TrackTableCellViewModal
    func goToSearch()
}
class AlbumDetailViewModalImp: AlbumDetailViewModal {
    private let service :DeezerService
    private var coordinator : AlbumDetailCoordinator
    private let albumId:Int
    private var album : AlbumProtocol?
    private lazy var viewModels: [TrackTableCellViewModal] = {return []}()
    
    init(coordinator:AlbumDetailCoordinator,service:DeezerService,albumId:Int) {
           self.albumId = albumId
           self.coordinator = coordinator
            self.service = service
           getAlbumDetail()
       }
    private func getAlbumDetail(){
          service.fetchAlbumDetail(for: albumId) {[weak self] result in
              guard let self = self else {return}
              
              switch result {
              case .failure(let error):
                  self.coordinator.showError(error: error)
              case .success(let album):
                  self.album = album
                  self.generateViewModals()
              }
              
          }
      }
    func getThumbnailImage()-> URL? {
        if let cover = album?.coverSmall {
                   return URL(string: cover)
               }else {
                   return nil
               }
    }
    
    func getCoverImage() -> URL? {
        if let cover = album?.coverBig {
            return URL(string: cover)
        }else {
            return nil
        }
    }
    
    func getAlbumName() -> String {
       return album?.title ?? ""
    }
    
    func getArtistName() -> String {
       return album?.artistName() ?? ""
    }
    func numberOfRows()-> Int{
        return viewModels.count
    }
    func goToSearch() {
        coordinator.goToSearch()
    }
    // MARK: - generate ViewModals
    private func generateViewModals() {
        guard let tracks = self.album?.getTracks() else {
            return
        }
        var count = 1
        for track in tracks {
            let vm = TrackTableCellViewModalImp(with: track, index: count)
            viewModels.append(vm)
            count += 1
        }
        DispatchQueue.main.async {
            
        
            self.coordinator.reloadViews()
        }

    }
     func viewModel(for indexPath: IndexPath) -> TrackTableCellViewModal {
        return viewModels[indexPath.row]
    }
}
