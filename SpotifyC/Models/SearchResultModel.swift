//
//  SearchResultModel.swift
//  Comp
//
// Created by Kaan Uzun on 4.05.2024.
//

import Foundation

struct SearchResultModel: Codable {
    let albums: searchAlbumModel
    let artists: searchArtistsModel
    let playlists: searchPlaylistsModel
    let tracks: searchTracksModel
}

struct searchAlbumModel: Codable {
    let items: [Album]
}
struct searchArtistsModel: Codable {
    let items: [Artist]
}
struct searchPlaylistsModel: Codable {
    let items: [Playlist]
}
struct searchTracksModel: Codable {
    let items: [AudioTrack]
}
