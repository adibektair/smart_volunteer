//
//  StackViewExtensions.swift
//  Tensend
//
//  Created by Sultan on 1/28/20.
//  Copyright © 2020 Sultan. All rights reserved.
//

import UIKit

extension UIStackView {
    func customize(backgroundColor: UIColor = .clear, radiusSize: CGFloat = 0) {
           let subView = UIView(frame: bounds)
           subView.backgroundColor = backgroundColor
           subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           insertSubview(subView, at: 0)

           subView.layer.cornerRadius = radiusSize
           subView.layer.masksToBounds = true
           subView.clipsToBounds = true
       }
    func addBackgroundColor(color: UIColor){
        let subview = UIView(frame: bounds)
        subview.backgroundColor = color
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subview, at: 0)
    }
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func addCustomSpacing(top: CGFloat, bottom: CGFloat) {
        
        //If the stack view has just one arrangedView, we add a dummy one
        if self.arrangedSubviews.count == 1 {
            self.insertArrangedSubview(UIView(frame: .zero), at: 0)
        }
        
        //Getting the second last arrangedSubview and the current one
        let lastTwoArrangedSubviews = Array(self.arrangedSubviews.suffix(2))
        let arrSpacing: [CGFloat] = [top, bottom]
        
        //Looping through the two last arrangedSubview to add spacing in each of them
        for (index, anArrangedSubview) in lastTwoArrangedSubviews.enumerated() {
            
            //After iOS 11, the stackview has a native method
            if #available(iOS 11.0, *) {
                self.setCustomSpacing(arrSpacing[index], after: anArrangedSubview)
                //Before iOS 11 : Adding dummy separator UIViews
            } else {
                guard let arrangedSubviewIndex = arrangedSubviews.firstIndex(of: anArrangedSubview) else {
                    return
                }
                
                let separatorView = UIView(frame: .zero)
                separatorView.translatesAutoresizingMaskIntoConstraints = false
                
                //calculate spacing to keep a coherent spacing with the ios11 version
                let isBetweenExisitingViews = arrangedSubviewIndex != arrangedSubviews.count - 1
                let existingSpacing = isBetweenExisitingViews ? 2 * spacing : spacing
                let separatorSize = arrSpacing[index] - existingSpacing
                
                guard separatorSize > 0 else {
                    return
                }
                
                switch axis {
                case .horizontal:
                    separatorView.widthAnchor.constraint(equalToConstant: separatorSize).isActive = true
                case .vertical:
                    separatorView.heightAnchor.constraint(equalToConstant: separatorSize).isActive = true
                @unknown default:
                    fatalError()
                }
                
                insertArrangedSubview(separatorView, at: arrangedSubviewIndex + 1)
            }
        }
    }
    
    func addCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        if #available(iOS 11.0, *) {
            self.setCustomSpacing(spacing, after: arrangedSubview)
        } else {
            let separatorView = UIView(frame: .zero)
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            switch axis {
            case .horizontal:
                separatorView.widthAnchor.constraint(equalToConstant: spacing).isActive = true
            case .vertical:
                separatorView.heightAnchor.constraint(equalToConstant: spacing).isActive = true
            }
            if let index = self.arrangedSubviews.firstIndex(of: arrangedSubview) {
                insertArrangedSubview(separatorView, at: index + 1)
            }
        }
    }
    
    func setProperties(axis: NSLayoutConstraint.Axis,
                       alignment: UIStackView.Alignment,
                       spacing: CGFloat,
        distribution: UIStackView.Distribution) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.distribution = distribution
    }
    
    func getProperties(stackView: UIStackView) {
        self.axis = stackView.axis
        self.alignment = stackView.alignment
        self.spacing = stackView.spacing
        self.distribution = stackView.distribution
    }
    func setSpacing(top: CGFloat = 0,left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0){
        self.isLayoutMarginsRelativeArrangement = true
        if #available(iOS 11.0, *) {
            self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
             } else {
                 self.layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
             }
    }
}
