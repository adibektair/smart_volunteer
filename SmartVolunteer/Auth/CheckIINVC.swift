//
//  CheckIINVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/22/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit

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
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    func setViews(){
        self.setButtonState(state: false)
        self.nextButton.cornerRadius(radius: 10, width: 0)
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        self.startLoad()
        let json = ["iin" : self.iinTextField.text!] as [String : AnyObject]
        Requests.shared().checkLogin(params: json) { (response) in
            self.stopLoad()
            if response?.isExists ?? false{
                PasswordVC.open(vc: self, iin: self.iinTextField.text!)
            }else{
                SignUpVC.open(vc: self)
            }
        }
        
    }
    @IBAction func becomeVolunteerButtonPressed(_ sender: Any) {
        SignUpVC.open(vc: self)
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
}
