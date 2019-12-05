//
//  Album.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
// MARK: - AlbumFeed
struct AlbumFeed: Codable {
    let data: [Album]?
    let total: Int?
    let next: String?
}
protocol AlbumProtocol {
    var id:Int? {get}
    var title: String? {get}
    var coverBig:String? {get}
    var coverSmall:String?{get}
    func artistName()->String?
    func getTracks()-> [TrackProtocol]
}

struct Album: Codable,AlbumProtocol {
    let id: Int?
    let title: String?
    let trackList, type ,link, cover: String?
    let coverSmall, coverMedium, coverBig, coverXL: String?
    let genreID, totalFans: Int?
    let releaseDate: String?
    let explicitLyrics: Bool?
    let contributors:[Artist]?
    let artist:Artist?
    let tracks: TrackFeed?
    
    func artistName()->String? {
        return artist?.name
    }
    func getTracks()-> [TrackProtocol] {
        if let tracksFeed = tracks {
            return tracksFeed.data ?? [TrackProtocol]()
        } else {
           return [TrackProtocol]()
        }
    }
    enum CodingKeys: String, CodingKey {
        case id, title, trackList, type, link, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXL = "cover_xl"
        case genreID = "genre_id"
        case totalFans
        case releaseDate = "release_date"
        case explicitLyrics = "explicit_lyrics"
        case contributors,artist
        case tracks
    }
}
