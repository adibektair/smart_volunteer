//
//  MyApplicationsVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/26/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class MyApplicationsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Navigation
    let tableView = UITableView()
    var applications : Applications?
    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.easy.layout(Edges())
    }
    
    
    // MARK: - Navigation
    func getData(){
        
    }
    // MARK: - Navigation
    
    // MARK: - Navigation
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if let d = self.applications?.applications?.data?[indexPath.row] {
            let n = ApplicationView(data: d)
            cell.addSubview(n)
            n.easy.layout(Top(5),Bottom(5),Left(20),Right(20))
        }
        return cell
    }
    
    static func open(vc: UIViewController){
           let viewController = MyApplicationsVC()
           if let nav = vc.navigationController {
               nav.pushViewController(viewController, animated: true)
           }
       }
}
