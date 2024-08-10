//
//  AuthResponse.swift
//  Comp
//
// Created by Kaan Uzun on 4.05.2024.
//

import Foundation


struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}

