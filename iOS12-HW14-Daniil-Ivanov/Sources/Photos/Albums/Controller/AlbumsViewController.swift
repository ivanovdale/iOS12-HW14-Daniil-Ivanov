//
//  ViewController.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import UIKit

final class AlbumsViewController: UIViewController {
    private var albums: [[Album]]?

    // MARK: - Lifecycle

    override func loadView() {
        let view = AlbumsView(frame: .zero)
        view.configureCollectionView(dataSource: self, delegate: self)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
    }

    // MARK: - Setup

    private func setupView() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped)
        )
        navigationItem.leftBarButtonItem = addButton
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Data

    private func loadData() {
        albums = AlbumsFactory.createAlbums()
    }

    // MARK: - Actions

    @objc private func addTapped() {
        print("Add button was tapped.")
    }

}

// MARK: - Extensions

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Sections and Cells count configuration

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        albums?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if section == AlbumsViewControllerConstants.peopleAndPlacesSectionNumber {
            return Constants.peopleAndPlacesSectionItemsCount
        }

        return albums?[section].count ?? 0
    }

    // MARK: - Cells configuration

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case AlbumsViewControllerConstants.myAlbumsSectionNumber:
            return createAlbumCollectionViewCell(collectionView, indexPath: indexPath)
        case AlbumsViewControllerConstants.peopleAndPlacesSectionNumber:
            return createPeopleOrPlacesViewCell(collectionView, indexPath: indexPath)
        case AlbumsViewControllerConstants.mediaTypesSectionNumber, AlbumsViewControllerConstants.utilitiesSectionNumber:
            return createMediaTypesAndUtilitiesCollectionViewListCell(collectionView, indexPath: indexPath)
        default:
            return createAlbumCollectionViewCell(collectionView, indexPath: indexPath)
        }
    }

    private func createAlbumCollectionViewCell(
        _ collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> AlbumCollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AlbumCollectionViewCell.identifier,
            for: indexPath
        ) as? AlbumCollectionViewCell

        cell?.data = albums?[indexPath.section][indexPath.row]

        return cell ?? AlbumCollectionViewCell()
    }

    private func createPeopleOrPlacesViewCell(
        _ collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> UICollectionViewCell {

        if indexPath == Constants.placesSectionItem {

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PlacesCollectionViewCell.identifier,
                for: indexPath
            ) as? PlacesCollectionViewCell

            let myAlbums = albums?[AlbumsViewControllerConstants.myAlbumsSectionNumber] ?? []
            let myAlbumsMainPhotos = myAlbums.map { $0.imageName }

            cell?.photoCount = myAlbums.compactMap { $0.photoCount }.reduce(0, +)
            cell?.mainImageName = myAlbumsMainPhotos[Int.random(in: 0..<myAlbumsMainPhotos.count)]

            return cell ?? PlacesCollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PeopleCollectionViewCell.identifier,
                for: indexPath) as? PeopleCollectionViewCell
            cell?.data = albums?[indexPath.section]
            
            return cell ?? PeopleCollectionViewCell()
        }
    }

    private func createMediaTypesAndUtilitiesCollectionViewListCell(
        _ collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> MediaTypesAndUtilitiesCollectionViewListCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MediaTypesAndUtilitiesCollectionViewListCell.identifier,
            for: indexPath
        ) as? MediaTypesAndUtilitiesCollectionViewListCell
        cell?.data = albums?[indexPath.section][indexPath.item]

        return cell ?? MediaTypesAndUtilitiesCollectionViewListCell()
    }

    // MARK: - Section header configuration

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: AlbumsSectionHeader.identifier,
            for: indexPath
        ) as? AlbumsSectionHeader

        switch indexPath.section {
        case AlbumsViewControllerConstants.myAlbumsSectionNumber:
            header?.isSeeAllButtonHidden = false
            header?.title = Constants.myAlbumsSectionHeaderTitle
            header?.onButtonPressed = { print("See all button pressed") }
        case AlbumsViewControllerConstants.peopleAndPlacesSectionNumber:
            header?.isSeeAllButtonHidden = true
            header?.title = Constants.peopleAndPlacesSectionHeaderTitle
        case AlbumsViewControllerConstants.mediaTypesSectionNumber:
            header?.isSeeAllButtonHidden = true
            header?.title = Constants.mediaTypesHeaderTitle
        case AlbumsViewControllerConstants.utilitiesSectionNumber:
            header?.isSeeAllButtonHidden = true
            header?.title = Constants.utilitiesHeaderTitle
        default: break
        }

        return header ?? AlbumsSectionHeader()
    }

    // MARK: - Item selection

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath == Constants.placesSectionItem {
            print("Places item pressed")
        } else if indexPath == Constants.peopleSectionItem {
            print("Peoples item pressed")
        } else {
            let item = albums?[indexPath.section][indexPath.item]
            guard let item else { return }
            print("Item \(item.title ?? "") pressed")
        }

        if indexPath.section == AlbumsViewControllerConstants.mediaTypesSectionNumber ||
            indexPath.section == AlbumsViewControllerConstants.utilitiesSectionNumber {

            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}

// MARK: - Constants

enum AlbumsViewControllerConstants {
    static let myAlbumsSectionNumber = 0
    static let peopleAndPlacesSectionNumber = 1
    static let mediaTypesSectionNumber = 2
    static let utilitiesSectionNumber = 3
}

fileprivate enum Constants {
    static let myAlbumsSectionHeaderTitle = "My Albums"
    static let peopleAndPlacesSectionHeaderTitle = "People & Places"
    static let mediaTypesHeaderTitle = "Media Types"
    static let utilitiesHeaderTitle = "Utilities"

    static let peopleAndPlacesSectionItemsCount = 2
    static let peopleSectionItem = IndexPath(item: 0, section: AlbumsViewControllerConstants.peopleAndPlacesSectionNumber)
    static let placesSectionItem = IndexPath(item: 1, section: AlbumsViewControllerConstants.peopleAndPlacesSectionNumber)
}
