//
//  NewsView.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/23/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class NewsView: UIView {

    let titleStackView = UIStackView()
    let timeStackView = UIStackView()
    let stackView = UIStackView()
    let title = UILabel()
    let desc = UILabel()
    let time = UILabel()
    let image = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    
    func setUI(){
        self.dropShadow()
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.addSubview(stackView)
        stackView.easy.layout(Edges(10))
        stackView.setProperties(axis: .horizontal, alignment: .fill, spacing: 10, distribution: .fill)
        image.layer.cornerRadius = 5
        image.easy.layout(Width(80),Height(80))
        stackView.addArrangedSubview(image)
        image.image = #imageLiteral(resourceName: "GroupLogo")
        image.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.3660012462)
        titleStackView.setProperties(axis: .vertical, alignment: .fill, spacing: 8, distribution: .fill)
        title.setProperties(text: "asdlkfjn", textColor: UIColor.titleDefault(UIColor())(), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 2)
        desc.setProperties(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem...", textColor: #colorLiteral(red: 0.5921568627, green: 0.6784313725, blue: 0.7137254902, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 2)
        titleStackView.addArrangedSubview(title)
        titleStackView.addArrangedSubview(desc)
        
        timeStackView.setProperties(axis: .horizontal, alignment: .leading, spacing: 5, distribution: .fill)
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "Clock")
        icon.easy.layout(Width(12),Height(12))
        timeStackView.addArrangedSubview(icon)
        let timeLabel = UILabel()
        timeLabel.setProperties(text: "3 minutes", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 10))
        timeStackView.addArrangedSubview(timeLabel)
        titleStackView.addArrangedSubview(timeStackView)
        
        stackView.addArrangedSubview(titleStackView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
