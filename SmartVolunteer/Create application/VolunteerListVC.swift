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
import Cosmos

class VolunteerListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Navigation
    let tableView = UITableView()
    var volunteers : Volunteers?
    var id = 0
    
    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Список желающих".localized()
        setBackButton()
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
        if indexPath.row == (self.volunteers?.volunteers?.data?.count ?? 0) - 1 {
            self.volunteers?.volunteers?.loadNextPage {
                self.tableView.reloadData()
            }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let v = volunteers?.volunteers?.data?[indexPath.row], let id = v.id {
            FeedBacksListVC.open(vc: self, id: id)
        }
    }
    func headViews(data : Data) -> UIView {
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
        rating.rating = data.ratingScore ?? 0.0
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
        let bottomStack = UIStackView()
        bottomStack.setProperties(axis: .horizontal, alignment: .fill, spacing: 15, distribution: .fillEqually)
        let accept = UILabel()
        let decline = UILabel()
        accept.setProperties(text: "Принять".localized(), textColor: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .center)
        decline.setProperties(text: "Отклонить".localized(), textColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .center)
        accept.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1))
        accept.addTapGestureRecognizer {
            self.volunteerAccept(isAccepted: true, volunteerId: data.id ?? 0) { (status) in
                accept.text = "Успешно принят".localized()
                UIView.animate(withDuration: 0.2) {
                    decline.isHidden = true
                }
            }
        }
        decline.addTapGestureRecognizer {
            self.volunteerAccept(isAccepted: false, volunteerId: data.id ?? 0) { (status) in
                if status! {
                    decline.text = "Отклонен".localized()
                    UIView.animate(withDuration: 0.2) {
                        accept.isHidden = true
                    }
                }
            }
        }
        decline.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
        accept.easy.layout(Height(50))
        decline.easy.layout(Height(50))
        bottomStack.addArrangedSubview(accept)
        bottomStack.addArrangedSubview(decline)
        if let status = data.status, status == 0 {
            mainStack.addArrangedSubview(bottomStack)
        }
        v.addSubview(mainStack)
        mainStack.easy.layout(Edges())
        return v
    }
    func volunteerAccept(isAccepted: Bool,volunteerId: Int,success: @escaping (Bool?) -> ()){
        
        let param = ["is_accepted": isAccepted,
                     "volunteer_id": volunteerId,
                     "application_id":self.id] as [String: AnyObject]
        Requests.shared().acceptDecline(params: param, callback: { (result) in
            success(result?.success ?? false)
        })
    }
    
    
    static func open(vc: UIViewController,id:Int){
        let viewController = VolunteerListVC()
        viewController.id = id
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
}
