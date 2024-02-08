//
//  PlacesCollectionViewCell.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 06.02.2024.
//

import UIKit
import SnapKit

final class PlacesCollectionViewCell: UICollectionViewCell {
    static let identifier = "PlacesCollectionViewCell"

    var photoCount: Int? {
        didSet {
            guard let photoCount else { return }
            titleSubtitleView.subTitle = String(photoCount)
        }
    }

    var mainImageName: String? {
        didSet {
            guard let mainImageName else { return }
            mainImageView.image = UIImage(named: mainImageName)
        }
    }

    // MARK: - Outlets

    private lazy var mapImageView: UIImageView = {
        let image = UIImage(named: "map")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = Constants.mapCornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleSubtitleView: TitleSubtitleView =  {
        let view = TitleSubtitleView()
        view.title = Constants.title
        return view
    }()

    private lazy var triangleImageView: UIImageView = {
        let image = UIImage(systemName: "arrowtriangle.down.fill")?.withTintColor(Constants.mainImageBorderColor, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        return imageView
    }()

    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.mainImageCornerRadius
        imageView.layer.borderColor = Constants.mainImageBorderColor.cgColor
        imageView.layer.borderWidth = Constants.mainImageBorderWidth
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        [
            mapImageView,
            titleSubtitleView,
            triangleImageView,
            mainImageView,
        ].forEach { addSubview($0) }
    }

    private func setupLayout() {
        mapImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self)
            make.width.equalTo(mapImageView.snp.height)
        }

        titleSubtitleView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self)
            make.top.equalTo(mapImageView.snp.bottom).offset(Constants.titleSubtitleOffset)
        }

        mainImageView.snp.makeConstraints { make in
            make.center.equalTo(mapImageView)
            make.height.width.equalTo(mapImageView).dividedBy(Constants.mainImageHeightScale)
        }

        triangleImageView.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(-8)
            make.centerX.equalTo(mainImageView.snp.centerX)
        }
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let title = "Places"
    static let mapCornerRadius = 6.0
    static let titleSubtitleOffset = 5.0
    static let mainImageHeightScale = 2.0
    static let mainImageCornerRadius = 6.0
    static let mainImageBorderColor = UIColor.white
    static let mainImageBorderWidth = 3.0
}
