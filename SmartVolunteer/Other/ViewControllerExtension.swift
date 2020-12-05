//
//  ViewControllerExtension.swift
//  Tensend
//
//  Created by Sultan on 1/26/20.
//  Copyright © 2020 Sultan. All rights reserved.
//

import UIKit
import EasyPeasy
extension UIViewController {
    

    func makeNCTranslucent(top:CGFloat = -145){
        self.additionalSafeAreaInsets.top = top
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) 
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        let textAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    func showAlert(title: String, message: String, popToRoot : Bool? = false){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in
            if popToRoot ?? false{
                self.navigationController?.popViewController(animated: true)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setBackButton(named: String = "") {
           let backItem = UIBarButtonItem()
           backItem.title = named
           navigationItem.backBarButtonItem = backItem
       }
    func singleVibration(){
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
    }
    func setNavForTaraz(){
        if let nav = self.navigationController?.navigationBar,Constants.shared().isTaraz {
            nav.isTranslucent = false
            nav.barTintColor = #colorLiteral(red: 0, green: 0.3960784314, blue: 0.4274509804, alpha: 1)
            nav.tintColor = .white
            nav.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            nav.prefersLargeTitles = false
            if let tabBar = self.tabBarController?.tabBar {
                tabBar.selectedImageTintColor = #colorLiteral(red: 0, green: 0.3960784314, blue: 0.4274509804, alpha: 1)
            }
        } else if !Constants.shared().isTaraz {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    @objc func sideBarPressed(_ sender:UIBarButtonItem) {
        let v = SideBarView()
        if let view = (self.view.subviews.last as? SideBarView) {
            view.removeView()
        } else {
            self.view.addSubview(v)
        }
        v.easy.layout(Edges())
    }
    func sideBarButton(){
        if Constants.shared().isTaraz {
            let b = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(sideBarPressed(_:)))
            navigationItem.leftBarButtonItem = b
            navigationItem.leftBarButtonItem?.tintColor = Constants.shared().isTaraz ? UIColor.white : UIColor.black
        }
    }
    
}
