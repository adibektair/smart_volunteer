//
//  FinishedWorksVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 9/24/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class FinishedWorksVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    let tableView = UITableView()
    var feedBacks: Feedbacks?
    var profile: Profile?
    var ava = UIImage()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        life()
        getData()
    }
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let y = self.view.frame.minY
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(.zero, in: self.view)
    }
    
    func getData(){
        if self.feedBacks == nil {
            Requests.shared().getFeedback(page: 1) { (result) in
                self.feedBacks = result
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func life(){
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.easy.layout(Edges())
        title = "Выполненные работы"
        userInfo()
    }
    func userInfo(){
        let image = UIImageView()
        if profile?.avatar != nil{
                 image.sd_setImage(with: URL(string: self.profile!.avatar!.encodeUrl), completed: nil)
             }else{
                 image.image = #imageLiteral(resourceName: "photo user")
             }
        self.ava = image.image!
        self.tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedBacks?.feedbacks?.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let data = feedBacks?.feedbacks?.data?[indexPath.row] else { return cell }
        let c = FinishedWorkCell(data: data)
        
        cell.contentView.addSubview(c)
        c.easy.layout(Edges())
        cell.selectionStyle = .none
        return cell
    }
    
    static func open(vc: UIViewController, feedBacks: Feedbacks){
        let viewController = FinishedWorksVC()
        viewController.feedBacks = feedBacks
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }

}
