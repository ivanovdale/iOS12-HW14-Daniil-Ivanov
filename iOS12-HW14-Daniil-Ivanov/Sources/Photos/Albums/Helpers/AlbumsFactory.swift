//
//  AlbumsFactory.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import Foundation

struct AlbumsFactory {
    static private func generateRandomCount() -> Int {
        Int.random(in: 10...500)
    }

    static func createAlbums() -> [[Album]] {
        [
            [
                Album(
                    title: Constants.recentsTitle,
                    imageName: Constants.recentsMainPhotoName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.favoritesTitle,
                    imageName: Constants.favoritesPhotoName,
                    photoCount: generateRandomCount(),
                    isFavorite: true
                ),
                Album(
                    title: Constants.familyReunionTitle,
                    imageName: Constants.familyReunionPhotoName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.memesTitle,
                    imageName: Constants.memesPhotoName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.universityTitle,
                    imageName: Constants.universityPhotoName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.ducksTitle,
                    imageName: Constants.ducksPhotoName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.facesTitle,
                    imageName: Constants.facesPhotoName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.humansTitle,
                    imageName: Constants.humansPhotoName,
                    photoCount: generateRandomCount()
                ),
            ],
            [
                Album(imageName: Constants.human1PhotoName),
                Album(imageName: Constants.human2PhotoName),
                Album(imageName: Constants.human3PhotoName),
                Album(imageName: Constants.human4PhotoName),
            ],
            [
                Album(
                    title: Constants.videosTitle,
                    imageName: Constants.videosImageName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.selfiesTitle,
                    imageName: Constants.selfiesImageName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.livePhotosTitle,
                    imageName: Constants.livePhotosImageName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.portraitTitle,
                    imageName: Constants.portraitImageName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.timelapseTitle,
                    imageName: Constants.timelapseImageName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.slomoTitle,
                    imageName: Constants.slomoImageName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.cinematicTitle,
                    imageName: Constants.cinematicImageName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.burstsTitle,
                    imageName: Constants.burstsImageName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.screenshotsTitle,
                    imageName: Constants.screenshotsImageName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.screenRecordingsTitle,
                    imageName: Constants.screenRecordingsImageName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.animatedTitle,
                    imageName: Constants.animatedImageName,
                    photoCount: generateRandomCount()
                ),
            ],
            [
                Album(
                    title: Constants.importsTitle,
                    imageName: Constants.importsImageName,
                    photoCount: generateRandomCount()
                ),
                Album(
                    title: Constants.hiddenTitle,
                    imageName: Constants.hiddenImageName,
                    photoCount: generateRandomCount(),
                    isLocked: true
                ),
                Album(
                    title: Constants.recentlyDeletedTitle,
                    imageName: Constants.recentlyDeletedImageName,
                    photoCount: generateRandomCount(),
                    isLocked: true
                ),
            ],
        ]
    }
}

// MARK: - Constants

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

    static let videosTitle = "Videos"
    static let selfiesTitle = "Selfies"
    static let livePhotosTitle = "Live Photos"
    static let portraitTitle = "Portrait"
    static let timelapseTitle = "Time-lapse"
    static let slomoTitle = "Slo-mo"
    static let cinematicTitle = "Cinematic"
    static let burstsTitle = "Bursts"
    static let screenshotsTitle = "Screenshots"
    static let screenRecordingsTitle = "Screen Recordings"
    static let animatedTitle = "Animated"

    static let importsTitle = "Imports"
    static let hiddenTitle = "Hidden"
    static let recentlyDeletedTitle = "Recently Deleted"

    // MARK: - Photo names

    static let recentsMainPhotoName = "photo1"
    static let familyReunionPhotoName = "photo2"
    static let favoritesPhotoName = "photo3"
    static let memesPhotoName = "photo4"
    static let universityPhotoName = "photo5"
    static let ducksPhotoName = "photo6"
    static let facesPhotoName = "photo7"
    static let humansPhotoName = "photo8"

    static let human1PhotoName = "photo9"
    static let human2PhotoName = "photo10"
    static let human3PhotoName = "photo11"
    static let human4PhotoName = "photo12"

    // MARK: - Image system names

    static let videosImageName = "video"
    static let selfiesImageName = "person.crop.square"
    static let livePhotosImageName = "livephoto"
    static let portraitImageName = "f.cursive.circle"
    static let timelapseImageName = "timelapse"
    static let slomoImageName = "slowmo"
    static let cinematicImageName = "video.bubble"
    static let burstsImageName = "square.stack.3d.down.right"
    static let screenshotsImageName = "camera.viewfinder"
    static let screenRecordingsImageName = "record.circle"
    static let animatedImageName = "square.stack.3d.forward.dottedline"

    static let importsImageName = "square.and.arrow.down"
    static let hiddenImageName = "eye.slash"
    static let recentlyDeletedImageName = "trash"
}
