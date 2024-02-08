//
//  MyAlbumsSectionHeader.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import UIKit
import SnapKit

typealias VoidClosure = () -> Void

final class AlbumsSectionHeader: UICollectionReusableView {
    static let identifier = "MyAlbumsSectionHeader"

    var isSeeAllButtonHidden: Bool = true {
        didSet {
            seeAllButton.isHidden = isSeeAllButtonHidden
        }
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var onButtonPressed: VoidClosure? {
        didSet {
            seeAllButton.addTarget(
                self,
                action: #selector(onSeeAllButtonPressed), 
                for: .touchUpInside
            )
        }
    }

    // MARK: - Outlets

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.separatorColor
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleFont
        return label
    }()

    private lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.seeAll, for: .normal)
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupHierarchy() {
        [separatorView, titleLabel, seeAllButton].forEach { addSubview($0)}
    }

    private func setupLayout() {
        separatorView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self)
            make.height.equalTo(Constants.separatorHeight)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(Constants.titleOffset)
            make.leading.equalTo(self)
        }
        seeAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalTo(self).offset(-Constants.buttonOffset)
        }
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        seeAllButton.isHidden = true
    }

    // MARK: - Actions

    @objc private func onSeeAllButtonPressed() {
        onButtonPressed?()
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let separatorColor = UIColor.lightGray
    static let titleFont = UIFont.systemFont(ofSize: 20, weight: .bold)
    static let seeAll = "See all"
    static let titleOffset = 10.0
    static let buttonOffset = 10.0
    static let separatorHeight = 1.0
}
