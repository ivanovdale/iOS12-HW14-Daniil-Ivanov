//
//  AlbumCollectionViewCell.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import UIKit
import SnapKit

fileprivate enum Constants {
    static let titleFont = UIFont.systemFont(ofSize: 14)
    static let countFont = UIFont.systemFont(ofSize: 15)
    static let countTextColor = UIColor.lightGray
    static let imageSizeMultiplier = 0.8
    static let imageCornerRadius = 4.0
    static let favoriteImageName = "heart.fill"
    static let favoriteImageViewOffset = 5.0
    static let favoriteImageColor = UIColor.white
    static let infoStackOffset = 4.0
}

class AlbumCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumCollectionViewCell"

    var data: Album? {
        didSet {
            guard let data else { return }
            imageView.image = UIImage(named: data.mainPhotoName)
            titleLabel.text = data.title
            countLabel.text = String(data.photoCount)
            if data.isFavorite {
                addFavoriteImage()
            }
        }
    }

    // MARK: - Outlets

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.imageCornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleFont
        return label
    }()

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.countFont
        label.textColor = Constants.countTextColor
        return label
    }()

    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        stack.axis = .vertical
        stack.spacing = 1
        return stack
    }()

    private lazy var favoriteImageView: UIImageView = {
        let image = UIImage(systemName: Constants.favoriteImageName)?
            .withTintColor(Constants.favoriteImageColor, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        return imageView
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
        [imageView, infoStack].forEach { addSubview($0) }
    }

    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.height.equalTo(self).multipliedBy(Constants.imageSizeMultiplier)
            make.width.equalTo(imageView.snp.height)
        }
        infoStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constants.infoStackOffset)
            make.leading.bottom.equalTo(self)
        }
    }

    private func addFavoriteImage() {
        addSubview(favoriteImageView)
        favoriteImageView.snp.makeConstraints { make in
            make.leading.equalTo(imageView).offset(Constants.favoriteImageViewOffset)
            make.bottom.equalTo(imageView).offset(-Constants.favoriteImageViewOffset)
        }
    }
}
