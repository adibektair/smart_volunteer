//
//  UserProfileVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 12/31/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import Cosmos

class UserProfileVC: ScrollStackController {

    var profile: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI(){
        setAva()
        setCosmos()
        userInfo()
    }
    func setAva() {
        let c = UIView()
        let ava = UIImageView()
        ava.layer.cornerRadius = 25
        c.addSubview(ava)
        ava.easy.layout(Width(50),Height(50),CenterX(),Top(),Bottom())
        stackView.addArrangedSubview(c)
    }
    func setCosmos() {
        let cosmosStack = UIStackView()
        cosmosStack.setProperties(axis: .vertical, alignment: .center, spacing: 10, distribution: .fill)
        let cosmosView = CosmosView()
        cosmosView.settings.starMargin = 2
        cosmosView.settings.filledImage = #imageLiteral(resourceName: "Star")
        cosmosView.settings.emptyImage = #imageLiteral(resourceName: "StarEmpty")
        cosmosView.settings.starSize = 16
        cosmosView.easy.layout(Width(100),Height(15))
        cosmosView.settings.emptyColor = #colorLiteral(red: 1, green: 0.7921568627, blue: 0.05490196078, alpha: 1)
        cosmosView.settings.filledColor = #colorLiteral(red: 1, green: 0.7921568627, blue: 0.05490196078, alpha: 1)
        cosmosView.rating = Double(profile?.ratingScore ?? 0)
        cosmosView.settings.updateOnTouch = false
        cosmosStack.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        cosmosStack.addArrangedSubview(cosmosView)
//        cosmosStack.addArrangedSubview(UIView())
        stackView.addArrangedSubview(cosmosStack)
    }
    func userInfo(){
        let c = UIView()
        let st = UIStackView()
        st.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        c.cornerRadius(radius: 10, width: 0)
        c.dropShadow()
        c.addSubview(st)
        st.easy.layout(Edges(5))
        if let name = profile?.name {
            st.addArrangedSubview(labelStack(title: "Имя", info: name))
        }
        if let surname = profile?.surname {
            st.addArrangedSubview(labelStack(title: "Фамилия", info: surname))
        }
        if let info = profile?.phone {
            st.addArrangedSubview(labelStack(title: "Телефон", info: info))
        }
//        if let info = profile?.city {
//            st.addArrangedSubview(labelStack(title: "Город", info: info))
//        }
        stackView.addArrangedSubview(c)
        
    }
    
    func labelStack(title: String, info: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.setProperties(text: title, font: UIFont.systemFont(ofSize: 15, weight: .light))
        let infoLabel = UILabel()
        infoLabel.setProperties(text: info, font: .systemFont(ofSize: 15, weight: .medium))
        let st = UIStackView()
        st.setProperties(axis: .horizontal, alignment: .fill, spacing: 12, distribution: .fill)
        st.addArrangedSubview(titleLabel)
        st.addArrangedSubview(UIView())
        st.addArrangedSubview(infoLabel)
        return st
    }
    static func open(vc:UIViewController, profile: User) {
          let m = UserProfileVC()
          m.profile = profile
          if let nav = vc.navigationController {
              nav.pushViewController(m, animated: true)
          }
      }

}
