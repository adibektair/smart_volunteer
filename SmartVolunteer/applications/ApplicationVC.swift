//
//  ApplicationVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/26/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import SDWebImage

class ApplicationVC: ScrollStackController {
    
    let headStack = UIStackView()
    var data: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    func setViews(){
        headViews()
        stackView.setSpacing(top: 20, left: 20, right: 20, bottom: 70)
        let cont = UIView()
        cont.dropShadow()
        cont.backgroundColor = .white
        cont.layer.cornerRadius = 10
        cont.clipsToBounds = false
        
        let counterLabel = UILabel()
        cont.addSubview(counterLabel)
        let t = "\(data?.volunteerNumberAccessed ?? 0) из \(data?.volunteerNumber ?? 0) желающих"
        counterLabel.setProperties(text: t, textColor: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), textAlignment: .center, numberLines: 1)
        counterLabel.easy.layout(Edges(),Height(50))
        stackView.addArrangedSubview(cont)

        
        let categoryLabel = UILabel()
        let cText = "Категория: \(data?.category?.name ?? "")"
        categoryLabel.setProperties(text: cText, textColor: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
        stackView.addArrangedSubview(categoryLabel)
        
        let title = UILabel()
        title.setProperties(text: data?.descriptionField ?? "", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 0)
        stackView.addArrangedSubview(title)
        
        let proceedLabel = UILabel()
        proceedLabel.setProperties(text: "Подать заявку", textColor: .white, font: .systemFont(ofSize: 18, weight: .bold), textAlignment: .center, numberLines: 1)
        if data?.volunteer == nil {
            self.scrollView.addSubview(proceedLabel)
        }
        proceedLabel.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        proceedLabel.easy.layout(Left(),Bottom(),Right(),Height(60))
        proceedLabel.addTapGestureRecognizer {
            if let id = self.data?.id {
                self.startLoad()
                Requests.shared().acceptApplication(id: id) { (result) in
                    self.stopLoading()
                    if result?.success ?? false {
                        let t = "\((self.data?.volunteerNumberAccessed ?? 0) + 1) из \(self.data?.volunteerNumber ?? 0) желающих"
                        counterLabel.text = t
                        proceedLabel.isHidden = true
                    }
                }
            }
        }
    }
    
    func headViews(){
        let headStack = UIStackView()
        let titleStack = UIStackView()
        headStack.setProperties(axis: .horizontal, alignment: .fill, spacing: 12, distribution: .fill)
        titleStack.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        let icon = UIImageView(image: #imageLiteral(resourceName: "anonymous"))
        icon.layer.cornerRadius = 35
        icon.layer.masksToBounds = true
        icon.easy.layout(Width(70),Height(70))
        if let url = URL(string: data?.user?.imgPath ?? data?.fund?.imgPath ?? "") {
            icon.sd_setImage(with: url, completed: nil)
        }
        let nameLabel = UILabel()
        let name = data?.user?.name ?? data?.fund?.name ?? "Анонимно"
        nameLabel.setProperties(text: name, textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), textAlignment: .left, numberLines: 1)
        
        let placeStack = UIStackView()
        placeStack.setProperties(axis: .horizontal, alignment: .fill, spacing: 8, distribution: .fill)
        let geoIcon = UIImageView(image: #imageLiteral(resourceName: "VectorGeo"))
        geoIcon.easy.layout(Width(13),Height(13))
        let cityLabel = UILabel()
        cityLabel.setProperties(text: data?.city?.name ?? "", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
        
        placeStack.addArrangedSubview(geoIcon)
        placeStack.addArrangedSubview(cityLabel)
        placeStack.addArrangedSubview(UIView())
        
        titleStack.addArrangedSubview(nameLabel)
        titleStack.addArrangedSubview(placeStack)
        titleStack.addArrangedSubview(UIView())
        
        headStack.addArrangedSubview(icon)
        headStack.addArrangedSubview(titleStack)
        stackView.addArrangedSubview(headStack)
    }
    
    
    static func open(vc: UIViewController, data: Data){
        let viewController = ApplicationVC()
        viewController.data = data
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
