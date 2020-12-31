//
//  TopVolunteerListVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 12/31/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import Cosmos

class TopVolunteerListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var volunteers : Volunteers?
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    func setUI(){
//           self.navigationItem.title = "Список желающих"
           setBackButton()
           tableView.delegate = self
           tableView.dataSource = self
           self.view.addSubview(tableView)
           tableView.easy.layout(Edges())
           getData()
    }
    
    // MARK: - Navigation
    func getData(){
        Requests.shared().getTopVolunteersList { (r) in
            self.volunteers = r
            self.tableView.reloadData()
        }
    }
    // MARK: - Navigation
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volunteers?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if let v = volunteers?.data?[indexPath.row] {
            let h = headViews(data: v)
            cell.addSubview(h)
            h.easy.layout(Edges(20))
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = volunteers?.data?[indexPath.row] {
            UserProfileVC.open(vc: self, profile: user)
        }
    }
    func headViews(data : User) -> UIView {
        let mainStack = UIStackView()
        let headStack = UIStackView()
        let titleStack = UIStackView()
        mainStack.setProperties(axis: .vertical, alignment: .fill, spacing: 20, distribution: .fill)
        headStack.setProperties(axis: .horizontal, alignment: .fill, spacing: 12, distribution: .fill)
        titleStack.setProperties(axis: .vertical, alignment: .fill, spacing: 4, distribution: .fill)
        let iconStack = UIStackView()
        iconStack.setProperties(axis: .vertical, alignment: .fill, spacing: 0, distribution: .fill)
        let icon = UIImageView(image: #imageLiteral(resourceName: "anonymous"))
        icon.layer.cornerRadius = 24
        icon.layer.masksToBounds = true
        icon.easy.layout(Width(48),Height(48))
        if let url = URL(string: data.imgPath ?? "") {
            icon.sd_setImage(with: url, completed: nil)
        }
        iconStack.addArrangedSubview(icon)
        iconStack.addArrangedSubview(UIView())
        let nameLabel = UILabel()
        let name = "\(data.surname ?? "") \(data.name ?? "")"
        nameLabel.setProperties(text: name, textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), textAlignment: .left, numberLines: 1)
        
        let phoneText = UILabel()
        let phone = data.phone ?? "+7700 000 00 00"
        phoneText.setProperties(text: phone, textColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
        
        let rating = CosmosView()
        rating.settings.starMargin = 2
        rating.settings.starSize = 16
        rating.settings.updateOnTouch = false
        rating.settings.filledImage = #imageLiteral(resourceName: "Star")
        rating.settings.emptyImage = #imageLiteral(resourceName: "StarEmpty")
        rating.rating = Double(data.ratingScore ?? 0)
        rating.easy.layout(Height(14),Width(120))
        titleStack.addArrangedSubview(nameLabel)
        titleStack.addArrangedSubview(phoneText)
        titleStack.addArrangedSubview(rating)
        
        let arrowIcon = UIImageView()
        arrowIcon.image = #imageLiteral(resourceName: "right")
        arrowIcon.easy.layout(Width(12))
        arrowIcon.contentMode = .scaleAspectFit
        headStack.addArrangedSubview(iconStack)
        headStack.addArrangedSubview(titleStack)
        headStack.addArrangedSubview(arrowIcon)
        let v = UIView()
        mainStack.addArrangedSubview(headStack)
        v.addSubview(mainStack)
        mainStack.easy.layout(Edges())
        return v
    }
    
    static func open(vc: UIViewController){
           let viewController = TopVolunteerListVC()
           if let nav = vc.navigationController {
               nav.pushViewController(viewController, animated: true)
           }
       }

}
