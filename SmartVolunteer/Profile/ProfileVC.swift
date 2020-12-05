//
//  ProfileVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/29/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import SDWebImage

class ProfileVC: ScrollStackController {

    var profile : Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavForTaraz()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.getData()
    }
    
    // ui
    func setViews(){
        self.stackView.setProperties(axis: .vertical, alignment: .fill, spacing: 20, distribution: .fill)
        // image
        let imageView = UIImageView()
        if profile?.avatar != nil{
            imageView.sd_setImage(with: URL(string: self.profile!.avatar!.encodeUrl), completed: nil)
        }else{
            imageView.image = #imageLiteral(resourceName: "photo user")
        }
        let avatarView = UIView()
        avatarView.addSubview(imageView)
        imageView.easy.layout(CenterX(), Height(80), Width(80))
        self.stackView.addArrangedSubview(avatarView)
        
        imageView.cornerRadius(radius: 40, width: 0)
        
        // profile data
        let profileDataView = UIView()
        let dataView = UIView()
        let nameLabel = UILabel()
        let nameDataLabel = UILabel()
        dataView.addSubview(nameLabel)
        dataView.addSubview(nameDataLabel)
        nameLabel.easy.layout(Left(18), Top(15), Height(19))
        nameDataLabel.easy.layout(CenterX(), Top(15))
        nameLabel.text = "ИИН"
        nameDataLabel.text = profile?.iin ?? "-"
        profileDataView.addSubview(dataView)
        dataView.easy.layout(Top(), Bottom(), Left(15), Right(15), Height(60))
        dataView.dropShadow()
        dataView.cornerRadius(radius: 15, width: 0)
        self.stackView.addArrangedSubview(profileDataView)
        profileDataView.backgroundColor = .darkGray
        
        
    }
    // req
    func getData(){
        self.startLoad()
        Requests.shared().getProfile { (response) in
            self.stopLoad()
            if response?.profile != nil{
                self.setViews()
            }
        }
    }
    

}
