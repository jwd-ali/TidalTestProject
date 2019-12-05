//
//  ArtistTableCellViewModal.swift
//  Tidal
//
//  Created by Jawad on 01/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit
protocol ArtistTableCellViewModal {
    func title(labelSize:CGFloat) -> NSAttributedString
    func artistImage() -> URL?
    func albumsCount() ->String
    func getArtist()->sendArtistProtocol
}
class ArtistTableCellViewModalImp: ArtistTableCellViewModal {
    
   private var  artist : ArtistProtocol
   private var searchText: String?
    init(with artist:ArtistProtocol,searchText:String?) {
        self.artist = artist
        self.searchText = searchText
    }
   
    func artistImage() -> URL? {
        if let picture = self.artist.pictureMedium {
            return URL(string:picture )
        } else {
            return nil
        }
    }
    func getArtist()->sendArtistProtocol {
        return artist
    }
    func albumsCount() -> String {
        return "\(String(artist.totalAlbums ?? 0)) albums"
    }
    // MARK: - bold search text using NSAttributedString
    
    func title(labelSize:CGFloat) -> NSAttributedString {
        if let searchedText = searchText , let name = artist.name {
            let range = (name as NSString).range(of: searchedText)
            let attributedString = NSMutableAttributedString(string: name)
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: labelSize, weight: .heavy), range: range)
            return attributedString
        }
        
        return NSAttributedString(string: "")
    }
    
    
}
