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
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        life()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        addBottomSheetView()
    }
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
          let translation = recognizer.translation(in: self.view)
          let y = self.view.frame.minY
          self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
          recognizer.setTranslation(.zero, in: self.view)
    }
    
    func addBottomSheetView(scrollable: Bool? = true) {
          let bottomSheetVC =  FeedbackInfoVC()
          
        self.addChild(bottomSheetVC)
          self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)

          let height = view.frame.height
          let width  = view.frame.width
          bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
      }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func life(){
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.easy.layout(Edges())
        navigationController?.navigationItem.title = "Выполненные работы"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let c = FinishedWorkCell()
        cell.contentView.addSubview(c)
        c.easy.layout(Edges())
        cell.selectionStyle = .none
        return cell
    }
    
    static func open(vc: UIViewController){
        let viewController = FinishedWorksVC()
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }

}
