Tidal Test Project  lets the user autocomplete search for artists, select an artist to see that artist's albums, and finally select an album to see its tracks and album info. User can play a preview of any track stream

This test project is written in easily-extendable architecture (MVVM-Coordinators) and is built with Xcode and written entirely in Latest Swift 5 and Latest iOS 13 It utilises Auto Layout and size classes for UI design. Uses nibs for cells to increase reusability 



### Technologies ###
* Xcode 11.2.1
* Swift(5.1) Latest
* Storyboard and Nibs for custom cells
* Support all Orientations
* Support iPhone and iPad using size classes
* Support dark Mode and light mode
* Lazy loading images from remote URLs using Operations and NSCache to improve performance
* AVPlayer to play remote stream 
* Codables , Result types  and other Protocol oriented approach with Interface segregation and Single responsibility’s 

### Smart Lazy Loading ###
Smart 'Lazy Loading' in UICollectionView or UITableView using NSOperation and NSOperationQueue in iOS
So in this project we can download the multiple images in any View (UICollectionView or UITableView) by optimising the performance of an app by using Operation and OperationQueue for concurrency. Following are the key point of this project  Smart Lazy Loading:
Creating image download Service. Prioritise the downloading based on the visibility of cells.

ImageDownloadService class will create a singleton instance and have NSCache instance to cache the images that have been downloaded.
We have inherited the Operation class to TOperation to mauled the functionality according to our need. I think the properties of the operation subclass are pretty clear in terms of functionality. We are monitoring operations changes of state by using KVO.

### Dark Mode iPhone ###
### Light Mode iPhone ###
### Dark Mode iPad ###
### Light Mode iPad ###
### Landscape Support ###
