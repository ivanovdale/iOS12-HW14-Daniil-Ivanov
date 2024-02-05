//
//  Album.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import Foundation

struct Album {
    let title: String
    let mainPhotoName: String
    let photoCount: Int
    let isFavorite: Bool

    init(title: String, mainPhotoName: String, photoCount: Int, isFavorite: Bool = false) {
        self.title = title
        self.mainPhotoName = mainPhotoName
        self.photoCount = photoCount
        self.isFavorite = isFavorite
    }
}
