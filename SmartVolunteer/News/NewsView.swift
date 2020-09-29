//
//  NewsView.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/23/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import SDWebImage

class NewsView: UIView {

    let titleStackView = UIStackView()
    let timeStackView = UIStackView()
    let stackView = UIStackView()
    let title = UILabel()
    let desc = UILabel()
    let time = UILabel()
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
        stackView.setProperties(axis: .horizontal, alignment: .fill, spacing: 10, distribution: .fill)
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.easy.layout(Width(80),Height(80))
        stackView.addArrangedSubview(image)
        image.image = #imageLiteral(resourceName: "GroupLogo")
        let img = URL(string: data?.imgPath ?? "")
        image.sd_setImage(with: img, completed: nil)
        titleStackView.setProperties(axis: .vertical, alignment: .fill, spacing: 8, distribution: .fill)
        let t = data?.title ?? ""
        let fullText = data?.fullText ?? ""
        title.setProperties(text: t, textColor: UIColor.titleDefault(UIColor())(), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 2)
        desc.setProperties(text: fullText, textColor: #colorLiteral(red: 0.5921568627, green: 0.6784313725, blue: 0.7137254902, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 2)
        titleStackView.addArrangedSubview(title)
        titleStackView.addArrangedSubview(desc)
        
        
        timeStackView.setProperties(axis: .horizontal, alignment: .leading, spacing: 5, distribution: .fill)
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "Clock")
        icon.easy.layout(Width(12),Height(12))
        timeStackView.addArrangedSubview(icon)
        let timeLabel = UILabel()
        let d = data?.createdAt ?? ""
        timeLabel.setProperties(text: dateFormat(date: d), textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 10))
        timeStackView.addArrangedSubview(timeLabel)
        titleStackView.addArrangedSubview(timeStackView)
        
        stackView.addArrangedSubview(titleStackView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension UIView {
    func dateFormat(date: String) -> String{
          let dateFormatterGet = DateFormatter()
          dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

          let dateFormatterPrint = DateFormatter()
          dateFormatterPrint.dateFormat = "dd MM yyyy"

          if let date = dateFormatterGet.date(from: date) {
              print(dateFormatterPrint.string(from: date))
              return dateFormatterPrint.string(from: date)
          } else {
             print("There was an error decoding the string")
              return ""
          }
      }
}
