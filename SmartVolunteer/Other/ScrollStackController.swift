//
//  ScrollStackController.swift
//  Tensend
//
//  Created by Sultan on 1/26/20.
//  Copyright © 2020 Sultan. All rights reserved.
//

import UIKit
import EasyPeasy

let dark = UIView()
let small = UIView()
var indicator = UIActivityIndicatorView()

class ScrollStackController: UIViewController {
    
    
    open var scrollView = UIScrollView()
    open var stackView = UIStackView()
    open var bottomAnchor = NSLayoutConstraint()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setBackButton()
        self.view.addSubview(scrollView)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let bottomAnchorCalc = self.tabBarController?.tabBar.frame.size.height ?? 0
        bottomAnchor = scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -bottomAnchorCalc)
        bottomAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        if #available(iOS 11.0, *) {
            stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
        } else {
            stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        }
        scrollView.addSubview(stackView)
        scrollView.keyboardDismissMode = .onDrag
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Подписываемся на открытие клавы
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //удаляем обзерверы открытия клавы
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc open func setText() {} // Если нужны переводы, нужно делать override
    
    @objc open func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //let bottomAnchorCalc = self.tabBarController?.tabBar.frame.size.height ?? 0
            UIView.animate(withDuration: 0.3){
                self.bottomAnchor.constant = -(keyboardSize.height)
            }
        }
    }
    
    @objc open func keyboardWillHide(notification _: NSNotification) {
        UIView.animate(withDuration: 0.3){
            self.bottomAnchor.constant = 0
        }
    }
    
    open func addLine() {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.262745098, blue: 0.337254902, alpha: 0.05)
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        line.easy.layout(Left(30),Right(30))
        stackView.addArrangedSubview(line)
    }
    
    func startLoading(){
        
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        dark.frame = CGRect(x: 0, y: 0, width: w, height: h)
        dark.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        small.frame.size = CGSize(width: w * 0.25, height: w * 0.25)
        small.backgroundColor = UIColor.white
        small.layer.cornerRadius = 15
        small.center = dark.center
        if #available(iOS 13.0, *) {
            indicator.style = UIActivityIndicatorView.Style.medium
        } else {
            // Fallback on earlier versions
        }
        indicator.color = UIColor.black
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        } else {
            // Fallback on earlier versions
        }
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicator.transform = transform
        indicator.center = dark.center
        dark.addSubview(small)
        dark.addSubview(indicator)
        view.addSubview(dark)
        indicator.startAnimating()
    }
    func stopLoading(){
        dark.removeFromSuperview()
    }
    
    func showError(text : String){
        self.showAlert(title: "Внимание", message: text)
    }
}
extension UIViewController{
    func startLoad(){
        
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        dark.frame = CGRect(x: 0, y: 0, width: w, height: h)
        dark.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        small.frame.size = CGSize(width: w * 0.25, height: w * 0.25)
        small.backgroundColor = UIColor.white
        small.layer.cornerRadius = 15
        small.center = dark.center
        if #available(iOS 13.0, *) {
            indicator.style = UIActivityIndicatorView.Style.medium
        } else {
            // Fallback on earlier versions
        }
        indicator.color = UIColor.black
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        } else {
            // Fallback on earlier versions
        }
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicator.transform = transform
        indicator.center = dark.center
        dark.addSubview(small)
        dark.addSubview(indicator)
        view.addSubview(dark)
        indicator.startAnimating()
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        indicator.transform = transform
        indicator.center = dark.center
        dark.addSubview(small)
        dark.addSubview(indicator)
        view.addSubview(dark)
        indicator.startAnimating()
    }
    func stopLoad(){
        dark.removeFromSuperview()
    }
    
}
