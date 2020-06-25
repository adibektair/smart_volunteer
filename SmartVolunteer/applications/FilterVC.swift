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
    lazy var citiesCollectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
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
    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        life()
        setUI()
    }
    
    // MARK: - Navigation
    func life(){
        citiesCollectionView.delegate = self
        citiesCollectionView.dataSource = self
        setPicker()
    }
    
    func setUI(){
        stackView.setSpacing(top: 20, left: 20, right: 20, bottom: 20)
        citiesCollectionView.easy.layout(Height(36))
        cityTitle.setProperties(text: "Выберите город", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold), textAlignment: .left, numberLines: 1)
        cityTitle.addTapGestureRecognizer {
            self.present(self.picker, animated: true, completion: nil)
        }
//        Выберите тип заявки
        typeLabel.setProperties(text: "Выберите тип заявки", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14, weight: .bold))

        stackView.addArrangedSubview(cityTitle)
        stackView.addArrangedSubview(citiesCollectionView)
        stackView.addArrangedSubview(typeLabel)
        typeApplication()
    }
    
    func typeApplication(){
        typeStackView.setProperties(axis: .horizontal, alignment: .leading, spacing: 15, distribution: .fill)
        let left = UILabel()
        let right = UILabel()
        left.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.4784313725, blue: 0.9647058824, alpha: 1)
        right.backgroundColor = .white
        right.dropShadow()
        left.cornerRadius(radius: 20, width: 0)
        right.cornerRadius(radius: 20, width: 0)
        left.setProperties(text: "Фондовый", textColor: .white, font: .systemFont(ofSize: 14, weight: .medium), textAlignment: .center, numberLines: 1)
        right.setProperties(text: "Частный", textColor: #colorLiteral(red: 0.2431372549, green: 0.2862745098, blue: 0.3450980392, alpha: 1), font: .systemFont(ofSize: 14, weight: .medium), textAlignment: .center, numberLines: 1)
        left.easy.layout(Height(40), Width(110))
        right.easy.layout(Height(40), Width(110))
        typeStackView.addArrangedSubview(left)
        typeStackView.addArrangedSubview(right)
        let c = UIView()
        c.addSubview(typeStackView)
        right.dropShadow()
        c.backgroundColor = .white
        typeStackView.easy.layout(Edges())
        stackView.addArrangedSubview(c)
    }
    func setPicker(){
        picker.pickerDelegate = self
        Requests.shared().getCities { (response) in
            self.picker.cities = response?.cities ?? []
            self.citiesCollectionView.reloadData()
            self.citiesCollectionView.easy.layout(Height(self.citiesCollectionView.collectionViewLayout.collectionViewContentSize.height))
        }
//        picker.modalPresentationStyle = .overCurrentContext
    }
    func pickCity(cityName: String, id: Int) {
        print("\(cityName) \(id)")
    }
    // MARK: - Navigation
    static func open(vc: UIViewController){
          let viewController = FilterVC()
          if let nav = vc.navigationController {
              nav.pushViewController(viewController, animated: true)
          }
      }
    // MARK: - Navigation
}


extension FilterVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cities.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCVC", for: indexPath) as! CityCVC
        if indexPath.row == cities.count {
            cell.addCity()
        } else {
            cell.city()
            cell.name.text = cities[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var a = "Добавить город"
        let c = cities.count
        if c > 0, indexPath.row < c {
            a = cities[indexPath.row]
        }
        let w = a.widthWithConstrainedHeight(36, font: .systemFont(ofSize: 14, weight: .medium)) + 40
        return CGSize(width: w, height: 36)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
