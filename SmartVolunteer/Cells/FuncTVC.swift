//
//  FuncTVC.swift
//  SmartVolunteer
//
//  Created by Таир Адибек on 6/24/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import SDWebImage

class FuncTVC: UITableViewCell {

    var data : Fond?{
        didSet{
            self.titleLabel.text = self.data?.name ?? ""
            self.descriptionLabel.text = self.data?.descriptionField ?? ""
            if self.data?.volunteer?.id != nil{
                self.actionButton.setTitle("Отписаться", for: .normal)
            }else{
                self.actionButton.setTitle("Подписаться", for: .normal)
                
            }
            self.volunteersNumberLabel.text = "\(self.data?.volunteerNumber ?? 0) волонтеров"
            self.logoImageView.cornerRadius(radius: 28, width: 0)
            if let img = self.data?.imgPath{
                let url = URL(string: img.encodeUrl)
                self.logoImageView.sd_setImage(with: url, completed: nil)
            }else{
                self.logoImageView.image = #imageLiteral(resourceName: "placeholder-image")
            }
            self.logoImageView.contentMode = .scaleToFill

        }
    }
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var volunteersNumberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
