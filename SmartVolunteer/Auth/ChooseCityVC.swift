//
//  ChooseCityVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/23/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

protocol CityPickerProtocol {
    func pickCity(cityName: String, id: Int)
}

class ChooseCityVC: ScrollStackController, UITableViewDelegate, UITableViewDataSource {

    var pickerDelegate : CityPickerProtocol?
    var searchView = UISearchBar()
    var tableView = UITableView()
    var cities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Выберите город".localized()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.cities[indexPath.row].name ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.pickerDelegate?.pickCity(cityName: self.cities[indexPath.row].name ?? "", id: self.cities[indexPath.row].id!)
        }
    }
    
    func setViews(){
        self.stackView.setProperties(axis: .vertical, alignment: .fill, spacing: 0, distribution: .fill)
        searchView.searchBarStyle = .default
        self.stackView.addArrangedSubview(searchView)
        self.stackView.addArrangedSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.easy.layout(Height(UIScreen.main.bounds.size.height - 140))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

//        self.searchView.easy.layout(Left(0), Right(0), Top(70))
    }
    
    static func open(vc: UIViewController){
        let viewController = self.init()
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
    
}
