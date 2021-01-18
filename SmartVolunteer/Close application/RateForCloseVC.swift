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
    var volunteers : Volunteers?
    var id = 0
    var params = [:] as [String:Any]
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
        self.navigationItem.title = "Оценка волонтеров".localized()
    }
    func getData(){
        Requests.shared().getVolunteersList(id: id, page: 1) { (r) in
            let v = r.volunteers?.data?.filter({$0.status != 0 })
            self.volunteers = r
            self.volunteers?.volunteers?.data = v
            self.tableView.reloadData()
        }
    }
    func bottomView(){
        let label = UILabel()
        label.setProperties(text: "Отправить оценки и завершить".localized(), textColor: .white, font: .systemFont(ofSize: 18), textAlignment: .center, numberLines: 1)
        label.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        self.view.addSubview(label)
        label.easy.layout(Left(),Right(),Height(60))
        label.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        label.addTapGestureRecognizer {
            self.closeApploicationPressed()
        }
    }
    
    func closeApploicationPressed(){
        
        var objList : [[String:Any]] = []
        
        let list = self.volunteers?.volunteers?.data?.filter({$0.mark != nil && $0.mark! > 0 })
        if let d = list {
            for i in d {
                let p = ["user_id": i.id!,
                         "text": i.title ?? "",
                         "mark": i.mark ?? 0] as [String : Any]
                objList.append(p)
            }
        }
        let param = [
            "application_id":self.id,
            "feedbacks": objList as Any
            ] as [String : Any]
        self.params = param
        Requests.shared().complete(param: param) { (result) in
            if let s = result.success, let m = result.message {
                if s {
                    self.showAlert(title: "Внимание".localized(), message: m, popToRoot: true)
                }
            }
        }
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volunteers?.volunteers?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell()
        if let d = self.volunteers?.volunteers?.data?[indexPath.row] {
            let v = RateVolunteerView(data: d)
            cell.addSubview(v)
            v.easy.layout(Edges(20))
        }
        cell.selectionStyle = .none
        if indexPath.row == (self.volunteers?.volunteers?.data?.count ?? 0) - 1 {
            self.volunteers?.volunteers?.loadNextPage {
                self.tableView.reloadData()
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.setProperties(text: "Отправить оценки и завершить".localized(), textColor: .white, font: .systemFont(ofSize: 18), textAlignment: .center, numberLines: 1)
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

class FeedbackObj: NSObject {
    var user_id: Int = 0
    var text: String = ""
    var mark:Int = 0
    init(id:Int,text:String,mark:Int) {
        self.user_id = id
        self.text = text
        self.mark = mark
    }
}
