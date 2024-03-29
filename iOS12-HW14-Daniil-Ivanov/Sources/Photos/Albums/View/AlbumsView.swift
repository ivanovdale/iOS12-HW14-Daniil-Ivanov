//
//  AlbumsView.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import UIKit
import SnapKit

final class AlbumsView: UIView {

    // MARK: - Outlets

    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            AlbumCollectionViewCell.self,
            forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier
        )
        collectionView.register(
            PeopleCollectionViewCell.self,
            forCellWithReuseIdentifier: PeopleCollectionViewCell.identifier
        )
        collectionView.register(
            PlacesCollectionViewCell.self,
            forCellWithReuseIdentifier: PlacesCollectionViewCell.identifier
        )
        collectionView.register(
            MediaTypesAndUtilitiesCollectionViewListCell.self,
            forCellWithReuseIdentifier: MediaTypesAndUtilitiesCollectionViewListCell.identifier
        )
        collectionView.register(
            AlbumsSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: AlbumsSectionHeader.identifier
        )

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
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case AlbumsViewControllerConstants.myAlbumsSectionNumber:
                return createMyAlbumsLayoutSection()
            case AlbumsViewControllerConstants.peopleAndPlacesSectionNumber:
                return createPeopleAndPlacesLayoutSection()
            case AlbumsViewControllerConstants.mediaTypesSectionNumber, AlbumsViewControllerConstants.utilitiesSectionNumber:
                return createMediaTypesAndUtilitiesLayoutSection(
                    sectionIndex: sectionIndex,
                    layoutEnvironment: layoutEnvironment
                )
            default:
                return createMyAlbumsLayoutSection()
            }

        }

        // MARK: Section layout

        func createMyAlbumsLayoutSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 5, 
                bottom: 10,
                trailing: 5
            )

            // TODO: Не получилось заменить estimated на fractionalWidth, едет верстка. Не пойму почему так
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1 / 2.17),
                heightDimension: .estimated(220)
            )
            let layoutGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                repeatingSubitem: layoutItem,
                count: 2
            )

            let layoutSectionHeader = createLayoutSectionHeader()
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .groupPaging
            layoutSection.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 15,
                bottom: 20,
                trailing: 0
            )

            layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

            return layoutSection
        }

        func createPeopleAndPlacesLayoutSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1 / 2.2),
                heightDimension: .fractionalHeight(1)
            )
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1 / 2.05)
            )
            let layoutGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                repeatingSubitem: layoutItem,
                count: 2
            )
            layoutGroup.interItemSpacing = .fixed(5)

            let layoutSectionHeader = createLayoutSectionHeader()
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.orthogonalScrollingBehavior = .continuous
            layoutSection.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 15,
                bottom: 50,
                trailing: 0
            )

            layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

            return layoutSection
        }

        func createMediaTypesAndUtilitiesLayoutSection(
            sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment
        ) -> NSCollectionLayoutSection {
            let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)

            let layoutSection = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )

            layoutSection.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: 10,
                trailing: 0
            )

            // Set header.

            let layoutSectionHeader = createLayoutSectionHeader()
            layoutSectionHeader.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 15,
                bottom: 0,
                trailing: 0
            )

            layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

            return layoutSection
        }

        // MARK: Section header

        func createLayoutSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
            let layoutSectionHeaderSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1 / 1.03),
                heightDimension: .estimated(44)
            )
            let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: layoutSectionHeaderSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )

            return layoutSectionHeader
        }
    }
}
