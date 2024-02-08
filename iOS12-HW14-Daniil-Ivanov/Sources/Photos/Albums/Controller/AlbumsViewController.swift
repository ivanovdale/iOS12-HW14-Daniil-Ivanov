//
//  ViewController.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import UIKit

fileprivate enum Constants {
    static let myAlbumsSectionHeaderTitle = "My Albums"
    static let peopleAndPlacesSectionHeaderTitle = "People & Places"
    static let myAlbumsSectionNumber = 0
    static let peopleAndPlacesSectionNumber = 1
    static let peopleAndPlacesSectionItemsNumber = 2
}

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
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Constants.peopleAndPlacesSectionNumber {
            return Constants.peopleAndPlacesSectionItemsNumber
        }
        return albums?[section].count ?? 0
    }

    // MARK: - Cells configuration

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return createAlbumCollectionViewCell(collectionView, indexPath: indexPath)
        case 1:
            return createPeopleOrPlacesViewCell(collectionView, indexPath: indexPath)
        default:
            return createAlbumCollectionViewCell(collectionView, indexPath: indexPath)
        }
    }

    private func createAlbumCollectionViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> AlbumCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as? AlbumCollectionViewCell
        cell?.data = albums?[indexPath.section][indexPath.row]
        return cell ?? AlbumCollectionViewCell()
    }

    private func createPeopleOrPlacesViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == Constants.peopleAndPlacesSectionItemsNumber - 1 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PlacesCollectionViewCell.identifier,
                for: indexPath) as? PlacesCollectionViewCell
            let myAlbums = albums?[Constants.myAlbumsSectionNumber] ?? []
            let myAlbumsMainPhotos = myAlbums.map { $0.mainPhotoName }
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

    // MARK: - Section header configuration

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: ElementKind.sectionHeader, withReuseIdentifier: AlbumsSectionHeader.identifier, for: indexPath) as? AlbumsSectionHeader
        switch indexPath.section {
        case 0:
            header?.isSeeAllButtonHidden = false
            header?.title = Constants.myAlbumsSectionHeaderTitle
        case 1:
            header?.isSeeAllButtonHidden = true
            header?.title = Constants.peopleAndPlacesSectionHeaderTitle
        default: break
        }

        return header ?? AlbumsSectionHeader()
    }
}
