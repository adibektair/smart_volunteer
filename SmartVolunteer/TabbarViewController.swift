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
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        if Constants.shared().getToken() != nil{
            if Constants.shared().isVolunteer(){
                self.volunteerTabBar()
            }else{
                self.baigusTabBar()
            }
        }else{
            self.anonimTabBar()
        }
    }
    func volunteerTabBar(){
        var controllers = [UIViewController]()
        let i = UITabBarItem(title: "", image: #imageLiteral(resourceName: "home"), tag: 0)
        let homeNav = UINavigationController()
        homeNav.addChild(NewsListVC())
        homeNav.tabBarItem = i
        controllers.append(homeNav)
        
        let icon2 = UITabBarItem(title: "", image: UIImage(named: "List.png"), tag: 1)
        let fundNav = UINavigationController()
        fundNav.addChild(FundsListVC())
        fundNav.tabBarItem = icon2
        controllers.append(fundNav)

        
        let icon22 = UITabBarItem(title: "", image: UIImage(named: "Black copy.png"), tag: 2)
        let app = UINavigationController()
        app.addChild(ApplicationsListVC())
        app.tabBarItem = icon22
        controllers.append(app)
        
        let icon4 = UITabBarItem(title: "", image: UIImage(named: "Profile.png"), tag: 4)
        let prof = UINavigationController()
        prof.addChild(ProfileViewController())
        prof.tabBarItem = icon4
        controllers.append(prof)
        
        self.viewControllers = controllers
                
    }
    func baigusTabBar(){
        var controllers = [UIViewController]()
        let i = UITabBarItem(title: "", image: #imageLiteral(resourceName: "home"), tag: 0)
        let homeNav = UINavigationController()
        homeNav.addChild(NewsListVC())
        homeNav.tabBarItem = i
        controllers.append(homeNav)
        let icon3 = UITabBarItem(title: "", image: nil, tag: 3)
        let create = UINavigationController()
        create.addChild(CreateApplicationVC())
        create.tabBarItem = icon3
        controllers.append(create)
        self.setupMiddleButton()
        let icon4 = UITabBarItem(title: "", image: UIImage(named: "Profile.png"), tag: 4)
        let prof = UINavigationController()
        prof.addChild(ProfileViewController())
        prof.tabBarItem = icon4
        controllers.append(prof)
        self.viewControllers = controllers
        
    }
    func anonimTabBar(){
        var controllers = [UIViewController]()
        let i = UITabBarItem(title: "", image: #imageLiteral(resourceName: "home"), tag: 0)
        let homeNav = UINavigationController()
        homeNav.addChild(NewsListVC())
        homeNav.tabBarItem = i
        controllers.append(homeNav)
        let icon3 = UITabBarItem(title: "", image: nil, tag: 3)
        let create = UINavigationController()
        create.addChild(CreateApplicationVC())
        create.tabBarItem = icon3
        controllers.append(create)
        self.setupMiddleButton()
        let icon4 = UITabBarItem(title: "", image: UIImage(named: "Profile.png"), tag: 4)
        let prof = UINavigationController()
        prof.addChild(ProfileViewController())
        prof.tabBarItem = icon4
        controllers.append(prof)
        self.viewControllers = controllers
        self.selectedIndex = 1
    }
    

    // Plus Button View
    func setupMiddleButton() {
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-35, y: -10, width: 70, height: 70))
        middleBtn.setImage(#imageLiteral(resourceName: "Component 4"), for: .normal)
        middleBtn.layer.cornerRadius = middleBtn.frame.size.height / 2
        middleBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        middleBtn.isUserInteractionEnabled = true
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        self.view.layoutIfNeeded()
    }
    // Plus Button Action
    @objc func menuButtonAction(sender: UIButton) {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [CreateApplicationVC()]
        self.present(navigationController, animated: true, completion: nil)
    }
}
