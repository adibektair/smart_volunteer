//
//  PasswordVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/23/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit

class PasswordVC: UIViewController {

    var iin : String?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!{
        didSet{
            self.logInButton.cornerRadius(radius: 10, width: 0)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.becomeFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.makeNCTranslucent()
    }


    @IBAction func logInButtonPressed(_ sender: Any) {
        if self.passwordTextField.text != nil && self.passwordTextField.text != ""{
            let json = ["iin" : iin!, "password" : self.passwordTextField.text!, "platform" : "IOS", "device_token" : "wws"] as [String : AnyObject]
            self.startLoad()
            Requests.shared().logIn(params: json) { (response) in
                self.stopLoad()
                if response?.success ?? false{
                    Constants.shared().setRole(isVolunteer: response?.isVolunteer ?? false)
                    Constants.shared().saveToken(token: response!.token!)
                    let tabbar = TabbarViewController()
                    tabbar.modalPresentationStyle = .fullScreen
                    self.present(tabbar, animated: true, completion: nil)
                }else{
                    self.showAlert(title: "Внимание".localized(), message: "Неверный пароль".localized())
                }
            }
        }else{
            self.showAlert(title: "Внимание".localized(), message: "Заполните все поля".localized())
        }
    }
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        SMSCodeVC.open(vc: self, iin: iin ?? "",resetPass: true)
    }
    
    static func open(vc: UIViewController, iin : String){
        let viewController = self.init()
        viewController.iin = iin
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
    
}
