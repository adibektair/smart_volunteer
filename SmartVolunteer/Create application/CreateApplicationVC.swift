//
//  CreateApplicationVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/26/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy

class CreateApplicationVC: ScrollStackController,UITextViewDelegate {
    
    // MARK: - Variables
    let myApps = UIStackView()
    let textFieldsStackView = UIStackView()
    let titleLabel = UILabel()
    let titleTextField = UITextField()
    let descLabel = UILabel()
    let descTextView = UITextView()
    let city = UITextField()
    let category = UITextField()
    let volCount = UITextField()
    var selectedCity : City?
    var selectedCategory : Data?
    var lastStackview = UIStackView()
    var createButton = UIButton()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    func setView(){
        life()
        stackView.setSpacing( bottom: 30)
        setMyApps()
        mainInfo()
        lastInfo()
        createButtonSetting()
        setNavForTaraz()
    }
    
    // MARK: - Functions
    func life(){
        self.navigationItem.title = "Создание заявки"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
        setBackButton()
        volCount.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        titleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        descTextView.delegate = self
    }
    func setMyApps() {
        guard (Constants.shared().getToken() != nil) else {     return }
        let container = UIView()
        myApps.setProperties(axis: .horizontal, alignment: .fill, spacing: 12, distribution: .fill)
        myApps.setSpacing(top: 14, left: 20, right: 20, bottom: 14)
        let titleLbl = UILabel()
        titleLbl.setProperties(text: "Мои заявки", textColor: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), font: .systemFont(ofSize: 16, weight: .semibold), textAlignment: .left, numberLines: 1)
        let arrowIcon = UIImageView()
        arrowIcon.image = #imageLiteral(resourceName: "RightArrow")
        myApps.addArrangedSubview(titleLbl)
        myApps.addArrangedSubview(UIView())
        myApps.addArrangedSubview(arrowIcon)
        container.addSubview(myApps)
        container.dropShadow()
        container.backgroundColor = .white
        myApps.easy.layout(Edges())
        myApps.addTapGestureRecognizer {
            MyApplicationsVC.open(vc: self)
        }
        stackView.addArrangedSubview(container)
    }
    func mainInfo(){
        let c = UIView()
        let container = UIView()
        c.addSubview(container)
        container.dropShadow()
        container.backgroundColor = .white
        //        container.cornerRadius(radius: 10, width: 0)
        container.layer.cornerRadius = 10
        container.easy.layout(Edges(20))
        container.addSubview(textFieldsStackView)
        textFieldsStackView.easy.layout(Edges())
        textFieldsStackView.setProperties(axis: .vertical, alignment: .fill, spacing: 15, distribution: .fill)
        textFieldsStackView.setSpacing(top: 15, left: 15, right: 15, bottom: 15)
        let downIcon = UIImageView()
        downIcon.image = #imageLiteral(resourceName: "Line")
        downIcon.easy.layout(Height(8),Width(15))
        
        city.textColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        city.easy.layout(Height(46))
        city.cornerRadius(radius: 10, width: 1,color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        city.setLeftPaddingPoints(20)
        city.addSubview(downIcon)
        //        city.isEnabled = false
        city.addTapGestureRecognizer {
            self.cititesList()
        }
        downIcon.easy.layout(CenterY(),Right(20))
        
        let downIcon2 = UIImageView(image: #imageLiteral(resourceName: "Line"))
        
        category.textColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        category.easy.layout(Height(46))
        category.cornerRadius(radius: 10, width: 1,color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        category.setLeftPaddingPoints(20)
        category.addSubview(downIcon2)
        category.addTapGestureRecognizer {
            self.categoriesList()
        }
        downIcon2.easy.layout(CenterY(),Right(20),Height(8),Width(15))
        
        volCount.textColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        volCount.keyboardType = .numberPad
        volCount.easy.layout(Height(46))
        volCount.cornerRadius(radius: 10, width: 1,color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        volCount.setLeftPaddingPoints(20)
        
        city.placeholder = "Город"
        category.placeholder = "Категория"
        volCount.placeholder = "Количество волонтеров"
        
        textFieldsStackView.addArrangedSubview(city)
        textFieldsStackView.addArrangedSubview(category)
        textFieldsStackView.addArrangedSubview(volCount)
        
        stackView.addArrangedSubview(c)
        
    }
    
    func lastInfo(){
        lastStackview.setProperties(axis: .vertical, alignment: .fill, spacing: 15, distribution: .fill)
        titleLabel.setProperties(text: "Заголовок", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), textAlignment: .left, numberLines: 1)
        lastStackview.addArrangedSubview(titleLabel)
        lastStackview.setSpacing(top: 0, left: 20, right: 20, bottom: 0)
        
        titleTextField.textColor = #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1)
        titleTextField.easy.layout(Height(46))
        titleTextField.cornerRadius(radius: 10, width: 1,color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        titleTextField.setLeftPaddingPoints(20)
        
        descLabel.setProperties(text: "Описание", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), textAlignment: .left, numberLines: 1)
        descTextView.cornerRadius(radius: 10, width: 1,color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        descTextView.easy.layout(Height(140))
        descTextView.font = .systemFont(ofSize: 14)
        
        lastStackview.addArrangedSubview(titleTextField)
        lastStackview.addArrangedSubview(descLabel)
        lastStackview.addArrangedSubview(descTextView)
        stackView.addArrangedSubview(lastStackview)
    }
    func createButtonSetting(){
        createButton.easy.layout(Height(52))
        createButton.cornerRadius(radius: 10, width: 0)
        createButton.setTitle("Создать заявку", for: .normal)
        createButton.addTarget(self, action: #selector(createAction(_:)), for: .touchUpInside)
        self.createButton.isEnabled = false
        self.createButton.backgroundColor =  #colorLiteral(red: 0.5960784314, green: 0.737254902, blue: 0.9843137255, alpha: 1)
        lastStackview.addArrangedSubview(createButton)
    }
    
    func chechData(){
        if self.selectedCity != nil &&
            selectedCategory != nil &&
            volCount.text != "" &&
            titleTextField.text != "" &&
            descTextView.text != "" {
            self.createButton.isEnabled = true
            self.createButton.backgroundColor =   #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        } else {
            self.createButton.isEnabled = false
            self.createButton.backgroundColor =  #colorLiteral(red: 0.5960784314, green: 0.737254902, blue: 0.9843137255, alpha: 1)
        }
        
    }
    
    // MARK: - Actions
    @objc func createAction(_ sender: UIButton) {
        let param = ["city_id" : selectedCity?.id ?? 0,
                     "category_id": selectedCategory?.id ?? 0,
                     "title" : titleTextField.text!,
                     "description" : descTextView.text!,
                     "volunteer_number" : volCount.text!] as [String : Any]
        self.startLoad()
        Requests.shared().createApplicationReqs(params: param as [String : AnyObject]) { (result) in
            self.stopLoad()
            if result?.success ?? false {
                self.successView()
            } else {
                self.showAlert(title: "Внимание", message: "Ошибка", popToRoot: false)
            }
            
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        chechData()
    }
    func textViewDidChange(_ textView: UITextView) {
        self.chechData()
    }
    func clearAllData(){
        selectedCategory = nil
        selectedCity = nil
        city.text = ""
        category.text = ""
        volCount.text = ""
        titleTextField.text = ""
        descTextView.text = ""
        chechData()
    }
    
    //MARK: - Removes
    func categoriesList(){
        let backView = UIView()
        backView.frame = UIScreen.main.bounds
        backView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        let closeButton = UIImageView(image: #imageLiteral(resourceName: "close"))
        closeButton.addTapGestureRecognizer {
            backView.removeFromSuperview()
        }
        let cont = UIView()
        let citiesStack = UIStackView()
        citiesStack.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        cont.addSubview(citiesStack)
        citiesStack.easy.layout(Top(20),Left(0),Right(0),Bottom(10))
        cont.addSubview(closeButton)
        closeButton.easy.layout(Height(15),Width(15),Right(22),Top(25))
        cont.cornerRadius(radius: 20, width: 0)
        cont.backgroundColor = .white
        let cityLabel = UILabel()
        cityLabel.setProperties(text: "Выберите категорию", textColor: .black, font: .systemFont(ofSize: 16, weight: .medium), textAlignment: .center, numberLines: 1)
        citiesStack.addArrangedSubview(cityLabel)
        Requests.shared().getCategories { (result) in
            
            for i in 0..<(result.categories?.data?.count ?? 0) {
                if let c = result.categories?.data?[i] {
                    let s = UIStackView()
                    s.setProperties(axis: .horizontal, alignment: .fill, spacing: 20, distribution: .fill)
                    s.setSpacing(top: 10, left: 20, right: 20, bottom: 10)
                    s.addTapGestureRecognizer {
                        self.selectedCategory = c
                        self.category.text = c.name ?? ""
                        backView.removeFromSuperview()
                    }
                    let icon = UIImageView(image: #imageLiteral(resourceName: "right"))
                    icon.easy.layout(Width(6),Height(10))
                    let n = UILabel()
                    n.setProperties(text: c.name ?? "", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
                    s.addArrangedSubview(n)
                    s.addArrangedSubview(icon)
                    let l = UIView()
                    l.easy.layout(Height(1))
                    l.backgroundColor = .lightGray
                    citiesStack.addArrangedSubview(l)
                    citiesStack.addArrangedSubview(s)
                }
            }
        }
        backView.addSubview(cont)
        backView.addTapGestureRecognizer {
            backView.removeFromSuperview()
        }
        cont.easy.layout(CenterY(),Left(28),Right(28))
        self.view.addSubview(backView)
    }
    func cititesList(){
        let backView = UIView()
        backView.frame = UIScreen.main.bounds
        backView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        let closeButton = UIImageView(image: #imageLiteral(resourceName: "close"))
        closeButton.addTapGestureRecognizer {
            backView.removeFromSuperview()
        }
        let cont = UIView()
        let citiesStack = UIStackView()
        citiesStack.setProperties(axis: .vertical, alignment: .fill, spacing: 10, distribution: .fill)
        cont.addSubview(citiesStack)
        citiesStack.easy.layout(Top(20),Left(0),Right(0),Bottom(10))
        cont.addSubview(closeButton)
        closeButton.easy.layout(Height(15),Width(15),Right(22),Top(25))
        cont.cornerRadius(radius: 20, width: 0)
        cont.backgroundColor = .white
        let cityLabel = UILabel()
        cityLabel.setProperties(text: "Выберите город", textColor: .black, font: .systemFont(ofSize: 16, weight: .medium), textAlignment: .center, numberLines: 1)
        citiesStack.addArrangedSubview(cityLabel)
        Requests.shared().getCities { (result) in
            
            for i in 0..<(result?.cities?.count ?? 0) {
                if let c = result?.cities?[i] {
                    let s = UIStackView()
                    s.setProperties(axis: .horizontal, alignment: .fill, spacing: 20, distribution: .fill)
                    s.setSpacing(top: 10, left: 20, right: 20, bottom: 10)
                    s.addTapGestureRecognizer {
                        self.selectedCity = c
                        self.city.text = c.name ?? ""
                        backView.removeFromSuperview()
                    }
                    let icon = UIImageView(image: #imageLiteral(resourceName: "right"))
                    icon.easy.layout(Width(6),Height(10))
                    let n = UILabel()
                    n.setProperties(text: c.name ?? "", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
                    s.addArrangedSubview(n)
                    s.addArrangedSubview(icon)
                    let l = UIView()
                    l.easy.layout(Height(1))
                    l.backgroundColor = .lightGray
                    citiesStack.addArrangedSubview(l)
                    citiesStack.addArrangedSubview(s)
                }
            }
        }
        backView.addSubview(cont)
        backView.addTapGestureRecognizer {
            backView.removeFromSuperview()
        }
        cont.easy.layout(CenterY(),Left(28),Right(28))
        self.view.addSubview(backView)
    }
    func successView(){
        let c = UIView()
        self.view.addSubview(c)
        c.backgroundColor = .white
        c.easy.layout(Edges())
        let s = UIStackView()
        c.addSubview(s)
        s.easy.layout(Edges())
        s.setProperties(axis: .vertical, alignment: .center, spacing: 40, distribution: .fill)
        s.setSpacing(top: 85, left: 50, right: 50, bottom: 0)
        let icon = UIImageView(image: #imageLiteral(resourceName: "Subtract"))
        icon.easy.layout(Width(150),Height(150))
        s.addArrangedSubview(icon)
        let t = UILabel()
        t.setProperties(text: "Ваша заявка успешно создана", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 24, weight: .semibold), textAlignment: .center, numberLines: 5)
        s.addArrangedSubview(t)
        let close = UILabel()
        close.setProperties(text: "Создать еще заявку", textColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), font: .systemFont(ofSize: 16, weight: .bold), textAlignment: .center, numberLines: 1)
        close.easy.layout(Height(52),Width(220))
        close.cornerRadius(radius: 10, width: 1,color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
        s.addArrangedSubview(close)
        close.addTapGestureRecognizer {
            self.clearAllData()
            c.removeFromSuperview()
        }
        s.addArrangedSubview(UIView())
    }
    // MARK: - Navigation
    
    // MARK: - Navigation
    
    
    
}
