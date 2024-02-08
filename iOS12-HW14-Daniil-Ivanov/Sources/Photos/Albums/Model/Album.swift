//
//  Album.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import Foundation

struct Album {
    let title: String?
    let imageName: String
    let photoCount: Int?
    let isFavorite: Bool
    let isLocked: Bool?

    init(
        title: String? = nil,
        imageName: String,
        photoCount: Int? = nil,
        isFavorite: Bool = false,
        isLocked: Bool? = nil
    ) {
        self.title = title
        self.imageName = imageName
        self.photoCount = photoCount
        self.isFavorite = isFavorite
        self.isLocked = isLocked
    }
}
