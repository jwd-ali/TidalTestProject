//
//  ArtistTableViewCell.swift
//  Tidal
//
//  Created by Jawad on 01/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit
class ArtistTableViewCell: UITableViewCell,DequeueInitializable {
    
    // MARK: - private outlets
    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var albumsCount: UILabel!
    
    var viewModel: ArtistTableCellViewModal!
    override func awakeFromNib() {
        super.awakeFromNib()
        // MARK: - circular image
        artistImageView.layer.cornerRadius = artistImageView.frame.height/2
        artistImageView.image = #imageLiteral(resourceName: "artistAvatar1")
       
    }
    override func prepareForReuse() {
        artistImageView.image = #imageLiteral(resourceName: "artistAvatar1")
        
    }
    // MARK: - configure cell
    func configure() {
        let size = title.font?.pointSize
        title.attributedText = viewModel.title(labelSize:size ?? 17 )
        albumsCount.text = viewModel.albumsCount()
       
    }
    
    func setArtistImage(_ image:UIImage) {
        artistImageView.image = image
       
    }
    
    
}
