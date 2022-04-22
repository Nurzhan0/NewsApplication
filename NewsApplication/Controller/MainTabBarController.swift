//
//  MainTabBarContoller.swift
//  NewsApplication
//
//  Created by Nurzhan on 19.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
        
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor = UIColor.black.cgColor
        
        tabBar.tintColor = UIColor(red: 6/255, green: 108/255, blue: 219/255, alpha: 1)
        setupViewControllers()
    }
    
    func setupViewControllers() {
        print("Initial tab Bar")
        //Size of icon
        let configuration = UIImage.SymbolConfiguration(pointSize: 18)
        
        viewControllers = [
            wrapNavigationController(with: TopHeadlinesViewController(),
                                     tabTitle: "Top Headlines",
                                     tabImage: UIImage(systemName: "heart.text.square", withConfiguration: configuration)!),
            
            wrapNavigationController(with: AllNewsViewController(),
                                     tabTitle: "All News",
                                     tabImage: UIImage(systemName: "newspaper", withConfiguration: configuration)!),
            wrapNavigationController(with: SavedViewController(),
                                     tabTitle: "Saved News",
                                     tabImage: UIImage(systemName: "bookmark.fill", withConfiguration: configuration)!)
        ]
    }
    
    func wrapNavigationController(with rootViewController: UIViewController,
                                  tabTitle: String,
                                  tabImage: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = tabTitle
        navigationController.tabBarItem.image = tabImage
        return navigationController
    }
}
