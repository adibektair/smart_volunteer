//
//  FeedbackInfoVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 9/25/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy


class FeedbackInfoVC: ScrollStackController {

    // MARK: - Variables
    var data: Data?
    let fullView: CGFloat = 100
    var partialView: CGFloat {
          return UIScreen.main.bounds.height - 150
      }
    
    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.setSpacing(top: 0, left: 20, right: 20, bottom: 20)
        headViews()
        bottomPartViews()
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(FeedbackInfoVC.panGesture(recognizer:)))
        self.view.addGestureRecognizer(gesture)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        prepareBackgroundView()
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            let frame = self.view.frame
            let yComponent = UIScreen.main.bounds.height - 200
            self.view.frame = CGRect(x: 0, y: yComponent, width: frame.width, height: frame.height)
        }
    }
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
           
           let translation = recognizer.translation(in: self.view)
           let velocity = recognizer.velocity(in: self.view)

           let y = self.view.frame.minY
           if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
               self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
               recognizer.setTranslation(CGPoint.zero, in: self.view)
           }
           
           if recognizer.state == .ended {
               var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
               
               duration = duration > 1.3 ? 1 : duration
               
               UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                   if  velocity.y >= 0 {
                       self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                   } else {
                       self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                   }
                   
                   }, completion: { [weak self] _ in
                       if ( velocity.y < 0 ) {
                        self?.scrollView.isScrollEnabled = true
                       }
               })
           }
    }
    

    //MARK: - Functions
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)

        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds

        view.insertSubview(bluredView, at: 0)
    }
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let y = self.view.frame.minY
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(.zero, in: self.view)
    }
    //MARK: - Views
    func headViews(){
        let headStack = UIStackView()
        let titleStack = UIStackView()
        headStack.setProperties(axis: .horizontal, alignment: .fill, spacing: 12, distribution: .fill)
        titleStack.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        let icon = UIImageView(image: #imageLiteral(resourceName: "anonymous"))
        icon.layer.cornerRadius = 35
        icon.layer.masksToBounds = true
        icon.easy.layout(Width(70),Height(70))
        if let url = URL(string: data?.user?.imgPath ?? data?.fund?.imgPath ?? "") {
            icon.sd_setImage(with: url, completed: nil)
        }
        let nameLabel = UILabel()
        let name = data?.user?.name ?? data?.fund?.name ?? "Анонимно"
        nameLabel.setProperties(text: name, textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), textAlignment: .left, numberLines: 1)
        
        let placeStack = UIStackView()
        placeStack.setProperties(axis: .horizontal, alignment: .fill, spacing: 8, distribution: .fill)
        let geoIcon = UIImageView(image: #imageLiteral(resourceName: "VectorGeo"))
        geoIcon.easy.layout(Width(13),Height(13))
        let cityLabel = UILabel()
        cityLabel.setProperties(text: data?.city?.name ?? "", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
        
        placeStack.addArrangedSubview(geoIcon)
        placeStack.addArrangedSubview(cityLabel)
        placeStack.addArrangedSubview(UIView())
        
        titleStack.addArrangedSubview(nameLabel)
        titleStack.addArrangedSubview(placeStack)
        titleStack.addArrangedSubview(UIView())
        
        headStack.addArrangedSubview(icon)
        headStack.addArrangedSubview(titleStack)
        stackView.addArrangedSubview(headStack)
    }

    func bottomPartViews(){
        let categoryLabel = UILabel()
        categoryLabel.setProperties(text: "Категория: Помощь малоимущим семьям", textColor: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), font: .systemFont(ofSize: 14))
        
        let mainInfo = UILabel()
        let text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
        
        mainInfo.setProperties(text: text, font: .systemFont(ofSize: 14), numberLines: 0)
        
        let title = UILabel()
        title.setProperties(text: "Нужна помощь!", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 20, weight: .bold))
        
        let titleTextLabel = UILabel()
        titleTextLabel.setProperties(text: text, textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), numberLines: 0)
        
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(mainInfo)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(titleTextLabel)
    }
}
