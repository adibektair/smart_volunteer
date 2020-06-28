//
//  FilerVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 6/25/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy


class FilterVC: ScrollStackController,CityPickerProtocol {
    
    
    
    let cityTitle = UILabel()
    //    let citiesCollectionView = UICollectionView()
    let typeLabel = UILabel()
    let typeStackView = UIStackView()
    let categoryLabel = UILabel()
    let categoryStackView = UIStackView()
    var categoriesObj : Categories?
    var citiesList : [City] = []
    var categoryList : [Data] = []
    var type : Type?
    var types : Types?
    var callback: ((_ app : Applications?) -> Void)? = nil
    var app : Applications?
    lazy var citiesCollectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = LeftAlignedFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //If you set it false, you have to add constraints.
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(UINib(nibName: "CityCVC", bundle: nil), forCellWithReuseIdentifier: "CityCVC")
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.isScrollEnabled = true
        
        return cv
    }()
    
    var picker = ChooseCityVC()
    var cities = ["almaty","Astana","Shymkent", "Aktau","Atyrau"]
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        life()
        setUI()
    }
    
    override func viewDidLayoutSubviews() {
        self.citiesCollectionView.easy.layout(Height(self.citiesCollectionView.collectionViewLayout.collectionViewContentSize.height))
    }
    // MARK: - Functinos
    func life(){
        citiesCollectionView.delegate = self
        citiesCollectionView.dataSource = self
        setPicker()
        setBackButton()
        navigationItem.title = "Фильтр"
    }
    
    func setUI(){
        stackView.removeAllArrangedSubviews()
        stackView.setSpacing(top: 20, left: 20, right: 20, bottom: 20)
        citiesCollectionView.easy.layout(Height(36))
        cityTitle.setProperties(text: "Выберите город", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), textAlignment: .left, numberLines: 1)
        typeLabel.setProperties(text: "Выберите тип заявки", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold))
        stackView.addArrangedSubview(cityTitle)
        stackView.addArrangedSubview(citiesCollectionView)
        stackView.addArrangedSubview(typeLabel)
        typeApplication()
        categories()
        bottomButtons()
    }
    
    func typeApplication(){
        typeStackView.setProperties(axis: .horizontal, alignment: .leading, spacing: 15, distribution: .fill)
        if types == nil {
            Requests.shared().getTypes { (result) in
                self.types = result
                self.drawTypes(result: result)
            }
        } else {
            drawTypes(result: types!)
        }
        
        stackView.addArrangedSubview(typeStackView)
    }
    func drawTypes(result: Types? = nil){
        self.typeStackView.removeAllArrangedSubviews()
        for i in 0..<(result?.types?.count ?? 0) {
            guard let data = result?.types?[i] else { return }
            let l = UILabel()
            l.addTapGestureRecognizer {
                self.type = data
                self.drawTypes(result: result!)
                self.getData()
            }
            let w = (data.name ?? "").widthWithConstrainedHeight(14, font: .systemFont(ofSize: 14, weight: .medium)) + 40
            l.easy.layout(Height(40),Width(w))
            l.setProperties(text: data.name ?? "", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), textAlignment: .center, numberLines: 1)
            if result?.types?[i].id == self.type?.id {
                self.typeStackView.addArrangedSubview(l)
                l.textColor = .white
                l.cornerRadius(radius: 20, width: 0)
                l.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
            } else {
                let cont = UIView()
                cont.dropShadow()
                cont.backgroundColor = .white
                cont.layer.cornerRadius = 20
                cont.clipsToBounds = false
                cont.addSubview(l)
                l.easy.layout(Edges())
                self.typeStackView.addArrangedSubview(cont)
            }
        }
        self.typeStackView.addArrangedSubview(UIView())
    }
    
    func setPicker(){
        picker.pickerDelegate = self
        Requests.shared().getCities { (response) in
            self.picker.cities = response?.cities ?? []
            self.reload()
        }
    }
    
    func categories(){
        categoryLabel.setProperties(text: "Выберите категории", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), textAlignment: .left, numberLines: 1)
        stackView.addArrangedSubview(categoryLabel)
        self.categoryStackView.setProperties(axis: .vertical, alignment: .fill, spacing: 18, distribution: .fill)
        if categoriesObj == nil {
            Requests.shared().getCategories { (result) in
                self.categoriesObj = result
                self.categoryDraw()
            }
        } else {
            categoryDraw()
        }
        stackView.addArrangedSubview(categoryStackView)
    }
    
    func categoryDraw(){
        categoryStackView.removeAllArrangedSubviews()
        for i in 0..<(self.categoriesObj?.categories?.data?.count ?? 0) {
            if let d = self.categoriesObj?.categories?.data?[i] {
                let catStack = UIStackView()
                catStack.setProperties(axis: .horizontal, alignment: .fill, spacing: 10, distribution: .fill)
                let checkBox = UIImageView()
                checkBox.image = self.categoryList.contains(where: ({$0.id == d.id })) ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unChecked")
                checkBox.easy.layout(Height(18),Width(18))
                let titleLabel = UILabel()
                titleLabel.setProperties(text: d.name ?? "", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14), textAlignment: .left, numberLines: 1)
                catStack.addArrangedSubview(checkBox)
                catStack.addArrangedSubview(titleLabel)
                catStack.addTapGestureRecognizer {
                    if self.categoryList.contains(where: ({$0.id == d.id })) {
                        self.categoryList.removeAll(where: ({ $0.id == d.id}))
                        checkBox.image = #imageLiteral(resourceName: "unChecked")
                    } else {
                        self.categoryList.append(d)
                        checkBox.image = #imageLiteral(resourceName: "checked")
                    }
                    self.getData()
                }
                self.categoryStackView.addArrangedSubview(catStack)
            }
        }
    }
    
    let filter = UILabel()
    func bottomButtons(){
        let twoButtonsStack = UIStackView()
        twoButtonsStack.setProperties(axis: .horizontal, alignment: .fill, spacing: 10, distribution: .fillEqually)
        let clearButton = UILabel()
        
        clearButton.cornerRadius(radius: 10, width: 1,color: #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1))
        filter.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        filter.cornerRadius(radius: 10, width: 0)
        clearButton.easy.layout(Height(54))
        filter.easy.layout(Height(54))
        
        clearButton.setProperties(text: "Сбросить все", textColor:  #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1), font: .systemFont(ofSize: 16, weight: .medium), textAlignment: .center, numberLines: 1)
        filter.setProperties(text: "0 заявок", textColor:  .white, font: .systemFont(ofSize: 16, weight: .bold), textAlignment: .center, numberLines: 1)
        twoButtonsStack.addArrangedSubview(clearButton)
        twoButtonsStack.addArrangedSubview(filter)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(twoButtonsStack)
        clearButton.addTapGestureRecognizer {
            self.type = nil
            self.citiesList = []
            self.categoryList = []
            self.drawTypes(result: self.types)
            self.categoryDraw()
            self.reload()
        }
        filter.addTapGestureRecognizer {
            if self.callback != nil && self.app != nil {
                self.callback!(self.app!)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func getData() {
        var url = Constants.shared().baseUrl + "applications/filter?"
        if citiesList.count > 0 {
            let a = "\(citiesList.map(({ $0.id! })))"
            let set = CharacterSet(charactersIn: "123456789,")
            let b = a.components(separatedBy: set.inverted).joined()
            url = url + "filter[city_id]=\(b)"
        }
        if let id = type?.id {
            if self.cities.count > 0 {
                url += "&"
            }
            url += "filter[application_type_id]=\(id)"
        }
        if categoryList.count > 0 {
            let a = "\(categoryList.map(({ $0.id! })))"
            let set = CharacterSet(charactersIn: "123456789,")
            let b = a.components(separatedBy: set.inverted).joined()
            url += "&filter[category_id]=\(b)"
        }
        
        Requests.shared().getApplicationsFiltered(url: url) { (result) in
            self.app = result
            self.filter.text = "\(result.applications?.total ?? 0) заявок"
        }
    }
    
    func pickCity(cityName: String, id: Int) {
        let c = City(JSON: ["name" : cityName,
                            "id": id])
        if c != nil && !citiesList.contains(where: ({ $0.id == id })) {
            self.citiesList.append(c!)
            self.reload()
        }
        print("\(cityName) \(id)")
    }
    
    // MARK: - Navigation
    static func open(vc: UIViewController,callback:  ((_ app:Applications?) -> Void)? = nil) {
        let viewController = FilterVC()
        viewController.callback = callback
        if let nav = vc.navigationController {
            nav.pushViewController(viewController, animated: true)
        }
    }
    // MARK: - Navigation
}


extension FilterVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func reload(){
        citiesCollectionView.reloadData()
        getData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.1) {
                self.citiesCollectionView.easy.layout(Height(self.citiesCollectionView.collectionViewLayout.collectionViewContentSize.height))
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.citiesList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCVC", for: indexPath) as! CityCVC
        if indexPath.row == citiesList.count {
            cell.addCity()
        } else {
            cell.city()
            cell.name.text = citiesList[indexPath.row].name ?? "asdf"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < citiesList.count {
            citiesList.remove(at: indexPath.row)
            self.reload()
        } else {
            self.present(self.picker, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var a = "Добавить город"
        let c = citiesList.count
        if c > 0, indexPath.row < c {
            a = citiesList[indexPath.row].name!
        }
        let w = a.widthWithConstrainedHeight(36, font: .systemFont(ofSize: 14, weight: .medium)) + 40
        return CGSize(width: w, height: 36)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
class LeftAlignedFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let originalAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        var leftMargin: CGFloat = 0.0
        var lastY: Int = 0
        return originalAttributes.map {
            let changedAttribute = $0
            // Check if start of a new row.
            // Center Y should be equal for all items on the same row
            if Int(changedAttribute.center.y.rounded()) != lastY {
                leftMargin = sectionInset.left
            }
            changedAttribute.frame.origin.x = leftMargin
            lastY = Int(changedAttribute.center.y.rounded())
            leftMargin += changedAttribute.frame.width + minimumInteritemSpacing
            return changedAttribute
        }
    }
}
