//
//  MusicPlayer.swift
//  Tidal
//
//  Created by Jawad on 04/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//
import UIKit
import AVFoundation
import MediaPlayer
class musicPlayer:NSObject {
    public static var instance = musicPlayer()
    var player = AVPlayer()
    func initPlayer(track : TrackProtocol) {
        guard let link = track.preview ,  let url = URL.init(string: link) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        
        
        setMetaDataControl(track)
        playAudioBackground()
    }
//AVAudioSessionCategoryPlayback
    func playAudioBackground() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
    }
    func setMetaDataControl(_ track:TrackProtocol) {
        let getImage = #imageLiteral(resourceName: "AlbumCover")
        let artwork = MPMediaItemArtwork.init(boundsSize: getImage.size, requestHandler: { (size) -> UIImage in
            return getImage
        })

        var playingInfo:[String: Any] = [:]

        playingInfo[MPMediaItemPropertyArtwork] = artwork
        playingInfo[MPNowPlayingInfoPropertyPlaybackRate] = NSNumber(value: 2.0)
        playingInfo[MPMediaItemPropertyTitle] = track.title
        playingInfo[MPMediaItemPropertyAlbumTitle] = track.artistName()
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = playingInfo

        UIApplication.shared.beginReceivingRemoteControlEvents()
        let CommandCenter = MPRemoteCommandCenter.shared()
        CommandCenter.playCommand.isEnabled = true
        CommandCenter.playCommand.addTarget {[weak self](_) -> MPRemoteCommandHandlerStatus in
            self?.play()
                      
             return .success
        }

        CommandCenter.pauseCommand.isEnabled = true
         CommandCenter.pauseCommand.addTarget { [weak self](_) -> MPRemoteCommandHandlerStatus in
                   self?.pause()
            return .success
        }
    }
    func pause(){
        player.pause()
    }

    func play() {
        player.play()
    }
 
}
