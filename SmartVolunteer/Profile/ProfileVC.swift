//
//  ProfileVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/29/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import SDWebImage
import Cosmos
import Localize_Swift

class ProfileVC: ScrollStackController {

    var profile : Profile?
    var feedBacks: Feedbacks?
    var imagePicker = UIImagePickerController()
    var iinLabel = UILabel()
    var iinDataLabel = UILabel()
    var nameLabel = UILabel()
    var nameDataLabel = UILabel()
    var surnameLabel = UILabel()
    var surnameDataLabel = UILabel()
    var phoneLabel = UILabel()
    var phoneDataLabel = UILabel()
    var langLabel = UILabel()
    var langDataLabel = UILabel()
    var cityLabel = UILabel()
    var cityDataLabel = UILabel()
    var worksCountLabel = UILabel()
    var heightConst = NSLayoutConstraint()
    var rateView = CosmosView()
    var safetyLoginLabel = UILabel()
    var switcher = UISwitch()
    var additionInfo = UIButton()
    var editButton = UIButton()
    var logOutButton = UIButton()
    var finishedWorks = UIButton()
    var avatarImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        setNavForTaraz()
        if Constants.shared().getToken() == nil { return }
        getData()
        getFeedbacks()
    }
    
    // ui
    func setViews(){
        stackView.removeAllArrangedSubviews()
        self.stackView.setProperties(axis: .vertical, alignment: .fill, spacing: 20, distribution: .fill)
        stackView.setSpacing(top: 0, left: 20, right: 20, bottom: 20)
        
        setAvaAndRate()
        setDataView()
        
        setButtons()
  
    }
    func setAvaAndRate(){
        // image
        
        if profile?.avatar != nil{
            avatarImageView.sd_setImage(with: URL(string: self.profile!.avatar!.encodeUrl), placeholderImage: #imageLiteral(resourceName: "photo user"),completed: nil)
        }
        let avatarView = UIView()
        avatarView.addSubview(avatarImageView)
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.easy.layout(Edges(),Height(80))
        avatarImageView.cornerRadius(radius: 40, width: 0)
        avatarImageView.addTapGestureRecognizer {
            self.thisIsTheFunctionWeAreCalling()
        }
        self.stackView.addArrangedSubview(avatarView)
        
        // CosmosView
        let cosmosContainer = UIView()
        cosmosContainer.addSubview(rateView)
        rateView.easy.layout(Top(),Bottom(),CenterX())
        rateView.rating = self.profile?.ratingScore ?? 0.0
        rateView.settings.updateOnTouch = false
        rateView.settings.starSize = 20
        rateView.settings.totalStars = 5
        stackView.addArrangedSubview(cosmosContainer)
        if let tabbarCount = self.tabBarController?.viewControllers?.count, tabbarCount == 3 {
            self.finishedWorks.isHidden = true
            self.rateView.isHidden = true
        }
        stackView.addArrangedSubview(finishedWorks)
        
    }
    func setDataView() {
        // profile data
        let profileDataView = UIView()
        let dataStackView = UIStackView()


        profileDataView.addSubview(dataStackView)
        dataStackView.easy.layout(Edges(18))
        dataStackView.setProperties(axis: .vertical, alignment: .fill, spacing: 15, distribution: .fill)
        profileDataView.backgroundColor = .white
        profileDataView.dropShadow()
        
        profileDataView.layer.cornerRadius = 10
        
        dataStackView.addArrangedSubview(horizontalTwoLabels(title: "ИИН".localized(), data: profile?.iin ?? "-"))
        dataStackView.addArrangedSubview(horizontalTwoLabels(title: "Имя".localized(), data: profile?.name ?? "-"))
        dataStackView.addArrangedSubview(horizontalTwoLabels(title: "Фамилия".localized(), data: profile?.surname ?? "-"))
        dataStackView.addArrangedSubview(horizontalTwoLabels(title: "Телефон".localized(), data: profile?.phone ?? "-"))
        dataStackView.addArrangedSubview(horizontalTwoLabels(title: "Язык".localized(), data: profile?.language ?? "-"))
        dataStackView.addArrangedSubview(horizontalTwoLabels(title: "Город".localized(), data: profile?.city ?? "-"))
        dataStackView.addArrangedSubview(safetyLogin())
        self.stackView.addArrangedSubview(profileDataView)
    }
    func horizontalTwoLabels(title: String, data: String) -> UIView {
        let dataView = UIView()
        let nameLabel = UILabel()
        let nameDataLabel = UILabel()
        dataView.addSubview(nameLabel)
        dataView.addSubview(nameDataLabel)
        nameLabel.setProperties(text: title, textColor: #colorLiteral(red: 0.5921568627, green: 0.6784313725, blue: 0.7137254902, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
        nameDataLabel.setProperties(text: data, textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14,weight: .semibold), textAlignment: .left, numberLines: 1)
        nameDataLabel.easy.layout(CenterX(18),Top(),Bottom())
        nameLabel.easy.layout(Left(18),Top(),Bottom())
        return dataView
    }
    func safetyLogin() -> UIView {
        let dataView = UIView()
        let nameLabel = UILabel()
        self.switcher.isOn = UserDefaults.standard.bool(forKey: "secure")
        switcher.addTarget(self, action: #selector(switchState(_:)), for: .valueChanged)
        dataView.addSubview(nameLabel)
        dataView.addSubview(switcher)
        nameLabel.setProperties(text: "Безопасный вход".localized(), textColor: #colorLiteral(red: 0.5921568627, green: 0.6784313725, blue: 0.7137254902, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
        
        switcher.easy.layout(CenterX(18),Top(),Bottom())
        nameLabel.easy.layout(Left(18),Top(),Bottom())
        return dataView
    }
    func setButtons(){
        finishedWorks.easy.layout(Height(52))
        finishedWorks.setTitleColor(#colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), for: .normal)
        finishedWorks.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1))
        self.finishedWorks.setTitle("Выполненные работы".localized(), for: .normal)
        finishedWorks.addTarget(self, action: #selector(feedBackPressed(_:)), for: .touchUpInside)
        
        additionInfo.setTitleColor(#colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), for: .normal)
        additionInfo.isHidden = Constants.shared().isTaraz
        additionInfo.setTitle("Доп. информация".localized(), for: .normal)
        additionInfo.easy.layout(Height(52))
        additionInfo.addTarget(self, action: #selector(addInfoPressed(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(additionInfo)
        
        editButton.easy.layout(Height(52))
        editButton.setTitleColor( #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), for: .normal)
        editButton.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1))
        editButton.setTitle("Редактировать профиль".localized(), for: .normal)
        editButton.addTarget(self, action: #selector(editButtonPressed(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(editButton)
        
        logOutButton.easy.layout(Height(52))
        logOutButton.setTitleColor(#colorLiteral(red: 0.9989094138, green: 0.2617629766, blue: 0.262750864, alpha: 1), for: .normal)
        logOutButton.setTitle("Выйти".localized(), for: .normal)
        logOutButton.cornerRadius(radius: 10, width: 1, color: #colorLiteral(red: 0.9989094138, green: 0.2617629766, blue: 0.262750864, alpha: 1))
        logOutButton.addTarget(self, action: #selector(logOutPressed(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(logOutButton)
    }
    
    // MARK: - Actions
    @objc func feedBackPressed(_ sender: UIButton){
        if self.feedBacks != nil {
            FinishedWorksVC.open(vc: self,feedBacks: self.feedBacks! )
        }
    }

    @objc func addInfoPressed(_ sender: UIButton){
        LinksVC.open(vc: self)
    }
    @objc func editButtonPressed(_ sender: UIButton){
        EditProfileVC.open(vc: self, profile: self.profile)
    }
    @objc func logOutPressed(_ sender: UIButton){
        let navigationController = UINavigationController()
        navigationController.addChild(CheckIINVC())
        let alert = UIAlertController(title: "Выйти".localized() + "?", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Да".localized(), style: .default, handler: { action in
            Constants.shared().clear()
            let navigationController = UINavigationController()
            if #available(iOS 13.0, *) {
                navigationController.overrideUserInterfaceStyle = .light
            }
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.addChild(CheckIINVC())
            self.present(navigationController, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Нет".localized(), style: .destructive, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func switchState(_ sender:UISwitch){
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: "secure")
        } else {
            UserDefaults.standard.set(false, forKey: "secure")
        }
    }
    @objc  override func setText() {
        //Перезагрузка заголовка
        setViews()
        self.finishedWorks.setTitle("Выполненные работы".localized(), for: .normal)
        self.logOutButton.setTitle("Выйти".localized(), for: .normal)
        self.editButton.setTitle("Редактировать профиль".localized(), for: .normal)
        self.additionInfo.setTitle("Доп. информация".localized(), for: .normal)
    }

    static func open(vc: UIViewController){
        let vcc = UIViewController()
        if let nav = vc.navigationController {
            nav.pushViewController(vcc, animated: true)
        }
    }
    // req
    func getData(){
        self.startLoad()
        Requests.shared().getProfile { (response) in
            self.stopLoad()
            if response?.profile != nil{
                self.profile = response?.profile
                self.setViews()
            }
        }
    }
    func getFeedbacks(){
        if let tabbarCount = self.tabBarController?.viewControllers?.count, tabbarCount != 3 {
            Requests.shared().getFeedback(page: 1) { (result) in
                self.feedBacks = result
                self.worksCountLabel.text = "\(result?.feedbacks?.data?.count ?? 0)"
                let i = "\(result?.feedbacks?.data?.count ?? 0)"
                self.finishedWorks.setTitle(("Выполненные работы".localized() + " \(i)"), for: .normal)
            }
        }
    }

}

extension ProfileVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
    func ph(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                    print("Button capture")
            

                    imagePicker.delegate = self
                    imagePicker.sourceType = .savedPhotosAlbum
                    imagePicker.allowsEditing = false

                    present(imagePicker, animated: true, completion: nil)
                }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.editedImage.rawValue)] as! UIImage
        picker.dismiss(animated: true, completion: nil)
        uploadImage(image: image)
    }
    func uploadImage(image: UIImage) {
        
        let url = URL(string: Constants.shared().baseUrl + "profile/avatar")
        
        let session = URLSession.shared
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
            
         
            urlRequest.setValue("multipart/form-data; boundary=avatar", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + Constants.shared().getToken()!, forHTTPHeaderField: "Authorization")
    
        let imgData = image.jpegData(compressionQuality: 0.5)!
                var iData = imgData
                // Add the image data to the raw http request data
        iData.append("\r\n--avatar\r\n".data(using: .utf8)!)
        iData.append("Content-Disposition: form-data; name=\"avatar\"; filename=\"filename\"\r\n".data(using: .utf8)!)
        iData.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        iData.append(image.pngData()!)
        
        iData.append("\r\n--avatar--\r\n".data(using: .utf8)!)
        
            // Send a POST request to the URL, with the data we created earlier
            session.uploadTask(with: urlRequest, from: imgData, completionHandler: { responseData, response, error in
                if error == nil {
                    let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                    if let json = jsonData as? [String: Any] {
                        print(json)
                    }
                    DispatchQueue.main.async {
                        self.avatarImageView.image = image
                    }
                }else{
                    self.showAlert(title: "Қате", message: "Бір-екі миніттан кейін қайталаңыз")
                }
            }).resume()
        }


}
