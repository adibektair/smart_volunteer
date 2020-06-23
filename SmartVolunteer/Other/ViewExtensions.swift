//
//  ViewExtensions.swift
//  Tensend
//
//  Created by Sultan on 2/10/20.
//  Copyright © 2020 Sultan. All rights reserved.
//

import UIKit

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.shadowColor = UIColor.titleDefault(UIColor())().cgColor
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.masksToBounds = false
        
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3
        //layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
    func dropShadowBlue(scale: Bool = true) {
          layer.shadowColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.8039215686, alpha: 1)
          layer.shadowOffset = CGSize(width: 3, height: 3)
          layer.masksToBounds = false
          
          layer.shadowOpacity = 0.2
          layer.shadowRadius = 5
          //layer.shadowPath = UIBezierPath(rect: bounds).cgPath
          layer.rasterizationScale = UIScreen.main.scale
          layer.shouldRasterize = true
      }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}
