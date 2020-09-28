//
//  FinishedWorkCell.swift
//  SmartVolunteer
//
//  Created by Sultan on 9/24/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import Cosmos

class FinishedWorkCell: UIView {

    let stackView = UIStackView()
    var data : Data?
    var profile: Profile?
    let icon = UIImageView(image: #imageLiteral(resourceName: "anonymous"))
    init(data: Data){//},profile: Profile) {
        super.init(frame: .zero)
        self.data = data
//        self.profile = profile
        life()
        setViews()
    }
    func life() {
        self.addSubview(stackView)
        stackView.easy.layout(Edges())
        stackView.setSpacing(top: 20, left: 20, right: 20, bottom: 20)
        stackView.setProperties(axis: .vertical, alignment: .fill, spacing: 20, distribution: .fill)
    }
    
    func setViews(){
//        let header = HeadUserInfoView()
//        stackView.addArrangedSubview(header)
        headViews()
        let title = UILabel()
        title.setProperties(text: data?.text ?? "", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), numberLines: 2)
        
        let moreButton = UIButton()
        moreButton.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1))
        moreButton.titleLabel?.textAlignment = .center
        moreButton.setTitleColor(#colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), for: .normal)
        moreButton.setTitle("Подробнее", for: .normal)
        moreButton.easy.layout(Height(48))
        moreButton.addTarget(self, action: #selector(moreAction(_:)), for: .touchUpInside)
        self.stackView.addArrangedSubview(title)
        self.stackView.addArrangedSubview(moreButton)
    }
    func headViews(){
        let headStack = UIStackView()
        let titleStack = UIStackView()
        let cosmosStack = UIStackView()
        headStack.setProperties(axis: .horizontal, alignment: .fill, spacing: 12, distribution: .fill)
        titleStack.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        cosmosStack.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        
        icon.layer.cornerRadius = 35
        icon.layer.masksToBounds = true
        icon.easy.layout(Width(70),Height(70))
        if let url = URL(string: data?.application?.user?.imgPath ?? "") {
            icon.sd_setImage(with: url, completed: nil)
        }
        let nameLabel = UILabel()
        let nameText = "\(data?.application?.user?.name ?? "Анонимно") \(data?.application?.user?.surname ?? "")"
        let name = nameText
        nameLabel.setProperties(text: name, textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), textAlignment: .left, numberLines: 1)
        
        let placeStack = UIStackView()
        placeStack.setProperties(axis: .horizontal, alignment: .fill, spacing: 8, distribution: .fill)
        let geoIcon = UIImageView(image: #imageLiteral(resourceName: "VectorGeo"))
        geoIcon.easy.layout(Width(13),Height(13))
        let cityLabel = UILabel()
        let cityText = data?.application?.city?.name ?? ""
        cityLabel.setProperties(text: cityText , textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
                  
        let cosmosView = CosmosView()
        cosmosView.settings.starMargin = 2
        cosmosView.settings.filledImage = #imageLiteral(resourceName: "Star")
        cosmosView.settings.emptyImage = #imageLiteral(resourceName: "StarEmpty")
        cosmosView.settings.starSize = 16
        cosmosView.easy.layout(Width(100),Height(15))
        cosmosView.settings.emptyColor = #colorLiteral(red: 1, green: 0.7921568627, blue: 0.05490196078, alpha: 1)
        cosmosView.settings.filledColor = #colorLiteral(red: 1, green: 0.7921568627, blue: 0.05490196078, alpha: 1)
        cosmosView.rating = Double(data?.mark ?? 0)
        cosmosView.settings.updateOnTouch = false
        cosmosStack.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        cosmosStack.addArrangedSubview(cosmosView)
        cosmosStack.addArrangedSubview(UIView())
        
        placeStack.addArrangedSubview(geoIcon)
        placeStack.addArrangedSubview(cityLabel)
        placeStack.addArrangedSubview(UIView())
        
        titleStack.addArrangedSubview(nameLabel)
        titleStack.addArrangedSubview(placeStack)
        titleStack.addArrangedSubview(UIView())
        
        
        
        
        headStack.addArrangedSubview(icon)
        headStack.addArrangedSubview(titleStack)
        headStack.addArrangedSubview(cosmosStack)
        stackView.addArrangedSubview(headStack)
    }
    @objc func moreAction(_ sender: UIButton){
        let bottomSheetVC =  FeedbackInfoVC()
        bottomSheetVC.profile = self.profile
        bottomSheetVC.data = self.data
        bottomSheetVC.icon.image = icon.image
        parentViewController?.present(bottomSheetVC, animated: true, completion: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
