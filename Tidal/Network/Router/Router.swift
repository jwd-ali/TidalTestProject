//
//  ArtistApiRouter.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation

struct ProductionServer {
    static var host = "api.deezer.com"
}
public protocol URLRequestConvertible {
    func urlRequest()  -> URLRequest?
}
enum Router<T>: URLRequestConvertible {
    
    case getAlbums(T)
    case getArtist(T)
    case getAlbumDetails(T)
    
   private var scheme: String {
        switch self {
        case .getAlbums, .getArtist, .getAlbumDetails:
            return "https"
        }
    }
   private var host: String {
        switch self {
        case .getAlbums, .getArtist, .getAlbumDetails:
            return ProductionServer.host
        }
    }
    private var path: String {
        switch self {
        case .getAlbums(let params):
            let request = params as! AlbumsRequest
            return  "/artist/\(request.artistId)/albums"
        case .getArtist:
            return "/search/artist"
        case .getAlbumDetails(let params):
            let request = params as! AlbumDetailsRequest
            return "/album/\(request.albumId)"
        }
    }
   private var method: String {
        switch self {
        case .getAlbums, .getArtist, .getAlbumDetails:
            return "GET"
        }
    }
   
    private var queryParameters: [URLQueryItem]? {
        switch self {
        case .getAlbums(let params):
            let request = params as! AlbumsRequest
            return [URLQueryItem(name: "index", value: String(request.pageNumber*request.pageSize)),
                    URLQueryItem(name: "limit", value: String(request.pageSize))]
            
            
        case .getArtist(let params):
            let request = params as! ArtistRequest
            return [URLQueryItem(name: "index", value: String(request.pageNumber*request.pageSize)),
                    URLQueryItem(name: "limit", value: String(request.pageSize)),
                    URLQueryItem(name: "q", value: request.searchString)]
            
        default:
            return nil
        }
    }
    func urlRequest() -> URLRequest? {
        
        
        var components = URLComponents()
        components.queryItems = queryParameters
        
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        
        guard let url = components.url else {
            assert(true,"url not formed")
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method
        
        return urlRequest
    }
}
