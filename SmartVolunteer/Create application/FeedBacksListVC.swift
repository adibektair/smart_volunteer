//
//  FeedBacksListVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 9/29/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class FeedBacksListVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    let tableView = UITableView()
    var feedbacks : Feedbacks?
    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.easy.layout(Edges())
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        getData()
    }
    // MARK: - Functions
    func getData(){
        Requests.shared().getUserFeedback(id: id, page: 1, callback: { (result) in
            self.feedbacks = result
            self.tableView.reloadData()
        })
    }
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbacks?.feedbacks?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if let f = feedbacks?.feedbacks?.data?[indexPath.row] {
            let header = HeadUserInfoView(data: f)
            cell.addSubview(header)
            header.easy.layout(Edges(20))
        }
        return cell
    }
    static func  open(vc: UIViewController,id:Int ) {
        let viewController = FeedBacksListVC()
        viewController.id = id
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
}
