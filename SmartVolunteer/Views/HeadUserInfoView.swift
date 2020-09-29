//
//  HeadUserInfoView.swift
//  SmartVolunteer
//
//  Created by Sultan on 9/25/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import Cosmos
import EasyPeasy

class HeadUserInfoView: UIView {

    var data : Data?
  
    init(data: Data) {
        super.init(frame: .zero)
        self.data = data
        headerView()
    }
    
    func headerView(){
        let mainStackView = UIStackView()
        let headerStackView = UIStackView()
        headerStackView.setProperties(axis: .horizontal, alignment: .fill, spacing: 15, distribution: .fill)
        mainStackView.setProperties(axis: .vertical, alignment: .fill, spacing: 15, distribution: .fill)
        
        let ava = UIImageView()
        ava.easy.layout(Width(48),Height(48))
        ava.cornerRadius(radius: 24, width: 0)
        ava.backgroundColor = .gray
        if let url = URL(string: data?.application?.user?.imgPath ?? "") {
            ava.sd_setImage(with: url, completed: nil)
        }
        let titleStackView = UIStackView()
        titleStackView.setProperties(axis: .vertical, alignment: .fill, spacing: 5, distribution: .fill)
        let name = UILabel()
        let user = data?.application?.user
        let nameText = (user?.name ?? "") + "" + (user?.surname ?? "")
        name.setProperties(text: nameText, textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold))
        
        let dateLabel = UILabel()
        
        dateLabel.setProperties(text: dateFormat(date: (data?.createdAt ?? "")), textColor: #colorLiteral(red: 0.5921568627, green: 0.6784313725, blue: 0.7137254902, alpha: 1), font: .systemFont(ofSize: 14))
        
        
        titleStackView.addArrangedSubview(name)
        titleStackView.addArrangedSubview(dateLabel)
        titleStackView.addArrangedSubview(UIView())
        
        let cosmosView = CosmosView()
        cosmosView.settings.starMargin = 2
        cosmosView.settings.filledImage = #imageLiteral(resourceName: "Star")
        cosmosView.settings.emptyImage = #imageLiteral(resourceName: "StarEmpty")
        cosmosView.settings.starSize = 16
        cosmosView.easy.layout(Width(100),Height(15))
        cosmosView.settings.emptyColor = #colorLiteral(red: 1, green: 0.7921568627, blue: 0.05490196078, alpha: 1)
        cosmosView.settings.filledColor = #colorLiteral(red: 1, green: 0.7921568627, blue: 0.05490196078, alpha: 1)
        cosmosView.settings.updateOnTouch = false
        cosmosView.rating = Double(data?.mark ?? 0)
        let cosmosStackView = UIStackView()
        cosmosStackView.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        cosmosStackView.addArrangedSubview(cosmosView)
        cosmosStackView.addArrangedSubview(UIView())
        
        headerStackView.addArrangedSubview(ava)
        headerStackView.addArrangedSubview(titleStackView)
        headerStackView.addArrangedSubview(UIView())
        headerStackView.addArrangedSubview(cosmosStackView)
        
        mainStackView.addArrangedSubview(headerStackView)
        
        let desc = UILabel()
        desc.setProperties(text: data?.text ?? "", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14),numberLines: 0)
        mainStackView.addArrangedSubview(desc)
        self.addSubview(mainStackView)
        mainStackView.easy.layout(Edges())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
