//
//  SideBarView.swift
//  SmartVolunteer
//
//  Created by Sultan on 12/6/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class SideBarView: UIView {

    let stackView = UIStackView()
    var links : [Link]? = []
    let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        getData()
        settings()
    }
    func settings() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.678009463)
        container.backgroundColor = .white
        self.addSubview(container)
        self.addTapGestureRecognizer {
            self.removeView()
        }
        container.easy.layout(Top(),Bottom(),Left())
        container.addSubview(stackView)
        stackView.easy.layout(Edges())
        UIView.animate(withDuration: 0.3, animations: {
            let w = UIScreen.main.bounds.width - 60
            self.container.frame.size.width = w
        }) { (f) in
            self.stackView.easy.layout(Edges())
        }
        stackView.setProperties(axis: .vertical, alignment: .fill, spacing: 5, distribution: .fill)
        stackView.setSpacing(top: 12, left: 12, right: 12, bottom: 12)
    }
    func removeView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.container.frame.origin.x = -UIScreen.main.bounds.width
        }) { (f) in
            self.removeFromSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setViews(){
        if let l = links {
            for i in l {
                let label = UILabel()
                label.setProperties(text: i.title ?? "" )
                label.addTapGestureRecognizer {
                    if let vc = self.parentViewController {
                        WebVC.open(vc: vc, link: i)
                    }
                }
                let line = UIView()
                line.easy.layout(Height(1))
                line.backgroundColor = .gray
                self.stackView.addArrangedSubview(label)
                self.stackView.addArrangedSubview(line)
            }
            stackView.addArrangedSubview(UIView())
        }
    }
    
    func getData(){
        if self.links?.isEmpty ?? true{
            Requests.shared().getLinks { (result) in
                self.links = result?.links
                self.setViews()
            }
        }
    }
}
