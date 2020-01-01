//
//  ViewController.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,StoryboardInitializable {
    static func storyboardName() -> String {
       return "Main"
    }
    var viewModel : SearchViewModal!
    // MARK: - Private outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    private lazy var thresHold: Timer? = {return Timer()}()
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = viewModel.title()
    }
    // MARK: - render view
    private func render() {
        ArtistTableViewCell.register(tableView: tableView)
        // MARK: - we can uncomment this code to show loading Animation on each letter type
         
//        DispatchQueue.main.async {
//            self.addActivityIndicatory()
//        }
        
    }
    
    func reloadView() {
        self.tableView.reloadData()
        self.tableView.removeLoadingFooter()
    }
    func insertViews(indexPaths: [IndexPath]) {
        self.tableView.insertRows(at: indexPaths, with: .none)
        tableView.removeLoadingFooter()
    }
    
    func showProgress(){
       showActivityIndicatory()
    }
    
    func endRefresh() {
        removeActivity()
    }
}
// MARK: - Tableview delegate and datasource methods
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  viewModel.loadMore(indexPath: indexPath) {
            tableView.addLoadingFooter()
        }
        
        let cell = ArtistTableViewCell.dequeue(tableView: tableView)
        cell.viewModel = viewModel.viewModel(for: indexPath)
        cell.configure()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowSelected(at: indexPath)
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ArtistTableViewCell , let imageUrl = cell.viewModel.artistImage(){
            ImageDownloadService.shared.downloadImage(imageUrl,indexPath:indexPath) { (image,index,error)  in
                DispatchQueue.main.async {
                    if let getIndexPath = index,let getImage = image, let getCell = tableView.cellForRow(at: getIndexPath) as? ArtistTableViewCell {
                        getCell.setArtistImage(getImage)
                    }
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // MARK: - Reduce the priority of the network operation in case the user scrolls and an image is no longer visible.
               DispatchQueue.main.async {
                   if let cell = cell as? ArtistTableViewCell , let imageUrl = cell.viewModel.artistImage() {
                       ImageDownloadService.shared.slowDownImageDownloadTaskfor(imageUrl)
                   }
               }
    }
}
// MARK: - searchbar delegates
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        thresHold?.invalidate()
        if !searchText.isEmpty {
            self.tableView.addLoadingFooter()
        }
        thresHold = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (timer) in
            self?.viewModel.getInitialSearchArtists(For: searchText)
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
