//
//  PeopleAndPlacesCollectionViewCell.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import UIKit
import SnapKit

final class PeopleCollectionViewCell: UICollectionViewCell {
    private enum Constants {
        static let imageHorizontalSpacing = 2.0
        static let title = "People"
        static let titleSubtitleOffset = 5.0
    }

    static let identifier = "PeopleCollectionViewCell"
    private let imageCount = 4
    private let imagesNumberInRow = 2

    var data: [Album]? {
        didSet {
            guard let data, data.count == imageCount else { return }
            data.enumerated().forEach { (index, value) in
                imageViews[index].image = UIImage(named: value.mainPhotoName)
            }
            titleSubtitleView.subTitle = String(data.count)
        }
    }

    // MARK: - Outlets

    private lazy var imageViews: [UIImageView] = {
        var views: [UIImageView] = []
        for _ in 0..<imageCount {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            views.append(imageView)
        }
        return views
    }()

    private lazy var horizontalStacks: [UIStackView] = {
        var views: [UIStackView] = []
        for _ in 0..<imagesNumberInRow {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.clipsToBounds = true
            stackView.spacing = Constants.imageHorizontalSpacing
            views.append(stackView)
        }
        return views
    }()

    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var titleSubtitleView: TitleSubtitleView =  {
        let view = TitleSubtitleView()
        view.title = Constants.title
        return view
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
        var imageCounter = 0
        horizontalStacks.forEach {
            // Наполнение внутренних стеков.
            for _ in 0..<imagesNumberInRow {
                $0.addArrangedSubview(imageViews[imageCounter])
                imageCounter += 1
            }
            // Добавление внутренних стеков в главный стек.
            mainStack.addArrangedSubview($0)
        }
        [mainStack, titleSubtitleView].forEach { addSubview($0) }
    }

    private func setupLayout() {
        mainStack.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self)
            make.width.equalTo(mainStack.snp.height)
        }
        
        titleSubtitleView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self)
            make.top.equalTo(mainStack.snp.bottom).offset(Constants.titleSubtitleOffset)
        }

    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        configureImageViewCornerRadius()
    }

    private func configureImageViewCornerRadius() {
        imageViews.forEach {
            $0.layer.cornerRadius = mainStack.frame.height / Double(2 * imagesNumberInRow)
        }
    }
}
