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
import Alamofire

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
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var additionInfo: UIButton! {
        didSet{
            self.additionInfo.setTitle("Доп. информация", for: .normal)
        }
    }
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
    @IBOutlet weak var switcher: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Constants.shared().getToken() == nil {
            let v = AnonimView()
            self.view.addSubview(v)
            v.easy.layout(Edges())
        }
        self.switcher.isOn = UserDefaults.standard.bool(forKey: "secure")

        switcher.addTarget(self, action: #selector(switchSate(_:)), for: .valueChanged)
        setBackButton()
        avatarImageView.addTapGestureRecognizer {
            self.thisIsTheFunctionWeAreCalling()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        setNavForTaraz()
        if Constants.shared().getToken() == nil { return }
        self.getData()
        self.getFeedbacks()
    }
    
    func getData(){
        getLinks()
        self.startLoad()
        Requests.shared().getProfile { (response) in
            self.stopLoad()
            self.profile = response?.profile
            self.setViews()
        }
    }
    func getLinks(){
        let url = Constants.shared().baseUrl
        if url.contains("taraz") {
            self.additionInfo.addTarget(self, action: #selector(addInfoPressed(_:)), for: .touchUpInside)
        } else {
            self.additionInfo.isHidden = true
            heightConst.constant = 20
        }
    }
    func getFeedbacks(){
        if let tabbarCount = self.tabBarController?.viewControllers?.count, tabbarCount != 3, finishedView != nil, rateView != nil {
            Requests.shared().getFeedback(page: 1) { (result) in
                     self.feedBacks = result
                     self.worksCountLabel.text = "\(result?.feedbacks?.data?.count ?? 0)"
                     
                 }
        }
    }
    func setViews(){
        if profile?.avatar != nil{
            avatarImageView.sd_setImage(with: URL(string: self.profile!.avatar!.encodeUrl), completed: nil)
        }else{
            avatarImageView.image = #imageLiteral(resourceName: "photo user")
        }
        if let rate = self.rateView {
            rate.settings.updateOnTouch = false
            rate.rating = self.profile?.ratingScore ?? 0.0
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
    @objc func addInfoPressed(_ sender: UIButton){
        LinksVC.open(vc: self)
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
    @objc func switchSate(_ sender:UISwitch){
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: "secure")
        } else {
            UserDefaults.standard.set(false, forKey: "secure")
        }
    }
}

extension ProfileViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
     func thisIsTheFunctionWeAreCalling() {
            let camera = DSCameraHandler(delegate_: self)
            let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            optionMenu.popoverPresentationController?.sourceView = self.view

            let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (alert : UIAlertAction!) in
                camera.getCameraOn(self, canEdit: true)
            }
            let sharePhoto = UIAlertAction(title: "Photo Library", style: .default) { (alert : UIAlertAction!) in
                camera.getPhotoLibraryOn(self, canEdit: true)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
            }
            optionMenu.addAction(takePhoto)
            optionMenu.addAction(sharePhoto)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true, completion: nil)
        }

    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.editedImage.rawValue] as! UIImage
        
        // image is our desired image
        self.upload(image: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func upload(image:UIImage){
        let url = Constants.shared().baseUrl + "profile/avatar"
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            return
          }

          Alamofire.upload(multipartFormData: { (form) in
            form.append(data, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
          }, to: url, encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
              upload.responseString { response in
                print(response.value)
              }
            case .failure(let encodingError):
              print(encodingError)
            }
          })
    }
}
