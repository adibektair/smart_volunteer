//
//  AnonimView.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/30/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class AnonimView: UIView {

    let stackview = UIStackView()
    let image = UIImageView(image: #imageLiteral(resourceName: "Team"))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setView()
    }
    func setView(){
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2)
        stackview.setSpacing(top: 30, left: 30, right: 30, bottom: 30)
        stackview.setProperties(axis: .vertical, alignment: .center, spacing: 25, distribution: .fill)
        let c = UIView()
        c.backgroundColor = .white
        c.cornerRadius(radius: 20, width: 0)
        self.addSubview(c)
        c.easy.layout(Left(24),Right(24),CenterY())
        c.addSubview(stackview)
        stackview.easy.layout(Edges())
        image.easy.layout(Width(200),Height(200))
        stackview.addArrangedSubview(image)
        let title = UILabel()
        title.setProperties(text: "Прежде чем получить доступ к данным модулям, сперва необходимо авторизоваться", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .center, numberLines: 5)
        stackview.addArrangedSubview(title)
        buttons()
      }
    func buttons(){
        let buttonsStackview = UIStackView()
        buttonsStackview.setProperties(axis: .horizontal, alignment: .fill, spacing: 10, distribution: .fill)
        let okButton = UILabel()
        okButton.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
        okButton.setProperties(text: "Ok", textColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), textAlignment: .center, numberLines: 1)
        okButton.addTapGestureRecognizer {
            self.removeFromSuperview()
        }
        buttonsStackview.addArrangedSubview(okButton)
        
        let goToAuth = UILabel()
        goToAuth.setProperties(text: "Перейти к авторизации", textColor: .white, font: .systemFont(ofSize: 14, weight: .bold), textAlignment: .center, numberLines: 1)
        goToAuth.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        buttonsStackview.addArrangedSubview(goToAuth)
        goToAuth.addTapGestureRecognizer {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "unauthorized"), object: nil)
            return
        }
        stackview.addArrangedSubview(buttonsStackview)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
