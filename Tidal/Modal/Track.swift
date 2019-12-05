//
//  Track.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
protocol TrackProtocol {
    var title:String? { get }
    var preview:String? {get}
    func artistName()->String
    func durationString() -> String?
    
}
struct TrackFeed:Codable {
    let data: [Track]?
}
struct Track: Codable,TrackProtocol {
    let id:Int?
    let readable:Bool?
    let title, titleShort, titleVersion:String?
    let link, preview:String?
    let artist:Artist?
    let type:String?
    private let duration:Int?
    
    func artistName()->String {
        return artist?.name ?? ""
    }
    
    func durationString() -> String? {
        guard let duration = duration else { return "00:00" }
        let minutes = duration / 60
        let seconds = duration % 60
        
        return "\(timeString(from: minutes)):\(timeString(from:seconds))"
    }
    private func timeString(from number: Int) -> String {
        return number < 10 ? "0\(number)" : "\(number)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case link,preview
        case artist,type
        case duration
    }
    
    
    
}
