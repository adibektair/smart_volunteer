//
//  FundVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/25/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//
import UIKit
import EasyPeasy

class FundVC: UIViewController {

    
    var isSubscribed = Bool()
    @IBOutlet weak var logoImageView: UIImageView!{
        didSet{
            self.logoImageView.cornerRadius(radius: 35, width: 0)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountView: UIView!{
        didSet{
            self.amountView.cornerRadius(radius: 10, width: 0)
        }
    }
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var volunteersLabel: UILabel!
    @IBOutlet weak var requestsView: UIView!{
        didSet{
            self.requestsView.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 0.1907444894, green: 0.4766811728, blue: 0.96295017, alpha: 1))
        }
    }
    @IBOutlet weak var requestsLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var fund : Fond?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    func setViews(){
        self.title = "Фонд"
        if let img = fund?.imgPath{
            self.logoImageView.sd_setImage(with: URL(string: img), completed: nil)
        }else{
            self.logoImageView.image = #imageLiteral(resourceName: "placeholder-image")
        }
        self.nameLabel.text = fund?.name
        self.cityLabel.text = fund?.city?.name
        self.amountLabel.text = "\(fund?.volunteerNumber ?? 0)"
        self.volunteersLabel.text = "волонтеров"
        if self.fund?.volunteer == nil{
            self.isSubscribed = false
            self.subscribeButton.setTitleColor(#colorLiteral(red: 0.1907444894, green: 0.4766811728, blue: 0.96295017, alpha: 1), for: .normal)
            self.subscribeButton.setTitle("Подписаться", for: .normal)
        }else{
            self.isSubscribed = true
            self.subscribeButton.setTitleColor(#colorLiteral(red: 0.9989094138, green: 0.2617629766, blue: 0.262750864, alpha: 1), for: .normal)
            self.subscribeButton.setTitle("Отписаться", for: .normal)
        }
        self.requestsLabel.text = "Заявки фонда"
        self.infoLabel.text = self.fund?.descriptionField
        self.subscribeButton.addTarget(self, action: #selector(self.subscribe(_:)), for: .touchUpInside)
        self.requestsView.addTapGestureRecognizer {
            FundsRequestsVC.open(vc: self, id: self.fund!.id!)
        }
    }
    
    static func open(vc: UIViewController, fund : Fond){
        let viewController = self.init()
        viewController.fund = fund
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func subscribe(_ sender : UIButton){
        self.startLoad()
        Requests.shared().subscribe(id: self.fund!.id!) { (response) in
            self.stopLoad()
            if response?.success ?? false{
                self.isSubscribed = !self.isSubscribed
                self.singleVibration()
                if self.isSubscribed{
                    self.subscribeButton.setTitleColor(#colorLiteral(red: 0.9989094138, green: 0.2617629766, blue: 0.262750864, alpha: 1), for: .normal)
                    self.subscribeButton.setTitle("Отписаться", for: .normal)
                }else{
                    self.subscribeButton.setTitleColor(#colorLiteral(red: 0.1907444894, green: 0.4766811728, blue: 0.96295017, alpha: 1), for: .normal)
                    self.subscribeButton.setTitle("Подписаться", for: .normal)
                }
            }
        }
    }

}
