//
//  ApplicationsListVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/25/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class ApplicationsListVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    let tableView = UITableView()
    var applications : Applications?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        life()
        setUI()
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
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
        self.navigationItem.title = "Заявки"
        rightButton()
    }
    
    func getData(){
        startLoad()
        Requests.shared().getApplications { (result) in
            self.stopLoad()
            self.applications = result
            self.tableView.reloadData()
        }
    }
    func rightButton(){
        let b = UIBarButtonItem(image: #imageLiteral(resourceName: "Filter 24px"), style: .plain, target: self, action: #selector(filterPressed(_:)))
        navigationItem.rightBarButtonItem = b
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    @objc func filterPressed(_ sender:UIBarButtonItem) {
        FilterVC.open(vc: self)
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applications?.applications?.data?.count ?? 5
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let d = self.applications?.applications?.data?[indexPath.row] {
            ApplicationVC.open(vc: self, data: d)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let c = UIView()
        let stackView = UIStackView()
        stackView.setProperties(axis: .vertical, alignment: .fill, spacing: 25, distribution: .fill)
        stackView.setSpacing(top: 0, left: 20, right: 20, bottom: 0)
        c.backgroundColor = .white
        let items = ["Все","Фондовые", "В работе"]
        let segmentedController = UISegmentedControl(items: items)
        segmentedController.selectedSegmentIndex = 0
        stackView.addArrangedSubview(segmentedController)
        let appsLabel = UILabel()
        appsLabel.setProperties(text: "505 заявок", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
        stackView.addArrangedSubview(appsLabel)
        c.addSubview(stackView)
        stackView.easy.layout(Edges())
        return c
    }
    // MARK: - Navigation
    
    // MARK: - Navigation
    
}
