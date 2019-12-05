//
//  Request.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
struct AlbumDetailsRequest: Codable {
    let albumId : Int
}
struct ArtistRequest: Codable {
      let pageNumber: Int
      let pageSize: Int
      let searchString:String
}
struct AlbumsRequest: Codable {
    let pageNumber: Int
    let pageSize: Int
    let artistId : Int
}
