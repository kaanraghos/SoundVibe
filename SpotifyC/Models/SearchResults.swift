//
//  SearchResults.swift
//  Comp
//
// Created by Kaan Uzun on 4.05.2024.
//

import Foundation

enum SearchResults {
    case album(model: Album)
    case artist(model: Artist)
    case playlist(model: Playlist)
    case track(model: AudioTrack)
}
