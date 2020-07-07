//
//  SignUpVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/23/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import AKMaskField

enum AppLanguage {
    case qazaq
    case russian
}

class SignUpVC: ScrollStackController, UITextFieldDelegate, CityPickerProtocol {
    
    func pickCity(cityName: String, id: Int) {
        self.view.endEditing(true)
        self.cityTextField.text = cityName
        self.cityId = id
    }
    

    var mainLanguage : AppLanguage?{
        didSet{
            self.setLang(lang: self.mainLanguage!)
        }
    }
    var cityId = 0
    var picker = ChooseCityVC()
    let iinTextField = UITextField()
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let phoneTextField = AKMaskField()
    let cityTextField = UITextField()
    let passwordTextField = UITextField()
    let russianCheckBox = UIImageView()
    let qazaqCheckBox = UIImageView()
    let continueButton = GeneralButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.mainLanguage = .russian
        picker.pickerDelegate = self
        Requests.shared().getCities { (response) in
            self.picker.cities = response?.cities ?? []
        }
//        picker.modalPresentationStyle = .overCurrentContext
//        picker.modalTransitionStyle = .
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.makeNCTranslucent()
    }
    
    private func setViews(){
        self.stackView.setProperties(axis: .vertical, alignment: .fill, spacing: 20, distribution: .fill)
        // Logo image
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "GroupLogo")
        let iView = UIView()
        iView.addSubview(imageView)
        imageView.easy.layout(Width(70), Height(54), Top(50), Bottom(10), CenterX())
        
        stackView.addArrangedSubview(iView)
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = "Регистрация волонтера"
        titleLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        titleLabel.font = titleLabel.font.withSize(21)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        stackView.addArrangedSubview(titleLabel)
        titleLabel.easy.layout(CenterX())
        
        // TextFields
        
        iinTextField.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        iinTextField.placeholder = "ИИН"
        iinTextField.keyboardType = .numberPad
        iinTextField.borderStyle = .roundedRect
        iinTextField.delegate = self
        stackView.addArrangedSubview(iinTextField)
        iinTextField.easy.layout(Left(36), Right(36), Height(44))
        
        
        firstNameTextField.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        firstNameTextField.placeholder = "Имя"
        firstNameTextField.keyboardType = .default
        firstNameTextField.borderStyle = .roundedRect
        firstNameTextField.autocapitalizationType = .words
        stackView.addArrangedSubview(firstNameTextField)
        firstNameTextField.easy.layout(Left(36), Right(36), Height(44))
        
        
        lastNameTextField.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        lastNameTextField.placeholder = "Фамилия"
        lastNameTextField.keyboardType = .default
        lastNameTextField.borderStyle = .roundedRect
        lastNameTextField.autocapitalizationType = .words
        stackView.addArrangedSubview(lastNameTextField)
        lastNameTextField.easy.layout(Left(36), Right(36), Height(44))
        
        
        phoneTextField.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        phoneTextField.placeholder = "Номер телефона"
        phoneTextField.maskExpression = "+7 ({ddd}) {ddd} {dd} {dd}"

        phoneTextField.keyboardType = .numberPad
        phoneTextField.borderStyle = .roundedRect
        
        stackView.addArrangedSubview(phoneTextField)
        phoneTextField.easy.layout(Left(36), Right(36), Height(44))
        
        
        
        cityTextField.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        cityTextField.placeholder = "Город или поселение"
        cityTextField.borderStyle = .roundedRect
        cityTextField.addTapGestureRecognizer {
            self.present(self.picker, animated: true, completion: nil)
        }
        stackView.addArrangedSubview(cityTextField)
        cityTextField.easy.layout(Left(36), Right(36), Height(44))
        
        
        passwordTextField.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        passwordTextField.placeholder = "Пароль"
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        
        stackView.addArrangedSubview(passwordTextField)
        passwordTextField.easy.layout(Left(36), Right(36), Height(44))
        
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
            self.setLang(lang: .qazaq)
        }
        russianView.addTapGestureRecognizer {
            self.setLang(lang: .russian)
        }
        
        // Button
        self.continueButton.title = "Зарегистрироваться"
        self.continueButton.isAccessible = true
        self.continueButton.addTarget(self, action: #selector(self.register), for: .touchUpInside)
        self.stackView.addArrangedSubview(continueButton)
        
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 12
    }
    
    static func open(vc: UIViewController){
        let viewController = self.init()
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
    
    @objc func register(){
        if iinTextField.text != nil && iinTextField.text != "" &&
            firstNameTextField.text != nil && firstNameTextField.text != "" &&
                lastNameTextField.text != nil && lastNameTextField.text != "" &&
                    iinTextField.text != nil && iinTextField.text != "" &&
                        phoneTextField.text != nil && phoneTextField.text != "" &&
                            passwordTextField.text != nil && passwordTextField.text != "" && self.cityId != 0
        {
            self.startLoad()
            var langId = 0
            if self.mainLanguage == .qazaq{
                langId = 1
            }else{
                langId = 2
            }
            let json = [
                "iin" : iinTextField.text!,
                "phone" : phoneTextField.text!,
                "name" : firstNameTextField.text!,
                "surname" : lastNameTextField.text!,
                "language_id" : langId,
                "city_id" : self.cityId,
                "password" : passwordTextField.text!,
                "platform" : "IOS",
                "device_token" : "wws"
            ] as [String : AnyObject]
            Requests.shared().register(params: json) { (response) in
                self.stopLoad()
                if response?.success ?? false{
                    Constants.shared().setRole(isVolunteer: response?.isVolunteer ?? false)
                    Constants.shared().saveToken(token: response!.token!)
                    let tabbar = TabbarViewController()
                    tabbar.modalPresentationStyle = .fullScreen
                    self.present(tabbar, animated: true, completion: nil)
                }else{
                    self.showError(text: "что то не то")
                }
            }
        }
        else{
            self.showError(text: "Заполните все поля")
        }
    }
    
}
