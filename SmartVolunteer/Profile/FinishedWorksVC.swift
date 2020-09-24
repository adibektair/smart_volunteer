//
//  FinishedWorksVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 9/24/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class FinishedWorksVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Variables
    let tableView = UITableView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        life()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func life(){
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.easy.layout(Edges())
        navigationController?.navigationItem.title = "Выполненные работы"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let c = FinishedWorkCell()
        cell.contentView.addSubview(c)
        c.easy.layout(Edges())
        
        return cell
    }
    
    static func open(vc: UIViewController){
        let viewController = FinishedWorksVC()
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }

}
