//
//  ApplicationView.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/25/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import SDWebImage

class ApplicationView: UIView {
    
    let titleStackView = UIStackView()
    let infoStackView = UIStackView()
    let nameStackView = UIStackView()
    let stackView = UIStackView()
    let title = UILabel()
    let desc = UILabel()
    let authorLabel = UILabel()
    let countOf = UILabel()
    let image = UIImageView()
    var data : Data?
    
    init(data: Data) {
        super.init(frame: .zero)
        self.data = data
        setUI()
    }
    
    
    
    func setUI(){
        self.dropShadow()
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.addSubview(stackView)
        stackView.easy.layout(Edges(10))
        stackView.setSpacing(bottom: 10)
        stackView.setProperties(axis: .vertical, alignment: .fill, spacing: 16, distribution: .fill)
        infoStackView.setProperties(axis: .horizontal, alignment: .fill, spacing: 12, distribution: .fill)
        nameStackView.setProperties(axis: .horizontal, alignment: .fill, spacing: 12, distribution: .fill)
        let contAuth = UIView()
        contAuth.addSubview(authorLabel)
        contAuth.backgroundColor = data?.user != nil ? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1) : #colorLiteral(red: 0.9882352941, green: 0.06274509804, blue: 0.3333333333, alpha: 1)
        if data?.user == nil && data?.fund == nil {
            contAuth.backgroundColor = .gray
        }
        contAuth.layer.cornerRadius = 11
        authorLabel.easy.layout(Height(18),Left(8),Right(8),Top(2),Bottom(2))
        authorLabel.setProperties(text: data?.fund?.name ?? data?.user?.name ?? "Анонимно", textColor: .white, font: .systemFont(ofSize: 12, weight: .bold), textAlignment: .center, numberLines: 1)
        countOf.setProperties(text: "\(data?.volunteerNumberAccessed ?? 0) из \(data?.volunteerNumber ?? 0) желающих", textColor: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), font: .systemFont(ofSize: 12), textAlignment: .right, numberLines: 1)
        infoStackView.addArrangedSubview(contAuth)
        infoStackView.addArrangedSubview(UIView())
        infoStackView.addArrangedSubview(countOf)
        
        image.image = #imageLiteral(resourceName: "anonymous")
        if let url = URL(string: data?.fund?.imgPath ?? data?.user?.imgPath ?? "") {
            image.sd_setImage(with: url, completed: nil)
        }
        image.easy.layout(Height(40),Width(40))
        image.cornerRadius(radius: 20, width: 0)
        
        title.setProperties(text: data?.title ?? "", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14),numberLines: 2)
        nameStackView.addArrangedSubview(image)
        nameStackView.addArrangedSubview(title)
        let descText =  data?.descriptionField ?? "Акимат города Алматы просит всех желающих, помочь бездомным животным а также бездомным бомбам ко.."
        desc.setProperties(text: descText, textColor: #colorLiteral(red: 0.5921568627, green: 0.6784313725, blue: 0.7137254902, alpha: 1), font: .systemFont(ofSize: 12), textAlignment: .left, numberLines: 2)
        
        stackView.addArrangedSubview(infoStackView)
        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(desc)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
