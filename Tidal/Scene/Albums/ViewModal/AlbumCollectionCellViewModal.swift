//
//  AlbumCollectionCellViewModal.swift
//  Tidal
//
//  Created by Jawad on 01/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
protocol AlbumCollectionCellViewModal {
    func title() -> String
    func coverImage() -> URL?
    func getArtistName() ->String
    func getAlbumID()->Int?
}
class AlbumCollectionCellViewModalImp: AlbumCollectionCellViewModal {
    private let album : AlbumProtocol
    private let artistName:String
    init(with album:AlbumProtocol , artistName:String) {
        self.album = album
        self.artistName = artistName
    }
    
    func title() -> String {
        album.title ?? ""
    }
    
    func coverImage() -> URL? {
        if let cover = album.coverBig {
           return URL(string: cover)
        } else {
            return nil
        }
    }
    func getAlbumID()->Int? {
        return album.id
    }
    
    func getArtistName() -> String {
        return self.artistName
    }

}
