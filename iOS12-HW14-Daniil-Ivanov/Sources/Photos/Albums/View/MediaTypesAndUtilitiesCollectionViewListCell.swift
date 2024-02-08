//
//  MediaTypesAndUtilitiesCollectionViewListCell.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 08.02.2024.
//

import UIKit

// MARK: - Constants

fileprivate enum Constants {
    static let imageTintColor = UIColor.systemBlue
    static let disclosureIndicatorTintColor = UIColor.lightGray
    static let lockImageName = "lock.fill"
    static let lockImageColor = UIColor.lightGray
}

final class MediaTypesAndUtilitiesCollectionViewListCell: UICollectionViewListCell {
    static let identifier = "MediaTypesAndUtilitiesCollectionViewListCell"

    var data: Album? {
        didSet {
            configureView()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup

    private func setupView() {
        setupDisclosureIndicator()
    }

    private func setupDisclosureIndicator() {
        let disclosureIndicatorOptions = UICellAccessory.DisclosureIndicatorOptions(
            tintColor: Constants.disclosureIndicatorTintColor
        )
        let disclosureIndicator = UICellAccessory.disclosureIndicator(options: disclosureIndicatorOptions)

        accessories = [disclosureIndicator]
    }

    private func configureView() {
        guard let data else { return }

        // Text and image.

        var content = defaultContentConfiguration()
        content.image = UIImage(systemName: data.imageName)
        content.text = data.title
        content.imageProperties.tintColor = Constants.imageTintColor

        contentConfiguration = content
        
        // Photo count or lock label.

        let additionalAccessory: UICellAccessory
        if data.isLocked == true {
            let image = UIImage(systemName: Constants.lockImageName)?
                .withTintColor(Constants.lockImageColor, renderingMode: .alwaysOriginal)
            let imageView = UIImageView(image: image)
            let viewConfiguration = UICellAccessory.CustomViewConfiguration(
                customView: imageView,
                placement: .trailing()
            )

            additionalAccessory = .customView(configuration: viewConfiguration)
        } else {
            additionalAccessory = .label(text: String(data.photoCount ?? 0))
        }

        accessories.insert(additionalAccessory, at: 0)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setupDisclosureIndicator()
    }
}
