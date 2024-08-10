//
//  FeaturedPlayListModel.swift
//  CloneSpotify
//
//  Created by Kaan Uzun on 7.05.2024.
//

import Foundation

struct FeaturedPlaylistModel: Codable {
//    let message: String
    let playlists: PlayListResponse
}

struct PlayListResponse: Codable {
    let href: String
    let items: [Playlist]
}


struct User: Codable {
    let display_name: String
    let id: String
    let external_urls: [String: String]
    let type: String
}
                
           
