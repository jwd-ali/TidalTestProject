//
//  SearchViewModal.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
protocol SearchViewModal:class {
    func title()->String
    func numberOfRows()->Int
    func viewModel(for indexPath: IndexPath) -> ArtistTableCellViewModal
    func getInitialSearchArtists(For text:String)
    func loadMore(indexPath: IndexPath) -> Bool
    func resetSearch()
    func rowSelected(at indexPath: IndexPath)
}

class SearchViewModalImp : SearchViewModal  {
    
    private var coordinator : SearchCoordinator
    private lazy var searchArtistDataHandler = {return SearchArtistsDataHandler()}()
    private lazy var viewModels: [ArtistTableCellViewModal] = {return []}()
    private var searchString : String?
    init(coordinator:SearchCoordinator) {
        self.coordinator=coordinator

    }
    
    func numberOfRows()->Int{
        return viewModels.count
    }
    func viewModel(for indexPath: IndexPath) -> ArtistTableCellViewModal {
           return viewModels[indexPath.row]
    }
    func title()->String {
        return SearchScreen.title
    }
    func rowSelected(at indexPath: IndexPath) {
        let vm = viewModel(for: indexPath)
        coordinator.showAlbums(artist: vm.getArtist())
    }
    
    // MARK: - handle Search results and generate viewmodals
    private func handleResults(artists: [Artist],resetArray: Bool, error: AppError?) {
        
        var newViewModels: [ArtistTableCellViewModal] = []
            for artist in artists {
                let vm = ArtistTableCellViewModalImp(with: artist, searchText: self.searchString)
                newViewModels.append(vm)
            }
        if resetArray {
            self.viewModels.removeAll()
        }
        let oldSize = self.viewModels.count
        self.viewModels.append(contentsOf: newViewModels)
            if resetArray {
                self.coordinator.endRefreshing()
                self.coordinator.reloadViews()
                
            } else {
                var newIndexPaths : [IndexPath] = []
                for index in oldSize..<self.viewModels.count {
                    newIndexPaths.append(IndexPath(item: index, section: 0))
                }
                
                self.coordinator.endRefreshing()
                self.coordinator.insertViews(indexPaths: newIndexPaths)
                
            }
        
    }
    // MARK: - load next page if available
    func loadMore(indexPath: IndexPath) -> Bool {
        if indexPath.row >= numberOfRows() - 1 {
            if  searchArtistDataHandler.nextFeedsPage() {
                searchArtists()
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
        searchArtistDataHandler.resetFeedsPaging()
    }
     func getInitialSearchArtists(For text:String) {
         searchString = text
        if text.isEmpty {
            self.viewModels.removeAll()
            self.coordinator.reloadViews()
            
        } else {
            refreshFeeds()
            searchArtists()
        }
    }
     // MARK: - searchArtists using data handler
   private func searchArtists(){
        if let text = searchString {
            coordinator.showProgress()
            searchArtistDataHandler.searchArtists(for: text) { [weak self] (artists, refresh, error) in
                 DispatchQueue.main.async {
                self?.handleResults(artists: artists, resetArray: refresh, error: error)
                }
            }
        }
    }

    
}
