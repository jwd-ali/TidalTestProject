//
//  TrackTableCellViewModal.swift
//  Tidal
//
//  Created by Jawad on 02/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//
import AVFoundation
import Foundation
typealias updatePlayButton = () -> Void
protocol TrackTableCellViewModal {
    func trackLength()->String
    func trackNumber()->String
    func trackName()->String
    func trackArtistName()->String
    func playTrack()
    func pauseTrack()
    var updateHandler: updatePlayButton {get set}
    
}
class TrackTableCellViewModalImp: TrackTableCellViewModal {
    
    var updateHandler: updatePlayButton = {}
    private let track : TrackProtocol
    private let index:Int
    
    init(with track:TrackProtocol,index:Int) {
        self.track = track
        self.index = index
    }
    func trackLength()->String {
        return track.durationString() ?? ""
    }
    func trackNumber()->String {
        return "\(index)."
    }
    func trackName()->String {
        return track.title ?? ""
    }
    func trackArtistName()->String {
        return track.artistName()
        
    }
    // MARK: - Play Track with Music player using AVPlayer
    func playTrack() {
        NotificationCenter.default.addObserver(self, selector:#selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        musicPlayer.instance.initPlayer(track: track)
        musicPlayer.instance.play()
    }
    func pauseTrack() {
        musicPlayer.instance.pause()
    }
  @objc private func playerDidFinishPlaying(note: NSNotification) {
        updateHandler()
    }
}
