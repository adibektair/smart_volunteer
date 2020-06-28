//
//  FundsRequestsVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/28/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy


class FundsRequestsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView = UITableView()
    var applications : FundRequest?
    var id = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setViews()
        self.title = "Заявки фонда"
        self.setViews()
        self.getData()
    }

    func getData(){
        self.startLoad()
        Requests.shared().getFundRequests(id: id) { (response) in
            self.stopLoad()
            self.applications = response
            if response?.applications?.data?.count ?? 0 == 0{
                let label = UILabel()
                label.text = "Заявки отсутствуют"
                label.textColor = #colorLiteral(red: 0.7803921569, green: 0.7882352941, blue: 0.8117647059, alpha: 1)
                self.view.addSubview(label)
                label.easy.layout(Center())
            }
            self.tableView.reloadData()
        }
    }
    func setViews(){
        self.view.addSubview(tableView)
        tableView.easy.layout(Edges())
        self.tableView.separatorStyle = .none
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
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return applications?.applications?.data?.count ?? 0
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applications?.applications?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let d = self.applications?.applications?.data?[indexPath.row] {
            ApplicationVC.open(vc: self, data: d)
        }
    }
    static func open(vc: UIViewController, id : Int){
        let viewController = self.init()
        viewController.id = id
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
    
}
