//
//  GeneralButton.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/23/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class GeneralButton: UIButton {

    var title : String?{
        didSet{
            self.setTitle(self.title!, for: .normal)
        }
    }
    var isAccessible : Bool?{
        didSet{
            if self.isAccessible ?? false{
                self.backgroundColor = #colorLiteral(red: 0.1907444894, green: 0.4766811728, blue: 0.96295017, alpha: 1)
                self.isEnabled = true
            }
            else{
                self.backgroundColor = #colorLiteral(red: 0.79747504, green: 0.8685234785, blue: 0.9932343364, alpha: 1)
                self.isEnabled = false
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cornerRadius(radius: 10, width: 0)
        self.titleLabel?.font = self.titleLabel?.font.withSize(21)
        let buttonWidth = UIScreen.main.bounds.size.width - 72
        self.easy.layout(Height(60), Width(buttonWidth))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
