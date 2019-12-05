//
//  AlbumDetailViewController.swift
//  Tidal
//
//  Created by Jawad on 02/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit
class AlbumDetailViewController: UIViewController,StoryboardInitializable {
    static func storyboardName() -> String {
        return "Main"
    }
    var viewModel : AlbumDetailViewModal!
    // MARK: - Private Outlets explicit unwraped
    @IBOutlet private weak var blurrImageView: UIImageView!
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var albumTitle: UILabel!
    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var tracksTableView: UITableView!
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private lazy var titleStackView: UIStackView = {
        titleLabel.textAlignment = .center
        if UIDevice.current.userInterfaceIdiom == .phone {
            titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
            subtitleLabel.font = UIFont.systemFont(ofSize: 11, weight: .light)
        }else {
            titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
            subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        }
        subtitleLabel.textAlignment = .center
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        render()
         addAndShowActivity()
    }
    // MARK: - render view
    private func render() {
        TrackTableViewCell.register(tableView: tracksTableView)
        self.albumTitle.text = viewModel.getAlbumName()
        self.artistName.text = viewModel.getArtistName()
        
        // MARK: - uncomment following lines to  show thumbnail image first then big image
        
//        if let smallImageUrl = viewModel.getThumbnailImage() {
//            ImageDownloadService.shared.downloadImage(smallImageUrl) {[weak self] image,index,error  in
//                self?.setImages(image)
        if let imageUrl = self.viewModel.getCoverImage() {
            ImageDownloadService.shared.downloadImage(imageUrl) {[weak self] image,index,error  in
                
                if let image = image {
                    DispatchQueue.main.async {
                        self?.setImages(image)
                    }
                }
            }
        }
            //}
        //}
        
        let image = UIImage(systemName: "magnifyingglass")
        addRightBarButton(image:image )
        titleLabel.text = viewModel.getAlbumName()
        subtitleLabel.text = viewModel.getArtistName()
        navigationItem.titleView = titleStackView
    }
    private func setImages(_ image: UIImage?){
        DispatchQueue.main.async {
            self.coverImageView.image = image
            self.blurrImageView.image = image
            self.blurrImageView.blurImage()
        }
    }
    func reloadView() {
            render()
            self.tracksTableView.reloadData()
            removeActivity()
       }
    
    override func rightBarButtonAction() {
        viewModel.goToSearch()
    }
}
// MARK: - Table view delegates and data source
extension AlbumDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TrackTableViewCell.dequeue(tableView: tableView)
        cell.viewModal = viewModel.viewModel(for: indexPath)
        cell.configure()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //viewModel.rowSelected(at: indexPath)
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
