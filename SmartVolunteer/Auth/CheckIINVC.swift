//
//  CheckIINVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/22/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import BiometricAuth
import BiometricAuthentication

class CheckIINVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iinTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var becomeVolunteerButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.iinTextField.delegate = self
        self.setViews()
        self.setBackButton()
        if Constants.shared().getToken() != nil && UserDefaults.standard.bool(forKey: "secure") {
            self.showPasscodeAuthentication(message: "SmartVolunteer")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    func showPasscodeAuthentication(message: String) {
        BioMetricAuthenticator.authenticateWithPasscode(reason: message) { [weak self] (result) in
            switch result {
            case .success( _):
                let tabbar = TabbarViewController()
                tabbar.modalPresentationStyle = .fullScreen
                self?.present(tabbar, animated: true, completion: nil)
                break
            case .failure(let error):
                
                print(error.message())
            }
        }
    }
    func setViews(){
        self.setButtonState(state: false)
        self.nextButton.cornerRadius(radius: 10, width: 0)
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        if let t = iinTextField.text, t.count == 12, !check(iin:t) {
            self.showAlert(title: "Внимание".localized(), message: "Неверный иин".localized())
            return
        }
        self.startLoad()
        let json = ["iin" : self.iinTextField.text!] as [String : AnyObject]
        Requests.shared().checkLogin(params: json) { (response) in
            self.stopLoad()
            if response?.isExists ?? false{
                PasswordVC.open(vc: self, iin: self.iinTextField.text!)
            }else{
                SMSCodeVC.open(vc: self,iin: self.iinTextField.text!)
//                SignUpVC.open(vc: self)
            }
        }
        
    }
    @IBAction func becomeVolunteerButtonPressed(_ sender: Any) {
//        SignUpVC.open(vc: self)
        SMSCodeVC.open(vc: self,iin: self.iinTextField.text!)
    }
    @IBAction func skipButtonPressed(_ sender: Any) {
        let tabBar = TabbarViewController()
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: true, completion: nil)
    }
    
    private func setButtonState(state : Bool){
        if state{
            self.nextButton.backgroundColor = #colorLiteral(red: 0.07344619185, green: 0.5308970809, blue: 0.9896835685, alpha: 1)
            self.nextButton.isEnabled = true
        }
        else{
            self.nextButton.backgroundColor = #colorLiteral(red: 0.6575629115, green: 0.7900038362, blue: 0.9882785678, alpha: 1)
            self.nextButton.isEnabled = false
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        self.setButtonState(state: !(count <= 11))
        return count <= 12
    }
    func check(iin:String) -> Bool {
        let b1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        let b2 = [3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2]
        var a = [Int]()
        var controll = 0
        for i in 0..<12 {
            let start = iin.index(iin.startIndex, offsetBy: i)
            let end = iin.index(iin.startIndex, offsetBy: i + 1)
            let range = start..<end
            let sub = iin[range]
            let substr = String(sub)
            a.append( Int(substr)!)
            if (i < 11) { controll += a[i] * b1[i] }
        }
        controll = controll % 11;
        if (controll == 10) {
            controll = 0;
            for i in 0..<11 { controll += a[i] * b2[i] }
            controll = controll % 11;
        }
        if (controll != a[11]) { return false }
        return true;
    }
}
