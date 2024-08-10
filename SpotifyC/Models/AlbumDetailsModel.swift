//
//  AlbumDetailsModel.swift
//  Comp
//
// Created by Kaan Uzun on 4.05.2024.
//

import Foundation

struct AlbumDetailsModel: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let tracks: TracksResponse
    
    
}

struct TracksResponse: Codable {
    let items: [AudioTrack]
    
}
