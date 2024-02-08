//
//  ViewController.swift
//  iOS12-HW14-Daniil-Ivanov
//
//  Created by Daniil (work) on 05.02.2024.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setSelectedIndex()
    }

    // MARK: - Setup

    private func setupViewControllers() {
        let libraryTabBarItem = UITabBarItem(
            title: Constants.libraryTitle,
            image: UIImage(systemName: Constants.libraryImageName),
            selectedImage: UIImage(systemName: Constants.librarySelectedImageName)
        )
        let libraryViewController = EmptyViewController()
        libraryViewController.title = Constants.libraryTitle
        libraryViewController.tabBarItem = libraryTabBarItem

        let forYouTabBarItem = UITabBarItem(
            title: Constants.forYouTitle,
            image: UIImage(systemName: Constants.forYouImageName),
            selectedImage: UIImage(systemName: Constants.forYouSelectedImageName)
        )
        let forYouViewController = EmptyViewController()
        forYouViewController.title = Constants.forYouTitle
        forYouViewController.tabBarItem = forYouTabBarItem

        let albumsTabBarItem = UITabBarItem(
            title: Constants.albumsTitle,
            image: UIImage(systemName: Constants.albumsImageName),
            selectedImage: UIImage(systemName: Constants.albumsSelectedImageName)
        )
        let albumsViewController = AlbumsViewController()
        albumsViewController.title = Constants.albumsTitle
        albumsViewController.tabBarItem = albumsTabBarItem

        let searchTabBarItem = UITabBarItem(
            title: Constants.searchTitle,
            image: UIImage(systemName: Constants.searchImageName),
            selectedImage: UIImage(systemName: Constants.searchSelectedImageName)
        )
        let searchViewController = EmptyViewController()
        searchViewController.title = Constants.searchTitle
        searchViewController.tabBarItem = searchTabBarItem

        let controllers = [
            libraryViewController,
            forYouViewController,
            albumsViewController,
            searchViewController,
        ]
        viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    }

    private func setSelectedIndex() {
        let tabsCount = viewControllers?.count ?? 0
        if tabsCount > 2 {
            selectedIndex = tabsCount - 2
        }
    }

}

// MARK: - Constants

fileprivate enum Constants {
    static let libraryTitle = "Library"
    static let forYouTitle = "For you"
    static let albumsTitle = "Albums"
    static let searchTitle = "Search"

    static let libraryImageName = "photo.on.rectangle"
    static let forYouImageName = "heart.text.square"
    static let albumsImageName = "rectangle.stack"
    static let searchImageName = "magnifyingglass"

    static let librarySelectedImageName = "photo.on.rectangle.fill"
    static let forYouSelectedImageName = "heart.text.square.fill"
    static let albumsSelectedImageName = "rectangle.stack.fill"
    static let searchSelectedImageName = "magnifyingglass.fill"
}
