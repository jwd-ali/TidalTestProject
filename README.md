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
<p align="center">
<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPhone%20darkMode/Screenshot%202019-12-04%20at%2011.27.06%20PM.png" width="200" title=“Search Artist”>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPhone%20darkMode/Screenshot%202019-12-04%20at%2011.27.33%20PM.png" width="200" title=“Artist Albums”>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPhone%20darkMode/Screenshot%202019-12-04%20at%2011.28.18%20PM.png" width="200" title=“Album detail”>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPhone%20darkMode/Screenshot%202019-12-05%20at%2012.22.30%20AM.png" width="200" title=“Music Playing”></p>

### Light Mode iPhone ###
<p align="center">
<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPhone%20LightMode/Screenshot%202019-12-04%20at%2011.29.03%20PM.png" width="275" title=“Search Artist”>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPhone%20LightMode/Screenshot%202019-12-04%20at%2011.29.26%20PM.png" width="275" title=“Artist Albums”>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPhone%20LightMode/Screenshot%202019-12-04%20at%2011.30.15%20PM.png" width="275" title=“Album detail”></p>

### Dark Mode iPad ###
  <p align="center">
<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPad%20darkMode/Screenshot%202019-12-05%20at%2012.27.27%20AM.png" width="230" title=“Search Artist”>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPad%20darkMode/Screenshot%202019-12-05%20at%2011.10.43%20AM.png" width="230" title=“Artist Albums”>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPad%20darkMode/Screenshot%202019-12-05%20at%2012.27.13%20AM.png" width="230" title=“Album detail”></p>

### Light Mode iPad ###
<p align="center">
<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPad%20light%20mode/Screenshot%202019-12-05%20at%2012.25.44%20AM.png" width="230" title=“Search Artist”>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPad%20light%20mode/Screenshot%202019-12-05%20at%2012.26.01%20AM.png" width="230" title=“Artist Albums”>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/iPad%20light%20mode/Screenshot%202019-12-05%20at%2012.26.16%20AM.png" width="230" title=“Album detail”>
</p>

### Landscape Support ###
 <p align="center">
<img src="https://github.com/jwd-ali/TidalTestProject/blob/master/images/landscape/Screenshot%202019-12-05%20at%2012.27.43%20AM.png" width="800" title=“Landscape”></p>

### Thank You ###
# [Jawad Ali](https://github.com/jwd-ali/IOS-Portfolio)
