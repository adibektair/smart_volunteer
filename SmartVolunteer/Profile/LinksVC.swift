//
//  LinksVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 10/31/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
class LinksVC: ScrollStackController {

    var links : [Link]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    func setUI(){
        stackView.setSpacing(top: 10, left: 20, right: 0, bottom: 0)
        title = "Доп. информация"
    }
    func getData(){
        Requests.shared().getLinks { (result) in
            self.links = result?.links
            self.setViews()
        }
    }

    
    // MARK: - Functions
    func setViews(){
        if let links = self.links {
            for i in links {
                let label = UILabel()
                label.setProperties(text: i.title ?? "", textColor:  #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 17, weight: .medium), textAlignment: .left, numberLines: 1)
                let v = UIStackView()
                v.addArrangedSubview(label)
                v.setProperties(axis: .horizontal, alignment: .fill, spacing: 10, distribution: .fill)
                v.setSpacing(top: 0, left: 0, right: 10, bottom: 0)
                let icon = UIImageView(image: #imageLiteral(resourceName: "Linearrow"))
                icon.contentMode = .scaleAspectFit
                icon.easy.layout(Width(20),Height(20))
                v.addArrangedSubview(icon)
                v.addTapGestureRecognizer {
                    WebVC.open(vc: self, link: i)
                }
                self.stackView.addArrangedSubview(v)
                let line = UIView()
                line.easy.layout(Height(0.5))
                line.backgroundColor = . lightGray
                self.stackView.addArrangedSubview(line)
            }
        }
    }
    

    
    static func open(vc: UIViewController){
        let vcc = LinksVC()
        if let nav = vc.navigationController {
            nav.pushViewController(vcc, animated: true)
        }
    }

}
