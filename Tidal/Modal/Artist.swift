//
//  Artist.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
// MARK: - ArtistFeed
struct ArtistFeed: Codable {
    let data: [Artist]?
    let total: Int?
    let next: String?
}

// MARK: - Artist Protocol to implement interface Segregation
protocol ArtistProtocol:sendArtistProtocol {
    var id:Int? {get}
    var name: String? { get }
    var totalAlbums:Int? {get }
    var pictureMedium:String? {get}
}
protocol sendArtistProtocol {
    var id:Int? {get}
    var name: String? { get }
}
struct Artist: Codable,ArtistProtocol {
    let id:Int?
    let link: String?
    let trackList: String?
    let type:String?
    let name,role:String?
    let picture , pictureSmall , pictureMedium , pictureBig , pictureXL:String?
    let totalAlbums , totalFans : Int?
    let radio:Bool?
    
}
extension Artist {
    
    private enum CodingKeys: String, CodingKey {
        case id,link,role
        case trackList = "tracklist"
        case type,name,picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXL = "picture_xl"
        case totalAlbums = "nb_album"
        case totalFans = "nb_fan"
        case radio
        
    }
}
