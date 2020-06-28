//
//  SuccessView.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/28/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class SuccessView: UIView {
    
    init(buttonName:String, messsage:String,callBack: @escaping (() ->Void)) {
        super.init(frame: .zero)
        successView(buttonName: buttonName, message: messsage) {
            callBack()
        }
    }
    func successView(buttonName:String,message:String,callBack: @escaping (() ->Void)){
        let c = UIView()
        self.addSubview(c)
        c.backgroundColor = .white
        c.easy.layout(Edges())
        let s = UIStackView()
        c.addSubview(s)
        s.easy.layout(Edges())
        s.setProperties(axis: .vertical, alignment: .center, spacing: 40, distribution: .fill)
        s.setSpacing(top: 85, left: 50, right: 50, bottom: 0)
        let icon = UIImageView(image: #imageLiteral(resourceName: "Subtract"))
        icon.easy.layout(Width(150),Height(150))
        s.addArrangedSubview(icon)
        let t = UILabel()
        t.setProperties(text: message, textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 24, weight: .semibold), textAlignment: .center, numberLines: 5)
        s.addArrangedSubview(t)
        let close = UILabel()
        close.setProperties(text: buttonName, textColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), textAlignment: .center, numberLines: 1)
        close.easy.layout(Height(52),Width(220))
        close.cornerRadius(radius: 10, width: 1,color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
        s.addArrangedSubview(close)
        close.addTapGestureRecognizer {
            self.removeFromSuperview()
            callBack()
        }
        s.addArrangedSubview(UIView())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
  
}
