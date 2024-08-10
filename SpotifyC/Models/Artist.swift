//
//  Artist.swift
//  Comp
//
// Created by Kaan Uzun on 4.05.2024.
//

import Foundation


struct Artist: Codable {
    let href: String
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
    let images: [APIImage]?
}
 
