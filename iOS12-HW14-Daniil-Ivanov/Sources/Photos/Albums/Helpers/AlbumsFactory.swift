//
//  AlbumsFactory.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import Foundation

fileprivate enum Constants {

    // MARK: - Titles

    static let recentsTitle = "Recents"
    static let familyReunionTitle = "Family Reunion"
    static let favoritesTitle = "Favorites"
    static let memesTitle = "Memes"
    static let universityTitle = "University"
    static let ducksTitle = "Ducks"
    static let facesTitle = "Faces"
    static let humansTitle = "Humans"

    // MARK: - Photo names

    static let recentsMainPhotoName = "photo1"
    static let familyReunionPhotoName = "photo2"
    static let favoritesPhotoName = "photo3"
    static let memesPhotoName = "photo4"
    static let universityPhotoName = "photo5"
    static let ducksPhotoName = "photo6"
    static let facesPhotoName = "photo7"
    static let humansPhotoName = "photo8"
}

struct AlbumsFactory {
    static private func generateRandomCount() -> Int {
        Int.random(in: 10...500)
    }

    static func createAlbums() -> [Album] {
        [
            Album(
                title: Constants.recentsTitle,
                mainPhotoName: Constants.recentsMainPhotoName,
                photoCount: generateRandomCount()
            ),
            Album(
                title: Constants.favoritesTitle,
                mainPhotoName: Constants.favoritesPhotoName,
                photoCount: generateRandomCount(),
                isFavorite: true
            ),
            Album(
                title: Constants.familyReunionTitle,
                mainPhotoName: Constants.familyReunionPhotoName,
                photoCount: generateRandomCount()
            ),
            Album(
                title: Constants.memesTitle,
                mainPhotoName: Constants.memesPhotoName,
                photoCount: generateRandomCount()
            ),
            Album(
                title: Constants.universityTitle,
                mainPhotoName: Constants.universityPhotoName,
                photoCount: generateRandomCount()
            ),
            Album(
                title: Constants.ducksTitle,
                mainPhotoName: Constants.ducksPhotoName,
                photoCount: generateRandomCount()
            ),
            Album(
                title: Constants.facesTitle,
                mainPhotoName: Constants.facesPhotoName,
                photoCount: generateRandomCount()
            ),
            Album(
                title: Constants.humansTitle,
                mainPhotoName: Constants.humansPhotoName,
                photoCount: generateRandomCount()
            ),
        ]
    }
}
