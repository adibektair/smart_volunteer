//
//  NewsListVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/23/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import Localize_Swift

class NewsListVC: UIViewController, UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource {

    // MARK: - Variables
    let search = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    var news : News?
    var searchText = ""
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        life()
        setUI()
        getData()
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        sideBarButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        if Constants.shared().getToken() == nil {
            let v = AnonimView()
            self.view.addSubview(v)
            v.easy.layout(Edges())
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    @objc  func setText() {
        //Перезагрузка заголовка
        self.navigationItem.title = "Новости".localized()
        search.searchBar.placeholder = "Название новости".localized()
    }
    // MARK: - Functions
    func life() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        search.searchBar.delegate = self
    }
    func setUI(){
        self.view.addSubview(tableView)
        tableView.easy.layout(Edges())
        self.navigationItem.title = "Новости".localized()
        search.searchBar.placeholder = "Название новости".localized()
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        setNavForTaraz()
    }
      
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = ""
        getData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text!
        getData()
    }

    func getData(){
        startLoad()
        Requests.shared().getNews(page: 1,search: searchText) { (result) in
            self.stopLoad()
            self.news = result
            self.tableView.reloadData()
        }
    }
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.news?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if let data = self.news?.news?.data?[indexPath.row] {
            let n = NewsView(data: data)
            cell.addSubview(n)
            n.easy.layout(Top(5),Bottom(5),Left(20),Right(20))
        }
        if indexPath.row == (self.news?.news?.data?.count ?? 0) - 1 {
            self.news!.news!.loadNextPage(search: self.searchText, done: {
                self.tableView.reloadData()
            })
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = self.news?.news?.data?[indexPath.row] {
            NewsPageVC.open(vc: self, data: data)
        }
    }

}
