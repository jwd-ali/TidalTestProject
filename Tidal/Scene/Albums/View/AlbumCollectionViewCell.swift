//
//  AlbumCollectionViewCell.swift
//  Tidal
//
//  Created by Jawad on 01/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
import UIKit
class AlbumCollectionViewCell: UICollectionViewCell,DequeueInitializable {
    
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subTitle: UILabel!

    var viewModel: AlbumCollectionCellViewModal!

    override func awakeFromNib() {
        coverImageView.image = #imageLiteral(resourceName: "albumCover-1")
      
    }
    override func prepareForReuse() {
         coverImageView.image = #imageLiteral(resourceName: "albumCover-1")
        
    }
    func configure() {
        title.text = viewModel.title()
        subTitle.text = viewModel.getArtistName()
    }
    
    func setCoverImage(_ image:UIImage) {
        coverImageView.image = image
    }
}
