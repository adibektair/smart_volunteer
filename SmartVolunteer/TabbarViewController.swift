//
//  TabbarViewController.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/24/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var controllers = [UIViewController]()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        let icon1 = UITabBarItem(title: "Басты бет", image: UIImage(named: "home.png"), selectedImage: #imageLiteral(resourceName: "GroupLogo"))
        
        let homeNav = UINavigationController()
        homeNav.addChild(NewsListVC())
        homeNav.tabBarItem = icon1
        controllers.append(homeNav)
        
        let icon2 = UITabBarItem(title: "Фонды", image: UIImage(named: "home.png"), selectedImage: #imageLiteral(resourceName: "GroupLogo"))
        
        let fundNav = UINavigationController()
        fundNav.addChild(FundsListVC())
        fundNav.tabBarItem = icon2
        controllers.append(fundNav)
        
        self.viewControllers = controllers
        
    }
    
}
