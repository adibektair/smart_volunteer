//
//  SMSCodeVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 1/17/21.
//  Copyright © 2021 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import AKMaskField

class SMSCodeVC: ScrollStackController, UITextFieldDelegate {
    
    // MARK: - Variables
    let phoneTextField = AKMaskField()
    let iinTextField = UITextField()
    let smsCodeTextField = UITextField()
    let continueButton = GeneralButton()
    var resetPass = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    @objc func sendReq(){
        if self.smsCodeTextField.isHidden {
            self.sendCode()
        } else {
            self.checkCode()
        }
    }
    
    @objc func textFieldChange(_ textField: UITextField){
        if textField == phoneTextField {
            smsCodeTextField.text = ""
            smsCodeTextField.isHidden = true
        } else if textField.text!.count > 4 {
            textField.text!.removeLast()
        }
    }

    // MARK: - Functions
    func setViews(){
        setLogo()
        IIN()
        phone()
        smsCodeText()
        button()
    }
    
    func setLogo(){
        // Logo image
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "GroupLogo")
        let iView = UIView()
        iView.addSubview(imageView)
        imageView.easy.layout(Width(70), Height(54), Top(50), Bottom(10), CenterX())
        
        stackView.addArrangedSubview(iView)
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = "Подтверждение номера".localized()
        titleLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        titleLabel.font = titleLabel.font.withSize(21)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.easy.layout(CenterX(),Bottom(30))
        stackView.addArrangedSubview(titleLabel)
        
    }
    func IIN(){
        iinTextField.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        iinTextField.placeholder = "ИИН".localized()
        iinTextField.keyboardType = .numberPad
        iinTextField.borderStyle = .roundedRect
        iinTextField.isEnabled = false
        
        stackView.addArrangedSubview(iinTextField)
        iinTextField.easy.layout(Left(36), Right(36), Height(44))
    }
    func phone(){
        phoneTextField.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        phoneTextField.placeholder = "Номер телефона".localized()
        phoneTextField.maskExpression = "+7 ({ddd}) {ddd} {dd} {dd}"

        phoneTextField.keyboardType = .numberPad
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingDidBegin)
        stackView.addArrangedSubview(phoneTextField)
        phoneTextField.easy.layout(Left(36), Right(36), Height(44))
    }
    func smsCodeText(){
        smsCodeTextField.isHidden = true
        smsCodeTextField.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        smsCodeTextField.placeholder = "СМС-код"
        smsCodeTextField.keyboardType = .numberPad
        smsCodeTextField.borderStyle = .roundedRect
        smsCodeTextField.delegate = self
        smsCodeTextField.easy.layout(Left(36), Right(36), Height(44))
        smsCodeTextField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        stackView.addArrangedSubview(smsCodeTextField)
    }
    
    func button(){
        self.continueButton.title = "Отправить код".localized()
        self.continueButton.isAccessible = true
        self.continueButton.addTarget(self, action: #selector(self.sendReq), for: .touchUpInside)
        self.stackView.addArrangedSubview(continueButton)
    }
    
    func sendCode(){
        if (self.phoneTextField.text?.digits.count ?? 0) == 11, let id = UIDevice.current.identifierForVendor?.uuidString {
            let p = ["phone" : self.phoneTextField.text!.digits,
                     "device_id": id] as [String: AnyObject]
            Requests.shared().sendCode(params: p) { (result) in
                if result?.success ?? false {
                    self.smsCodeTextField.isHidden = false
                    self.continueButton.title = "Подтвердить код".localized()
                }
            }
        }
    }
    
    func checkCode(){
        if let code = smsCodeTextField.text, code.count == 4 {
            let p = ["phone" : self.phoneTextField.text!.digits,
                     "code": code] as [String: AnyObject]
            Requests.shared().checkCode(params: p) { (result) in
                if result?.isCorrect ?? false {
                    if self.resetPass {
                        ResetPasswordVC.open(vc: self, phone: self.phoneTextField.text!,code: code)
                    } else {
                        SignUpVC.open(vc: self,iin: self.iinTextField.text!, phone: self.phoneTextField.text!,code: code)
                    }
                    
                } else {
                    self.showAlert(title: "Внимание".localized(), message: "Неверный код".localized())
                }
            }
        }
    }
    // MARK: - Navigation
    static func open(vc: UIViewController, iin: String,resetPass: Bool = false) {
        let vcc = SMSCodeVC()
        vcc.iinTextField.text = iin
        vcc.resetPass = resetPass
        if let nav = vc.navigationController {
            nav.pushViewController(vcc, animated: true)
        }
    }
    

}
