//
//  LabelExtensions.swift
//  Tensend
//
//  Created by Sultan on 1/26/20.
//  Copyright © 2020 Sultan. All rights reserved.
//

import UIKit


extension UILabel{
    func setProperties(text: String = "",
                       textColor: UIColor = #colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 1),
                       font: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular),
                       textAlignment: NSTextAlignment = NSTextAlignment.left,
                       numberLines : Int = 1
        ) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.numberOfLines = numberLines
    }
}
extension UITextField {
    func placeholderColor(color: UIColor) {
        let attributeString = [
            NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6),
            NSAttributedString.Key.font: self.font!
            ] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeString)
    }
}
