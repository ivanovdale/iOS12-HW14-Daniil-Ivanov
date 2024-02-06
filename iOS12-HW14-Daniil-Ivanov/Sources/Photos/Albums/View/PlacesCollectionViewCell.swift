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

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        self.backgroundColor = .systemGreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupHierarchy() {

    }

    private func setupLayout() {

    }
}
