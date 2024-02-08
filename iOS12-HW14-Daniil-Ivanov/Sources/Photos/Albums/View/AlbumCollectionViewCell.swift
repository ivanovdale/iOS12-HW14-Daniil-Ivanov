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
    static let imageCornerRadius = 4.0
    static let favoriteImageName = "heart.fill"
    static let favoriteImageViewOffset = 5.0
    static let favoriteImageColor = UIColor.white
    static let titleSubtitleOffset = 5.0
}

final class AlbumCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumCollectionViewCell"

    var data: Album? {
        didSet {
            guard let data else { return }
            imageView.image = UIImage(named: data.mainPhotoName)
            titleSubtitleView.title = data.title
            titleSubtitleView.subTitle = String(data.photoCount ?? 0)
            favoriteImageView.isHidden = !data.isFavorite
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

    private lazy var titleSubtitleView: TitleSubtitleView =  {
        let view = TitleSubtitleView()
        return view
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
        [imageView, titleSubtitleView, favoriteImageView].forEach { addSubview($0) }
    }

    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self)
            make.width.equalTo(imageView.snp.height)
        }

        titleSubtitleView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constants.titleSubtitleOffset)
            make.leading.trailing.bottom.equalTo(self)
        }
        
        favoriteImageView.snp.makeConstraints { make in
            make.leading.equalTo(imageView).offset(Constants.favoriteImageViewOffset)
            make.bottom.equalTo(imageView).offset(-Constants.favoriteImageViewOffset)
        }
    }

    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteImageView.isHidden = true
    }
}
