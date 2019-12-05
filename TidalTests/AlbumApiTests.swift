//
//  AlbumApiTests.swift
//  TidalTests
//
//  Created by Jawad on 04/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import XCTest
@testable import Tidal

class AlbumApiTests: XCTestCase {
    private  var albumsDataHandler =  AlbumsDataHandler()
    func testArtistAlbumsApi() {
            let albumExpectation = expectation(description: "ArtistAlbumExpectation")
           albumsDataHandler.searchAlbums(for: 1878) { (albums, refresh, error) in
            XCTAssertTrue(albums.count > 0)
               albumExpectation.fulfill()
           }
        
        let albumFailExpectation = expectation(description: "ArtistAlbumFailExpectation")
                  albumsDataHandler.searchAlbums(for: 187890000) { (albums, refresh, error) in
                   XCTAssertTrue(albums.count == 0)
                      albumFailExpectation.fulfill()
                  }
           waitForExpectations(timeout: 3, handler: nil)
       }
    
       
       
       func testAlbumsPerformance() {
           self.measure {
               let albumExpectation = expectation(description: "albumsApi")
              albumsDataHandler.searchAlbums(for: 1878) { (albums, refresh, error) in
                   albumExpectation.fulfill()
               }
               waitForExpectations(timeout: 3, handler: nil)
           }
           
       }


}
