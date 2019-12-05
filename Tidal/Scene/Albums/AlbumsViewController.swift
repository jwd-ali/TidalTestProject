//
//  AlbumsViewController.swift
//  Tidal
//
//  Created by Jawad on 01/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController,StoryboardInitializable {
    static func storyboardName() -> String {
        return "Main"
    }
    var viewModel : AlbumsViewModal!
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private lazy var titleStackView: UIStackView = {
        titleLabel.textAlignment = .center
        if UIDevice.current.userInterfaceIdiom == .phone {
            subtitleLabel.font = UIFont.systemFont(ofSize: 11, weight: .light)
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        }else {
            subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
            titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        }
        subtitleLabel.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlbumCollectionViewCell.register(collectionView: collectionView)
        render()
        
    }
    func render() {
        titleLabel.text = viewModel.artistName()
        subtitleLabel.text = "Albums"
        navigationItem.titleView = titleStackView
        addAndShowActivity()
        
    }
    func reloadView() {
        self.collectionView.reloadData()
    }
    func insertViews(indexPaths: [IndexPath]) {
        self.collectionView.insertItems(at: indexPaths)
        
    }
    func showProgress(){
        self.showActivityIndicatory()
    }
    
    func endRefresh() {
        self.removeActivity()
    }
}
// MARK: - CollectionView  delegates and Datasource
extension AlbumsViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  viewModel.loadMore(indexPath: indexPath) {

        }
        
        let cell = AlbumCollectionViewCell.dequeue(collectionView: collectionView, indexPath: indexPath)
        cell.viewModel = viewModel.viewModel(for: indexPath)
        cell.configure()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.albumSelected(at: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? AlbumCollectionViewCell , let imageUrl = cell.viewModel.coverImage() {
            ImageDownloadService.shared.downloadImage(imageUrl,indexPath: indexPath) {[weak collectionView] (image,index,error)  in
                DispatchQueue.main.async {
                    if let getIndexPath = index,let image = image, let getCell = collectionView?.cellForItem(at: getIndexPath) as? AlbumCollectionViewCell {
                        getCell.setCoverImage(image)
                    }
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // MARK: - Reduce the priority of the network operation in case the user scrolls and an image is no longer visible. */
        DispatchQueue.main.async {
            if let cell = cell as? AlbumCollectionViewCell , let imageUrl = cell.viewModel.coverImage() {
                ImageDownloadService.shared.slowDownImageDownloadTaskfor(imageUrl)
            }
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout delegates
extension AlbumsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            if UIDevice.current.orientation.isLandscape {
                return CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width)/3 - 10, height:  310);
            }
            else{
                return CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width)/2 - 10, height: 250);
            }
        }else {
            if UIDevice.current.orientation.isLandscape {
                return CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width)/5 - 10, height:  280);
            }
            else{
                return CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width)/3 - 10, height: 340);
            }
        }
    }
   override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       super.viewWillTransition(to: size, with: coordinator)
       guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
           return
       }
       flowLayout.invalidateLayout()
   }
    
}
