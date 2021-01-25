//
//  EditProfileVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/30/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import SDWebImage
import AKMaskField
import Localize_Swift

class EditProfileVC: ScrollStackController, CityPickerProtocol {

    func pickCity(cityName: String, id: Int) {
        self.view.endEditing(true)
        self.cityTextField.text = cityName
        self.cityId = id
    }
    var cityId = 0
    var picker = ChooseCityVC()
    var profile : Profile?
    let russianCheckBox = UIImageView()
    let qazaqCheckBox = UIImageView()
    var mainLanguage : AppLanguage?{
        didSet{
            self.setLang(lang: self.mainLanguage!)
        }
    }
    let nameTextField = UITextField()
    let surnameTextField = UITextField()
    let phoneTextField = AKMaskField()
    let cityTextField = UITextField()
    let passwordTextField = UITextField()
    let oldPasswordTextField = UITextField()
    let continueButton = GeneralButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Редактировать профиль".localized()
        picker.pickerDelegate = self
        Requests.shared().getCities { (response) in
            self.picker.cities = response?.cities ?? []
        }
    }
    @objc override func setText() {
        //Перезагрузка заголовка
//        setViews()
//        stackView.reloadInputViews()
        
    }
    func setViews(){
        stackView.removeAllArrangedSubviews()
        self.stackView.setProperties(axis: .vertical, alignment: .fill, spacing: 15, distribution: .fill)
        // image
        let imageView = UIImageView()
        let avatarView = UIView()
        if let avatar = self.profile?.avatar{
            imageView.sd_setImage(with: URL(string: avatar.encodeUrl), completed: nil)
        }else{
            imageView.image = #imageLiteral(resourceName: "photo user")
        }
        avatarView.addSubview(imageView)
        imageView.cornerRadius(radius: 40, width: 0.5, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
        imageView.easy.layout(Height(80), Width(80), CenterX(), Top(20), Bottom(10))
        self.stackView.addArrangedSubview(avatarView)

        // iin
        let iinLabel = UILabel()
        iinLabel.text = "ИИН".localized()
        iinLabel.font = iinLabel.font.withSize(15)
        self.stackView.addArrangedSubview(iinLabel)
        iinLabel.easy.layout(Left(24))
        let iinTextField = UITextField()
        iinTextField.isEnabled = false
        iinTextField.text = self.profile?.iin
        iinTextField.borderStyle = .roundedRect
        iinTextField.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        iinTextField.font = iinTextField.font?.withSize(15)
        self.stackView.addArrangedSubview(iinTextField)
        iinTextField.easy.layout(Left(24), Right(24), Height(44))
        
        // name
        let nameLabel = UILabel()
        nameLabel.text = "Имя".localized()
        nameLabel.font = nameLabel.font.withSize(15)
        self.stackView.addArrangedSubview(nameLabel)
        nameLabel.easy.layout(Left(24))
        nameTextField.autocapitalizationType = .words
        nameTextField.text = self.profile?.name
        nameTextField.borderStyle = .roundedRect
        nameTextField.font = nameTextField.font?.withSize(15)
        self.stackView.addArrangedSubview(nameTextField)
        nameTextField.easy.layout(Left(24), Right(24), Height(44))
        
        // surname
        let surnameLabel = UILabel()
        surnameLabel.text = "Фамилия".localized()
        surnameLabel.font = surnameLabel.font.withSize(15)
        self.stackView.addArrangedSubview(surnameLabel)
        surnameLabel.easy.layout(Left(24))
        surnameTextField.autocapitalizationType = .words
        surnameTextField.text = self.profile?.surname
        surnameTextField.borderStyle = .roundedRect
        surnameTextField.font = surnameTextField.font?.withSize(15)
        self.stackView.addArrangedSubview(surnameTextField)
        surnameTextField.easy.layout(Left(24), Right(24), Height(44))
        
        // phone
        let phoneLabel = UILabel()
        phoneLabel.text = "Телефон".localized()
        phoneLabel.font = phoneLabel.font.withSize(15)
        self.stackView.addArrangedSubview(phoneLabel)
        phoneLabel.easy.layout(Left(24))
        
        phoneTextField.keyboardType = .numberPad
        phoneTextField.maskExpression = "+7 ({ddd}) {ddd} {dd} {dd}"
        phoneTextField.text = self.profile?.phone
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.font = phoneTextField.font?.withSize(15)
        self.stackView.addArrangedSubview(phoneTextField)
        phoneTextField.easy.layout(Left(24), Right(24), Height(44))
        
        // citu
        let cityLabel = UILabel()
        cityLabel.text = "Город".localized()
        cityLabel.font = cityLabel.font.withSize(15)
        self.stackView.addArrangedSubview(cityLabel)
        cityLabel.easy.layout(Left(24))
        
        cityTextField.text = self.profile?.city
        cityTextField.borderStyle = .roundedRect
        cityTextField.font = cityTextField.font?.withSize(15)
        self.stackView.addArrangedSubview(cityTextField)
        cityTextField.easy.layout(Left(24), Right(24), Height(44))
        cityTextField.addTapGestureRecognizer {
            self.present(self.picker, animated: true, completion: nil)
        }
        
        // citu
        let langLabel = UILabel()
        langLabel.text = "Язык".localized()
        langLabel.font = langLabel.font.withSize(15)
        self.stackView.addArrangedSubview(langLabel)
        langLabel.easy.layout(Left(24))
        
        // Language
              
      let horizontalStackView = UIStackView()
      horizontalStackView.setProperties(axis: .horizontal, alignment: .fill, spacing: 11, distribution: .equalSpacing)
      let russianView = UIView()
      russianView.cornerRadius(radius: 8, width: 0.5, color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
      let qazaqView = UIView()
      qazaqView.cornerRadius(radius: 8, width: 0.5, color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
      
      let russianLanguageLabel = UILabel()
      russianLanguageLabel.text = "Русский"
      russianLanguageLabel.textColor = #colorLiteral(red: 0.1907444894, green: 0.4766811728, blue: 0.96295017, alpha: 1)
      russianLanguageLabel.font = russianLanguageLabel.font.withSize(14)
      russianView.addSubview(russianLanguageLabel)
      
      
      russianCheckBox.cornerRadius(radius: 8, width: 2, color: #colorLiteral(red: 0.6575629115, green: 0.7900038362, blue: 0.9882785678, alpha: 1))
      russianView.addSubview(russianCheckBox)

      let qazaqLanguageLabel = UILabel()
      qazaqLanguageLabel.text = "Қазақ"
      qazaqLanguageLabel.textColor = #colorLiteral(red: 0.1907444894, green: 0.4766811728, blue: 0.96295017, alpha: 1)
      qazaqLanguageLabel.font = qazaqLanguageLabel.font.withSize(14)
      qazaqView.addSubview(qazaqLanguageLabel)
      
      
      qazaqCheckBox.cornerRadius(radius: 8, width: 2, color: #colorLiteral(red: 0.6575629115, green: 0.7900038362, blue: 0.9882785678, alpha: 1))
      qazaqView.addSubview(qazaqCheckBox)

      
      horizontalStackView.addArrangedSubview(russianView)
      horizontalStackView.addArrangedSubview(qazaqView)
      let viewWidth = (UIScreen.main.bounds.size.width - 83) / 2
      russianView.easy.layout(Height(44), Width(viewWidth))
      qazaqView.easy.layout(Height(44), Width(viewWidth))
      russianLanguageLabel.easy.layout(CenterY(), Left(10))
      russianCheckBox.easy.layout(CenterY(), Right(10), Width(16), Height(16))
      qazaqLanguageLabel.easy.layout(CenterY(), Left(10))
      qazaqCheckBox.easy.layout(CenterY(), Right(10), Width(16), Height(16))
      self.stackView.addArrangedSubview(horizontalStackView)
      
      qazaqView.addTapGestureRecognizer {
          self.mainLanguage = .qazaq
      }
      russianView.addTapGestureRecognizer {
          self.mainLanguage = .russian
      }
        if profile!.langId! == 1{
            self.mainLanguage = .qazaq
        }else{
            self.mainLanguage = .russian
        }
        password()
        // Button
        self.continueButton.title = "Сохранить".localized()
        self.continueButton.isAccessible = true
        self.continueButton.addTarget(self, action: #selector(self.editUser), for: .touchUpInside)
        self.stackView.addArrangedSubview(continueButton)
        
    }
    func password(){
        let oldPasswordLabel = UILabel()
        oldPasswordLabel.setProperties(text: "Пароль".localized(), font: .systemFont(ofSize: 15))
        self.stackView.addArrangedSubview(oldPasswordLabel)
        
        oldPasswordTextField.isSecureTextEntry = true
        oldPasswordTextField.placeholder = "**********"
        oldPasswordTextField.borderStyle = .roundedRect
        oldPasswordTextField.font = surnameTextField.font?.withSize(15)
        
        passwordTextField.autocapitalizationType = .words
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "**********"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.font = surnameTextField.font?.withSize(15)
        passwordTextField.addTarget(self, action: #selector(passwordChanged(_:)), for: .editingChanged)
        
        self.stackView.addArrangedSubview(oldPasswordTextField)
        let passwordLabel = UILabel()
        passwordLabel.setProperties(text: "Новый пароль".localized(), font: .systemFont(ofSize: 15))
        self.stackView.addArrangedSubview(passwordLabel)
        self.stackView.addArrangedSubview(passwordTextField)
        oldPasswordTextField.easy.layout(Height(44))
        passwordTextField.easy.layout(Left(24), Right(24), Height(44))
    }
    @objc func passwordChanged(_ textField: UITextField){
        if textField.text!.count > 6 {
            
        }
    }
    func passwordChangeReq(){
        guard let count = self.passwordTextField.text?.count else { return }
        if count == 0  { return }
        guard  let oldPass = oldPasswordTextField.text else {
            return
        }
        let param = ["password": oldPass,
        "new_password": self.passwordTextField.text!] as [String:AnyObject]
        Requests.shared().chagePassWord(params: param) { (result) in
            if result?.success ?? false {
                self.showAlert(title: "Успешно".localized(), message: "Данные успешно сохранены".localized())
                self.navigationController?.popViewController(animated: true)
            } else if let errors = result?.errors, let error = errors.first {
                self.showError(text: error)
            } else {
                self.showError(text: "Произошла ошибка, попробуйте позже".localized())
            }
        }
    }
    @objc func editUser(){
        passwordChangeReq()
        if cityId == 0{
            cityId = profile!.cityId!
        }
        if nameTextField.text != nil && nameTextField.text != "" &&
                surnameTextField.text != nil && surnameTextField.text != "" &&
                        phoneTextField.text != nil && phoneTextField.text != "" &&
                             self.cityId != 0
        {
            
            var langId = 0
            if mainLanguage == .qazaq{
                langId = 1
                Localize.setCurrentLanguage("kk")
            }else{
                langId = 2
                Localize.setCurrentLanguage("ru")
            }
            let json = ["city_id" : cityId,
                        "language_id" : langId,
                        "name" : nameTextField.text!,
                        "surname":surnameTextField.text!,
                        "phone": phoneTextField.text!.digits] as [String : AnyObject]
                   
            Requests.shared().editProfile(params: json) { (response) in
                if response?.success ?? false{
                    if self.mainLanguage == .qazaq{
                        Localize.setCurrentLanguage("kk")
                    }else{
                        Localize.setCurrentLanguage("ru")
                    }
                    self.showAlert(title: "Успешно".localized(), message: "Данные успешно сохранены".localized(), popToRoot: true)
                }else{
                    self.showError(text: "Произошла ошибка, попробуйте позже".localized())

                }
            }
        }else{
            self.showError(text: "Заполните все поля".localized())
        }
        /**
         {
             "city_id":2,
             "language_id":1,
             "name":"sad",
             "surname":"123sad",
             "phone":"7479133233"
         }
         */
       
    }
    private func setLang(lang: AppLanguage){
        switch lang {
        case .qazaq:
            self.qazaqCheckBox.image = #imageLiteral(resourceName: "Shape")
            self.russianCheckBox.image = nil
            self.qazaqCheckBox.cornerRadius(radius: 8, width: 0)
            russianCheckBox.cornerRadius(radius: 8, width: 2, color: #colorLiteral(red: 0.6575629115, green: 0.7900038362, blue: 0.9882785678, alpha: 1))
        default:
            
            self.russianCheckBox.image = #imageLiteral(resourceName: "Shape")
            self.qazaqCheckBox.image = nil
            self.russianCheckBox.cornerRadius(radius: 8, width: 0)
            qazaqCheckBox.cornerRadius(radius: 8, width: 2, color: #colorLiteral(red: 0.6575629115, green: 0.7900038362, blue: 0.9882785678, alpha: 1))
        }
    }
    
    static func open(vc: UIViewController, profile : Profile?){
        let viewController = self.init()
        viewController.profile = profile
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
}
