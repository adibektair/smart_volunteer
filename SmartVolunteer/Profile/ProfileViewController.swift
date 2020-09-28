//
//  ProfileViewController.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/29/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import SDWebImage
import EasyPeasy
import Cosmos

class ProfileViewController: UIViewController {

    var profile : Profile?
    var feedBacks: Feedbacks?
    
    @IBOutlet weak var avatarImageView: UIImageView!{
        didSet{
            self.avatarImageView.cornerRadius(radius: 40, width: 0, color: .white)
        }
    }
    @IBOutlet weak var dataView: UIView!{
        didSet{
            self.dataView.cornerRadius(radius: 10, width: 0)
            self.dataView.dropShadow()
        }
    }
    @IBOutlet weak var iinLabel: UILabel!
    @IBOutlet weak var iinDataLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameDataLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var surnameDataLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneDataLabel: UILabel!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var langDataLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityDataLabel: UILabel!
    @IBOutlet weak var worksCountLabel: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var editButton: UIButton!{
        didSet{
            self.editButton.setTitle("Редактировать профиль", for: .normal)
            self.editButton.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1))
        }
    }
    @IBOutlet weak var logOutButton: UIButton!{
        didSet{
            self.logOutButton.setTitle("Выйти", for: .normal)
            self.logOutButton.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 0.9989094138, green: 0.2617629766, blue: 0.262750864, alpha: 1))
        }
    }
    @IBOutlet weak var finishedWorks: UIButton! {
          didSet {
            self.finishedWorks.setTitle("Выполненные работы", for: .normal)
          }
      }
    @IBOutlet weak var finishedView: UIView! {
        didSet { self.finishedView.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)) }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Constants.shared().getToken() == nil {
            let v = AnonimView()
            self.view.addSubview(v)
            v.easy.layout(Edges())
        }
        setBackButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        if Constants.shared().getToken() == nil { return }
        self.getData()
        self.getFeedbacks()
    }
    
    func getData(){
        self.startLoad()
        Requests.shared().getProfile { (response) in
            self.stopLoad()
            self.profile = response?.profile
            self.setViews()
        }
    }
    func getFeedbacks(){
        Requests.shared().getFeedback { (result) in
            self.feedBacks = result
            self.worksCountLabel.text = "\(result?.feedbacks?.data?.count ?? 0)"
            
        }
    }
    func setViews(){
        if profile?.avatar != nil{
            avatarImageView.sd_setImage(with: URL(string: self.profile!.avatar!.encodeUrl), completed: nil)
        }else{
            avatarImageView.image = #imageLiteral(resourceName: "photo user")
        }
        iinLabel.text = "ИИН"
        iinDataLabel.text = profile?.iin ?? ""
        nameLabel.text = "Имя"
        nameDataLabel.text = profile?.name ?? ""
        surnameLabel.text = "Фамилия"
        surnameDataLabel.text = profile?.surname ?? ""
        phoneLabel.text = "Телефон"
        phoneDataLabel.text = profile?.phone ?? ""
        langLabel.text = "Язык"
        langDataLabel.text = profile?.language ?? ""
        cityLabel.text = "Город"
        cityDataLabel.text = profile?.city ?? ""
        if let tabbarCount = self.tabBarController?.viewControllers?.count, tabbarCount == 3, finishedView != nil, rateView != nil {
            self.finishedView.removeFromSuperview()
            self.rateView.removeFromSuperview()
        }
    }
    
    @IBAction func finishedWorksPressed(_ sender: UIButton) {
        if self.feedBacks != nil {
            FinishedWorksVC.open(vc: self,feedBacks: self.feedBacks! )
        }
    }
    @IBAction func editPressed(_ sender: Any) {
        EditProfileVC.open(vc: self, profile: self.profile)
    }
    @IBAction func logOutPressed(_ sender: Any) {
        let navigationController = UINavigationController()
        navigationController.addChild(CheckIINVC())
        let alert = UIAlertController(title: "Выйти?", message: "", preferredStyle: UIAlertController.Style.alert)
               
            alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { action in
                Constants.shared().clear()
                let navigationController = UINavigationController()
                if #available(iOS 13.0, *) {
                    navigationController.overrideUserInterfaceStyle = .light
                }
                navigationController.modalPresentationStyle = .fullScreen
                navigationController.addChild(CheckIINVC())
                self.present(navigationController, animated: true, completion: nil)
            }))
               
        alert.addAction(UIAlertAction(title: "Нет", style: .destructive, handler: { action in
                  
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
