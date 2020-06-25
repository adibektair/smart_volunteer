//
//  CityCVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/25/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class CityCVC: UICollectionViewCell {
    
    let stackView = UIStackView()
    var name = UILabel()
    var icon = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addSubview(stackView)
        stackView.easy.layout(Edges())
        stackView.setSpacing(top: 8, left: 8, right: 8, bottom: 8)
        stackView.setProperties(axis: .horizontal, alignment: .fill, spacing: 7, distribution: .fill)
        name.setProperties(text: "Ala", textColor: .white, font: .systemFont(ofSize: 14, weight: .medium), textAlignment: .center, numberLines: 1)
        icon.easy.layout(Width(12),Height(12))
        self.cornerRadius(radius: 18, width: 1,color: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1))
    }
    
    func city(){
        backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(icon)
        icon.image = #imageLiteral(resourceName: "Almaty")
    }
    
    func addCity(){
        icon.image = #imageLiteral(resourceName: "Shape")
        name.text = "Добавить город"
        name.textColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        backgroundColor = .white
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(name)
        self.cornerRadius(radius: 18, width: 1,color: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1))
    }
}
