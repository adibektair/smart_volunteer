//
//  FundsListVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/24/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class FundsListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let searchBar = UISearchBar()
    var tableView = UITableView()
    var fundsObj : FundsResponse?
    var funds : [Fond]?
    var filteredFunds : [Fond]?
    var filtering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchBar.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "FuncTVC", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Фонды"
        self.setViews()
        self.getData()
    }
    
    func getData(){
        self.startLoad()
        Requests.shared().getFunds(page: 0) { (response) in
            self.fundsObj = response
            self.funds = response.funds?.data
            self.tableView.reloadData()
            self.stopLoad()
        }
    }
    

    func setViews(){
        self.rightButton()
        self.view.backgroundColor = .white
        searchBar.placeholder = "Название фонда"
        self.view.addSubview(tableView)
        tableView.easy.layout(Top(), Bottom(), Left(20), Right(20))
        
    }
    func rightButton(){
        let b = UIBarButtonItem(image: #imageLiteral(resourceName: "Gridtortburyw"), style: .plain, target: self, action: #selector(myFundsPressed(_:)))
        navigationItem.rightBarButtonItem = b
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.filtering{
            return self.filteredFunds?.count ?? 0
        }
        return self.fundsObj?.funds?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fund : Fond?
        if self.filtering{
            fund = self.filteredFunds![indexPath.section]
        }else{
            fund = self.fundsObj?.funds?.data![indexPath.section]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FuncTVC
        cell.data = fund
        cell.cornerRadius(radius: 10, width: 0)
        cell.actionButton.tag = fund!.id!
        cell.actionButton.addTarget(self, action: #selector(self.subscribe(_:)), for: .touchUpInside)
        cell.dropShadow()
        cell.selectionStyle = .none
        if indexPath.section == (fundsObj?.funds?.data?.count ?? 0) - 1 {
            fundsObj?.funds?.loadNextPage {
                self.tableView.reloadData()
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fund = self.funds?[indexPath.section]
        FundVC.open(vc: self, fund: fund!)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filtering = false
        tableView.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else{
            return
        }
        self.filtering = true
        self.filteredFunds = self.funds
        filteredFunds = funds!.filter { (candy: Fond) -> Bool in
            return candy.name!.lowercased().contains(text.lowercased())
         }
        self.tableView.reloadData()
    }
    @objc func myFundsPressed(_ sender:UIBarButtonItem) {
        MyFundsVC.open(vc: self)
    }
    @objc func subscribe(_ sender : UIButton){
        Requests.shared().subscribe(id: sender.tag) { (response) in
            if response?.success ?? false{
                self.singleVibration()
                self.getData()
            }
        }
    }
    static func open(vc: UIViewController){
        let viewController = self.init()
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
    
}
