//
//  DeezerService.swift
//  Tidal
//
//  Created by Jawad on 01/12/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
protocol DeezerService {
    func fetchArtists(for pageNumber: Int, pageSize: Int, searchKey:String, completion: @escaping(Result<[Artist]?,AppError>) -> Void)
    func fetchAlbum(for pageNumber: Int, pageSize: Int, artistID:Int, completion: @escaping(Result<[Album]?,AppError>) -> Void)
    func fetchAlbumDetail(for albumId:Int, completion: @escaping(Result<Album,AppError>) -> Void)
}

class DeezerServiceImp:DeezerService {
    private let apiConvertible:ApiService = APIClient()
    
    func fetchArtists(for pageNumber: Int, pageSize: Int, searchKey:String, completion: @escaping(Result<[Artist]?,AppError>) -> Void) {
        
        let request = ArtistRequest(pageNumber: pageNumber, pageSize: pageSize, searchString: searchKey)
        let router = Router.getArtist(request)
        apiConvertible.performRequest(router: router) { (result:Result<ArtistFeed, AppError>) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data.data))
                
            }
        }
    }
    func fetchAlbum(for pageNumber: Int, pageSize: Int, artistID:Int, completion: @escaping(Result<[Album]?,AppError>) -> Void) {
        
        let request = AlbumsRequest(pageNumber: pageNumber, pageSize: pageSize, artistId:artistID)
        let router = Router.getAlbums(request)
        apiConvertible.performRequest(router: router) { (result:Result<AlbumFeed, AppError>) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data.data))
                
            }
        }
    }
    
    func fetchAlbumDetail(for albumId:Int, completion: @escaping(Result<Album,AppError>) -> Void) {
        
        let request = AlbumDetailsRequest( albumId:albumId)
        let router = Router.getAlbumDetails(request)
        apiConvertible.performRequest(router: router) {(result:Result<Album, AppError>) in
            
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
                
            }
        }
    }
    
    
}
