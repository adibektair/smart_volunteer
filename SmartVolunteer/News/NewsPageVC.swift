//
//  NewsPageVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/25/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import SDWebImage

class NewsPageVC: ScrollStackController {

    let img = UIImageView()
    let timeToRead = UILabel()
    let titleLabel = UILabel()
    let date = UILabel()
    let viewsCount = UILabel()
    let descLabel = UILabel()
    var data : Data?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let h = (270 * UIScreen.main.bounds.width) / 375
        img.easy.layout(Height(h))
        stackView.setSpacing()
       
        let titlesStackView = UIStackView()
        titlesStackView.setProperties(axis: .vertical, alignment: .leading, spacing: 7, distribution: .fill)
        titlesStackView.setSpacing(left:20, right:20, bottom:12)
      
        let container = UIView()
        let ttr = data?.readMinutes ?? 0
        container.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.06274509804, blue: 0.3333333333, alpha: 1)
        container.layer.cornerRadius = 11
        timeToRead.setProperties(text: "Читать \(ttr) минуты", textColor: .white, font: .systemFont(ofSize: 12), textAlignment: .center, numberLines: 1)
        container.addSubview(timeToRead)
        timeToRead.easy.layout(Height(18),Left(8),Right(8),Top(2),Bottom(2))
        titlesStackView.addArrangedSubview(container)
      
        let title = data?.title ?? ""
        titleLabel.setProperties(text: title, textColor: .white, font: .systemFont(ofSize: 20, weight: .semibold), textAlignment: .left, numberLines: 0)
        img.addSubview(titlesStackView)
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        titlesStackView.easy.layout(Left(),Right(),Bottom())
        titlesStackView.addArrangedSubview(titleLabel)
      
        let imgUrl = URL(string: data?.imgPath ?? "")
        img.sd_setImage(with: imgUrl, completed: nil)
        stackView.addArrangedSubview(img)
        
        let infoStackView = UIStackView()
        infoStackView.setSpacing(left: 20, right: 20)
        infoStackView.setProperties(axis: .horizontal, alignment: .fill, spacing: 7, distribution: .fill)
     
        let timeIcon = UIImageView()
        timeIcon.image = #imageLiteral(resourceName: "Clock")
        timeIcon.easy.layout(Width(12),Height(12))
        infoStackView.addArrangedSubview(timeIcon)
      
        let created = data?.createdAt ?? ""
        date.setProperties(text: dateFormat(date: created), textColor: #colorLiteral(red: 0.5921568627, green: 0.6784313725, blue: 0.7137254902, alpha: 1), font: .systemFont(ofSize: 12), textAlignment: .left, numberLines: 1)
        infoStackView.addArrangedSubview(timeIcon)
        infoStackView.addArrangedSubview(date)
        infoStackView.addArrangedSubview(UIView())
        
        let eyeIcon = UIImageView()
        eyeIcon.image = #imageLiteral(resourceName: "Union")
        eyeIcon.contentMode = .scaleAspectFit
        eyeIcon.easy.layout(Width(16),Height(12))
        viewsCount.setProperties(text: "\(data?.viewsCount ?? 0)", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 12, weight: .semibold), textAlignment: .center, numberLines: 1)
        infoStackView.addArrangedSubview(eyeIcon)
        infoStackView.addArrangedSubview(viewsCount)
        stackView.addArrangedSubview(infoStackView)
        addLine()
        
        let descContainer = UIView()
        descContainer.addSubview(descLabel)
        descLabel.easy.layout(Left(20),Right(20),Top(),Bottom())
        descLabel.setProperties(text: data?.fullText ?? "" , textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 0)
        stackView.addArrangedSubview(descContainer)
    }
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

    static func open(vc: UIViewController, data: Data){
        let viewController = NewsPageVC()
        viewController.data = data
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }

}
