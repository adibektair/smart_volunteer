//
//  webVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 10/31/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import WebKit
import EasyPeasy

class WebVC: UIViewController {

    let webView = WKWebView()
    var link: Link?
    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    // MARK: - Navigation
    func setViews(){
        view.addSubview(webView)
        webView.easy.layout(Edges())
        title = link?.title ?? ""
        if let url = URL(string: self.link?.link ?? "") {
            self.webView.load(URLRequest(url: url))
        }
    }
    
    static func open(vc: UIViewController,link: Link){
        let vcc = WebVC()
        vcc.link = link
        if let nav = vc.navigationController {
            nav.pushViewController(vcc, animated: true)
        }
    }
}
