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
        self.navigationItem.title = "Мои заявки"
        setBackButton()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.easy.layout(Edges())
        getData()
    }
    
    
    // MARK: - Navigation
    func getData(){
        Requests.shared().getMyApplications(page: 0) { (res) in
            self.applications = res
            self.tableView.reloadData()
        }
    }
    // MARK: - Navigation
    
    // MARK: - Navigation
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applications?.applications?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if let d = self.applications?.applications?.data?[indexPath.row] {
            let n = ApplicationView(data: d)
            cell.addSubview(n)
            n.easy.layout(Top(5),Bottom(5),Left(20),Right(20))
        }
        if indexPath.row == self.applications!.applications!.data!.count - 1 {
            self.applications?.applications?.loadNextPageMyApplications {
                self.tableView.reloadData()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if let d = self.applications?.applications?.data?[indexPath.row] {
               ApplicationVC.open(vc: self, data: d,nuzhd: true)
           }
       }
    
    static func open(vc: UIViewController){
           let viewController = MyApplicationsVC()
           if let nav = vc.navigationController {
               nav.pushViewController(viewController, animated: true)
           }
       }
}
