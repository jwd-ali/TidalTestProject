//
//  SearchArtistsDataHandler.swift
//  Tidal
//
//  Created by Jawad on 01/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
typealias SearchArtistsDataHandlerBlock = (_ artists: [Artist],_ resetArray: Bool,_ error: AppError?) -> Void
class SearchArtistsDataHandler: NSObject {
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
    
    func searchArtists(for searchQuery: String, completion: @escaping SearchArtistsDataHandlerBlock) {
        isFeedLoading = true
        service.fetchArtists(for: pageNumber, pageSize: pageSize, searchKey: searchQuery) {[weak self] result in
            guard let self = self else {return}
            switch result{
            case .failure(let error):
                self.isFeedNextPageAvailable = true
                self.isFeedLoading = false
                completion([Artist](),false,error)
            case .success(let artists):
                self.isFeedLoading = false
                if let artist = artists, artist.count > 0 {
                    print("page number:\(self.pageNumber)")
                    
                    self.isFeedNextPageAvailable = artist.count >= self.pageSize
                    completion(artist,(self.pageNumber == 0), nil)
                    
                } else {
                    self.isFeedNextPageAvailable = false
                    completion([Artist](),true, nil)
                }
            }
        }
    }
    
}
