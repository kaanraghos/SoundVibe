//
//  PlaylistDeailsModel.swift
//  CloneSpotify
//
//  Created by Kaan Uzun on 7.05.2024.
//

import Foundation

struct PlaylistDeailsModel: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
    let tracks: PlaylistTracks
}
struct PlaylistTracks: Codable {
    let items: [PlaylistItems]
}
struct PlaylistItems: Codable {
    let track: AudioTrack
    
}



