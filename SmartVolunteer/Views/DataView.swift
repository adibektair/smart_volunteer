//
//  DataView.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/29/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class DataView: UIView {

    let nameLabel = UILabel()
    let dataLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(nameLabel)
        nameLabel.textColor = #colorLiteral(red: 0.5921568627, green: 0.6784313725, blue: 0.7137254902, alpha: 1)
        nameLabel.font = nameLabel.font.withSize(14)
        nameLabel.easy.layout(Left(18), CenterY())
        self.addSubview(dataLabel)
        dataLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dataLabel.font = nameLabel.font.withSize(15)
        dataLabel.easy.layout(CenterX(), CenterY())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
