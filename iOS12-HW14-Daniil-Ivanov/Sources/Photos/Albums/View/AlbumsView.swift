//
//  AlbumsView.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import UIKit
import SnapKit

class AlbumsView: UIView {

    // MARK: - Outlets

    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
        collectionView.register(AlbumsSectionHeader.self, forSupplementaryViewOfKind: ElementKind.sectionHeader, withReuseIdentifier: AlbumsSectionHeader.identifier)
        return collectionView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupHierarchy() {
        addSubview(collectionView)
    }

    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.top.trailing.bottom.equalTo(self)
        }
    }
    // MARK: - Collection view configuration

    func configureCollectionView(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }

    // MARK: Layout configuration

    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            return createMyAlbumsLayoutSection()
        }

        func createMyAlbumsLayoutSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.46), heightDimension: .estimated(215))
            let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: layoutItem, count: 2)
            layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)

            let layoutSectionHeader = createLayoutSectionHeader()
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .groupPaging
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 20, trailing: 0)
            layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

            return layoutSection
        }

        func createLayoutSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
            let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.97), heightDimension: .estimated(45))
            let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: layoutSectionHeaderSize,
                elementKind: ElementKind.sectionHeader,
                alignment: .top
            )
            return layoutSectionHeader
        }
    }
}

