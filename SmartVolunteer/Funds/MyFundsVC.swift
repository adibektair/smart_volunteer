//
//  MyFundsVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/28/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class MyFundsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView = UITableView()
    var funds : [Fond]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setViews()
        self.getData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    func getData(){
        self.startLoad()
        Requests.shared().getMyFunds(page: 0) { (response) in
            self.funds = response.funds?.data
            if self.funds?.count ?? 0 == 0{
                let label = UILabel()
                label.text = "Подпишитесь на фонды"
                label.textColor = #colorLiteral(red: 0.7803921569, green: 0.7882352941, blue: 0.8117647059, alpha: 1)
                self.view.addSubview(label)
                label.easy.layout(Center())
            }
            self.tableView.reloadData()
            self.stopLoad()
        }
    }
    func setViews(){
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.easy.layout(Top(), Bottom(), Left(20), Right(20))
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "FuncTVC", bundle: nil), forCellReuseIdentifier: "cell")
        self.title = "Фонды, куда подписан(а)"
        self.navigationController?.navigationBar.prefersLargeTitles = false


    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return self.funds?.count ?? 0
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
   
        fund = self.funds![indexPath.section]
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FuncTVC
         cell.data = fund
         cell.cornerRadius(radius: 10, width: 0)
         cell.actionButton.tag = fund!.id!
         cell.actionButton.addTarget(self, action: #selector(self.subscribe(_:)), for: .touchUpInside)
         cell.dropShadow()
         cell.selectionStyle = .none
         return cell
     }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let fund = self.funds?[indexPath.section]
         FundVC.open(vc: self, fund: fund!)
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
