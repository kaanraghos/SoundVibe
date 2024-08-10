//
//  SettingsModel.swift
//  Comp
//
// Created by Kaan Uzun on 4.05.2024.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}

