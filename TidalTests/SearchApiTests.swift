//
//  SearchApiTests.swift
//  TidalTests
//
//  Created by Jawad on 04/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import XCTest
@testable import Tidal

class SearchApiTests: XCTestCase {
    private  var searchArtistDataHandler =  SearchArtistsDataHandler()
    func testSearchArtistApi() {
            let searchExpectation = expectation(description: "SearchArtistExpectation")
           searchArtistDataHandler.searchArtists(for: "prince") {(artists, refresh, error) in
                 XCTAssertTrue(artists.first?.name?.lowercased() == "prince")
               searchExpectation.fulfill()
           }
           
           let searchfailExpectation = expectation(description: "SearchArtistFailExpectation")
                  searchArtistDataHandler.searchArtists(for: "647ghgfghefghef hfehfcghe cfghecfghw cefghwfgcgfhc hwcghfc ghwcfgh") {(artists, refresh, error) in
                        XCTAssertTrue(artists.count == 0)
                      searchfailExpectation.fulfill()
                  }

           waitForExpectations(timeout: 3, handler: nil)
       }
    
       
       
       func testSearchPerformance() {
           self.measure {
               let searchExpectation = expectation(description: "search")
               searchArtistDataHandler.searchArtists(for: "prince") {(artists, refresh, error) in
                   searchExpectation.fulfill()
               }
               waitForExpectations(timeout: 3, handler: nil)
           }
           
       }

 

}
