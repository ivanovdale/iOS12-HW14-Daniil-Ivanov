//
//  ViewController.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import UIKit

fileprivate enum Constants {
    static let myAlbumsSectionHeaderTitle = "My Albums"
}

final class AlbumsViewController: UIViewController {
    private var albums: [Album]?

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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as? AlbumCollectionViewCell
        cell?.data = albums?[indexPath.row]
        return cell ?? AlbumCollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: ElementKind.sectionHeader, withReuseIdentifier: AlbumsSectionHeader.identifier, for: indexPath) as? AlbumsSectionHeader
        header?.isSeeAllButtonHidden = false
        header?.title = Constants.myAlbumsSectionHeaderTitle

        return header ?? AlbumsSectionHeader()
    }
}
