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
        stackView.setSpacing(top: 20, left: 20, right: 20, bottom: 20)
        stackView.setProperties(axis: .vertical, alignment: .fill, spacing: 20, distribution: .fill)
        
    }
    
    func setViews(){
        let header = HeadUserInfoView()
        stackView.addArrangedSubview(header)
        let title = UILabel()
        let text = "Действительно крутой волонтер, советую вам всем, не пожалеете жб, вот битоооооон"
        title.setProperties(text: text, textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), numberLines: 2)
        
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
    @objc func moreAction(_ sender: UIButton){
//        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(FeedbackInfoVC.panGesture(recognizer:)))
//        addGestureRecognizer(gesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
