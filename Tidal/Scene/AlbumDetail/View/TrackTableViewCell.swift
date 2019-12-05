//
//  TrackTableViewCell.swift
//  Tidal
//
//  Created by Jawad on 02/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit
class TrackTableViewCell: UITableViewCell,DequeueInitializable {
    
     // MARK: - Private outlets
    @IBOutlet private weak var trackNumber: UILabel!
    @IBOutlet private weak var trackName: UILabel!
    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var songDuration: UILabel!
    @IBOutlet private weak var playPauseButton: UIButton!
    
    var viewModal:TrackTableCellViewModal!
    
    @IBAction private func playButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.tag = 1
            playPauseButton.setImage(UIImage (systemName: "pause.fill"), for: .normal)
            viewModal.playTrack()
        }else {
            sender.tag = 0
            playPauseButton.setImage(UIImage (systemName: "play.fill"), for: .normal)
            viewModal.pauseTrack()
        }
    }
    // MARK: - configure cell
    func configure() {
        self.selectionStyle = .none
        self.trackNumber.text = viewModal.trackNumber()
        self.trackName.text = viewModal.trackName()
        self.artistName.text = viewModal.trackArtistName()
        self.songDuration.text = viewModal.trackLength()
        viewModal.updateHandler = songCompleted
        
    }
     // MARK: - Play button used SF symbol
   private func songCompleted() {
        playPauseButton.setImage(UIImage (systemName: "play.fill"), for: .normal)
    }
}
