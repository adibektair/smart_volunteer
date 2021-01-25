//
//  ResetPasswordVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 1/26/21.
//  Copyright © 2021 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class ResetPasswordVC: ScrollStackController {

    let passwordTextField = UITextField()
    let continueButton = GeneralButton()
    var phone = ""
    var code = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }
    func setViews(){
        stackView.setSpacing(top: 120, left: 32, right: 32, bottom: 80)
        passwordTextField.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        passwordTextField.placeholder = "Новый Пароль".localized()
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        
        stackView.addArrangedSubview(passwordTextField)
        passwordTextField.easy.layout(Left(36), Right(36), Height(44))
        
        self.continueButton.title = "Поменять пароль".localized()
        self.continueButton.isAccessible = true
        self.continueButton.addTarget(self, action: #selector(self.reset), for: .touchUpInside)
        self.stackView.addArrangedSubview(continueButton)
    }
    @objc func reset(){
        let p = ["phone":self.phone.digits,
                 "password": self.passwordTextField.text!,
                 "code": self.code
        ] as [String:String]
        print(p)
        Requests.shared().resetPassword(params: p) { (response) in
            if response?.success ?? false{
                Constants.shared().setRole(isVolunteer: response?.isVolunteer ?? response?.user?.isVolunteer ?? false)
                if let token = response?.user?.token ?? response?.token {
                    Constants.shared().saveToken(token: token)
                }
                let tabbar = TabbarViewController()
                tabbar.modalPresentationStyle = .fullScreen
                self.present(tabbar, animated: true, completion: nil)
            }else{
                var err = ""
                for i in (response?.errors ?? []){
                   err = err + "\n\(i)"
                }
                self.showError(text: err)
            }
        }
    }

    static func open(vc: UIViewController, phone: String = "",code:String){
        let viewController = ResetPasswordVC()
        viewController.code = code
        viewController.phone = phone
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }

}
