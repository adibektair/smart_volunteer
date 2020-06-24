//
//  NewsListVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/23/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class NewsListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Variables
    let tableView = UITableView()
    var news : News?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        life()
        setUI()
        
    }
    
    // MARK: - Outlets

    
    // MARK: - Functions
    func life() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    func setUI(){
        self.view.addSubview(tableView)
        tableView.easy.layout(Edges())
    }
    func getData(){
        Requests.shared().getNews(page: 0) { (result) in
            self.news = result
            self.tableView.reloadData()
        }
    }
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.categories?.data?.count ?? 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let n = NewsView(frame: .zero)
        cell.addSubview(n)
        n.easy.layout(Top(5),Bottom(5),Left(20),Right(20))
        return cell
    }

}
