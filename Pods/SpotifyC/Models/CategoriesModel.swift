//
//  CategoriesModel.swift
//  CloneSpotify
//
//  Created by Kaan Uzun on 7.05.2024.
//

import Foundation

struct CategoriesModel: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}
struct Category: Codable {
    let icons: [APIImage]
    let id: String
    let name: String
}
