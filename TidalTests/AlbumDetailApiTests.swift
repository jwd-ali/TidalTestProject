//
//  AlbumDetailApiTests.swift
//  TidalTests
//
//  Created by Jawad on 04/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import XCTest
@testable import Tidal

class AlbumDetailApiTests: XCTestCase {
 private let service = DeezerService()
  func testArtistAlbumsApi() {
          let albumDetailExpectation = expectation(description: "AlbumDetailExpectation")
         service.fetchAlbumDetail(for: 63646202) {result in
            switch result {
            case .failure(let error):
                XCTAssert(false, error.error)
            case .success:
                XCTAssert(true, "success")
            }
             albumDetailExpectation.fulfill()
         }
      
    let albumDetailFailExpectation = expectation(description: "albumDetailFailExpectation")
        service.fetchAlbumDetail(for: 636462020090900000) {result in
           switch result {
           case .failure(let error):
               XCTAssert(true, error.error)
           case .success(let album):
            XCTAssertTrue(album.id == nil)
           }
            albumDetailFailExpectation.fulfill()
        }
         waitForExpectations(timeout: 3, handler: nil)
     }
  
     
     
     func testAlbumsPerformance() {
         self.measure {
             let albumExpectation = expectation(description: "albumsApi")
            service.fetchAlbumDetail(for: 63646202) {result  in
                 albumExpectation.fulfill()
             }
             waitForExpectations(timeout: 3, handler: nil)
         }
         
     }



}
