//
//  VolunteerListVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/28/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import SDWebImage

class VolunteerListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Navigation
    let tableView = UITableView()
    var volunteers : Volunteers?
    var id = 0
    
    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Список желающих"
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.easy.layout(Edges())
        getData()
    }
    
    
    // MARK: - Navigation
    func getData(){
        Requests.shared().getVolunteersList(id: id, page: 1) { (r) in
            self.volunteers = r
            self.tableView.reloadData()
        }
    }
    // MARK: - Navigation
    
    // MARK: - Navigation
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volunteers?.volunteers?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if let v = volunteers?.volunteers?.data?[indexPath.row] {
            let h = headViews(data: v)
            cell.addSubview(h)
            h.easy.layout(Edges(20))
        }
        return cell
    }
    
    func headViews(data : Data) -> UIView {
        let headStack = UIStackView()
        let titleStack = UIStackView()
        headStack.setProperties(axis: .horizontal, alignment: .fill, spacing: 12, distribution: .fill)
        titleStack.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        let icon = UIImageView(image: #imageLiteral(resourceName: "anonymous"))
        icon.layer.cornerRadius = 24
        icon.layer.masksToBounds = true
        icon.easy.layout(Width(48),Height(48))
        if let url = URL(string: data.imgPath ?? "") {
            icon.sd_setImage(with: url, completed: nil)
        }
        let nameLabel = UILabel()
        let name = "\(data.surname ?? "") \(data.name ?? "")"
        nameLabel.setProperties(text: name, textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), textAlignment: .left, numberLines: 1)
        
        let phoneText = UILabel()
        let phone = data.phone ?? "+7700 000 00 00"
        phoneText.setProperties(text: phone, textColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
        titleStack.addArrangedSubview(nameLabel)
        titleStack.addArrangedSubview(phoneText)
        titleStack.addArrangedSubview(UIView())
        
        headStack.addArrangedSubview(icon)
        headStack.addArrangedSubview(titleStack)
        let v = UIView()
        v.addSubview(headStack)
        headStack.easy.layout(Edges())
        return v
    }
    
    
    
    static func open(vc: UIViewController,id:Int){
        let viewController = VolunteerListVC()
        viewController.id = id
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
}
