//
//  AlbumsDataHandler.swift
//  Tidal
//
//  Created by Jawad on 01/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
typealias AlbumsDataHandlerBlock = (_ artists: [Album],_ resetArray: Bool,_ error: AppError?) -> Void
class AlbumsDataHandler: NSObject {
    
    private let service : DeezerService = DeezerServiceImp()
    
    private var pageNumber = 0
    private var pageSize = 20
    
    private var isFeedLoading = false
    private var isFeedNextPageAvailable = true
    
    
    func resetFeedsPaging() {
        self.isFeedNextPageAvailable = true
        self.pageNumber = 0
    }
    
    func nextFeedsPage() -> Bool {
        if isFeedNextPageAvailable && !isFeedLoading{
            self.pageNumber = self.pageNumber + 1
            return true
        }
        return false
    }
    
    private func currentPageError () {
        self.pageNumber = self.pageNumber - 1
        if self.pageNumber < 0 {
            self.pageNumber = 0
        }
    }
    fileprivate func feedLoading(feedloading: Bool)  {
        isFeedLoading = feedloading
    }
    fileprivate func currentPageNumber() -> Int {
        return pageNumber
    }
    fileprivate func currentPageSize() -> Int {
        return pageSize
    }
    
    func searchAlbums(for artistID: Int, completion: @escaping AlbumsDataHandlerBlock) {
        isFeedLoading = true
        service.fetchAlbum(for: pageNumber, pageSize: pageSize, artistID : artistID) {[weak self] result in
            guard let self = self else {return}
            switch result{
            case .failure(let error):
                self.isFeedNextPageAvailable = true
                self.isFeedLoading = false
                completion([Album](),false,error)
            case .success(let albums):
                self.isFeedLoading = false
                if let album = albums, album.count > 0 {
                    self.isFeedNextPageAvailable = album.count >= self.pageSize
                    completion(album,(self.pageNumber == 0), nil)
                    
                } else {
                    self.isFeedNextPageAvailable = false
                    completion([Album](),true, nil)
                }
            }
        }
    }
    
}

