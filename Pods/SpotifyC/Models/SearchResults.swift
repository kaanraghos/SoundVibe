//
//  SearchResults.swift
//  CloneSpotify
//
//  Created by Kaan Uzun on 7.05.2024.
//

import Foundation

enum SearchResults {
    case album(model: Album)
    case artist(model: Artist)
    case playlist(model: Playlist)
    case track(model: AudioTrack)
}
