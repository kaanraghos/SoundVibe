//
//  NewReleasesModel.swift
//  Comp
//
// Created by Kaan Uzun on 4.05.2024.
//

import Foundation

struct NewReleasesModel: Codable {
    let albums: AlbumsResponse
}
struct AlbumsResponse: Codable {
//    let href: String
    let items: [Album]
//    let limit: Int
//    let next: String
//    let previous: String
//    let offset: Int
//    let total: Int
    
}

struct Album: Codable {
    let album_type: String
    let available_markets: [String]
    let id: String
    var images: [APIImage]
    let name: String
    let release_date: String
//    let release_date_precision: String
    let total_tracks: Int
//    let type: String
  
    let artists: [Artist]
    
}

 
  
struct SaveAlbumResponse: Codable {
    let items: [AlbumItems]
}

struct AlbumItems: Codable {
    let album: Album
}
