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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        life()
        setViews()
    }
    func life() {
        self.addSubview(stackView)
        stackView.easy.layout(Edges())
        stackView.setProperties(axis: .vertical, alignment: .fill, spacing: 20, distribution: .fill)
        
    }
    func setViews(){
        headerView()
        bottomPart()
    }
    func headerView(){
        let headerStackView = UIStackView()
        headerStackView.setProperties(axis: .horizontal, alignment: .fill, spacing: 15, distribution: .fill)
        
        let ava = UIImageView()
        ava.cornerRadius(radius: 24, width: 0)
        ava.easy.layout(Width(48),Height(48))
        
        let titleStackView = UIStackView()
        titleStackView.setProperties(axis: .vertical, alignment: .fill, spacing: 5, distribution: .fill)
        let name = UILabel()
        name.setProperties(text: "name name", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold))
        
        let dateLabel = UILabel()
        dateLabel.setProperties(text: "date", textColor: #colorLiteral(red: 0.5921568627, green: 0.6784313725, blue: 0.7137254902, alpha: 1), font: .systemFont(ofSize: 14))
        
        titleStackView.addArrangedSubview(headerStackView)
        titleStackView.addArrangedSubview(dateLabel)
        titleStackView.addArrangedSubview(UIView())
        
        let cosmosView = CosmosView()
        cosmosView.easy.layout(Width(70),Height(15))
        cosmosView.settings.emptyColor = #colorLiteral(red: 1, green: 0.7921568627, blue: 0.05490196078, alpha: 1)
        cosmosView.settings.filledColor = #colorLiteral(red: 1, green: 0.7921568627, blue: 0.05490196078, alpha: 1)
        
        let cosmosStackView = UIStackView()
        cosmosStackView.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        cosmosStackView.addArrangedSubview(cosmosView)
        cosmosStackView.addArrangedSubview(UIView())
        
        headerStackView.addArrangedSubview(ava)
        headerStackView.addArrangedSubview(titleStackView)
        headerStackView.addArrangedSubview(UIView())
        headerStackView.addArrangedSubview(cosmosStackView)
        
        self.stackView.addArrangedSubview(headerStackView)
    }
    
    func bottomPart(){
        let title = UILabel()
        let text = "Действительно крутой волонтер, советую вам всем, не пожалеете жб, вот битоооооон"
        title.setProperties(text: text, textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), numberLines: 2)
        
        let moreButton = UIButton()
        moreButton.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1))
        moreButton.titleLabel?.textAlignment = .center
        moreButton.setTitleColor(#colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), for: .normal)
        moreButton.setTitle("Подробнее", for: .normal)
        self.stackView.addArrangedSubview(title)
        self.stackView.addArrangedSubview(moreButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
