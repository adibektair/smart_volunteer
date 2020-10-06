//
//  RateVolunteerView.swift
//  SmartVolunteer
//
//  Created by Sultan on 10/6/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import Cosmos

class RateVolunteerView: UIView, UITextViewDelegate {

    var data: Data?
    var stackView = UIStackView()
    
    init(data: Data) {
        super.init(frame: .zero)
        self.data = data
        size()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func size(){
        stackView.setProperties(axis: .horizontal, alignment: .fill, spacing: 15, distribution: .fill)
        addSubview(stackView)
        stackView.easy.layout(Edges())
        iconView()
        feedbackView()
    }
    func iconView(){
        let iconstack = UIStackView()
        let icon = UIImageView()
        iconstack.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        iconstack.addArrangedSubview(icon)
        icon.easy.layout(Width(48),Height(48))
        icon.layer.cornerRadius = 24
        icon.layer.masksToBounds = true
        if let url = URL(string: data?.imgPath  ?? "") {
            icon.sd_setImage(with: url, completed: nil)
        }
        iconstack.addArrangedSubview(UIView())
        stackView.addArrangedSubview(iconstack)
    }
    func feedbackView(){
        let feedbackStackView = UIStackView()
        feedbackStackView.setProperties(axis: .vertical, alignment: .fill, spacing: 20, distribution: .fill)
        stackView.addArrangedSubview(feedbackStackView)
        let nameLabel = UILabel()
        nameLabel.text = "\((data?.name ?? "")) \(data?.surname ?? "")"
        feedbackStackView.addArrangedSubview(nameLabel)
        
        let cosmosView = CosmosView()
        cosmosView.settings.starMargin = 5
        cosmosView.settings.starSize = 30
        cosmosView.easy.layout(Width(100),Height(30))
        cosmosView.rating = Double(data?.mark ?? 0)
        cosmosView.didFinishTouchingCosmos = { rating in
            self.data?.mark = Int(rating)
        }
        feedbackStackView.addArrangedSubview(cosmosView)
        let textView = UITextView()
        textView.easy.layout(Height(120))
        textView.cornerRadius(radius: 10, width: 1,color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.5914117518))
        textView.delegate = self
        feedbackStackView.addArrangedSubview(textView)
        
    }
    @objc func textViewDidEndEditing(_ textView: UITextView) {
        self.data?.title = textView.text
    }
    func textViewDidChange(_ textView: UITextView) {
        self.data?.title = textView.text
    }
}
