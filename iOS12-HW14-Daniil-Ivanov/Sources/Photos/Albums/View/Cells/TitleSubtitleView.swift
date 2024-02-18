//
//  TitleSubtitleView.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 07.02.2024.
//

import UIKit
import SnapKit

final class TitleSubtitleView: UIView {

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var subTitle: String? {
        didSet {
            subtitleLabel.text = subTitle
        }
    }

    // MARK: - Outlets

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleFont
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.subtitleFont
        label.textColor = Constants.subtitleTextColor
        return label
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
        [titleLabel, subtitleLabel].forEach { addSubview($0) }
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.subtitleOffset)
        }
    }

}

// MARK: - Constants

fileprivate enum Constants {
    static let titleFont = UIFont.systemFont(ofSize: 14)
    static let subtitleFont = UIFont.systemFont(ofSize: 15)
    static let subtitleTextColor = UIColor.lightGray
    static let subtitleOffset = 1.0
}
