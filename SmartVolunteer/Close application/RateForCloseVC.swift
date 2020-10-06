//
//  RateForCloseVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 10/6/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class RateForCloseVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    // MARK: - Variables
    let tableView = UITableView()
    var volunteers : [Data]?
    var id = 0
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        life()
        getData()
        bottomView()
    }
    
    // MARK: - Functions
    func life(){
        self.view.addSubview(tableView)
        tableView.easy.layout(Edges())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
    }
    func getData(){
         Requests.shared().getVolunteersList(id: id, page: 1) { (r) in
            let v = r.volunteers?.data?.filter({$0.status != 0 })
            self.volunteers = v
             self.tableView.reloadData()
         }
     }
    func bottomView(){
        let label = UILabel()
        label.setProperties(text: "Отправить оценки и завершить", textColor: .white, font: .systemFont(ofSize: 18), textAlignment: .center, numberLines: 1)
        label.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        self.view.addSubview(label)
        label.easy.layout(Left(),Right(),Height(60))
        label.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volunteers?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell()
        if let d = self.volunteers?[indexPath.row] {
           let v = RateVolunteerView(data: d)
            cell.addSubview(v)
            v.easy.layout(Edges(20))
        }
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.setProperties(text: "Отправить оценки и завершить", textColor: .white, font: .systemFont(ofSize: 18), textAlignment: .center, numberLines: 1)
        label.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    static func open(vc: UIViewController,id:Int){
         let viewController = RateForCloseVC()
         viewController.id = id
         if let nav = vc.navigationController {
             nav.pushViewController(viewController, animated: true)
         }
     }
}
