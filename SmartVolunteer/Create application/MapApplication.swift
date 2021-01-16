//
//  MapApplication.swift
//  SmartVolunteer
//
//  Created by Sultan on 1/17/21.
//  Copyright © 2021 Таир Адибек. All rights reserved.
//

import UIKit
import EasyPeasy
import MapKit

class MapApplication: MapVC {

    // MARK: - Navigation
    let addressText = UITextField()
    let select = GeneralButton()
    var address = AddressInfo(lng: "", lat: "", address: "")
    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()

        views()
    }
    
    // MARK: - Navigation
    func views(){
        self.view.addSubview(addressText)
        addressText.easy.layout(Top(24),Left(16),Right(16))
        
        self.view.addSubview(select)
        select.title = "Подтвердить"
        select.easy.layout(Bottom(16),Left(16),Right(16))
    }
    
    override func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let coordinate = view.annotation?.coordinate {
            let lat = "\(coordinate.latitude)"
            let lng = "\(coordinate.longitude)"
            let address = self.addressText.text!
            self.address = AddressInfo(lng: lng, lat: lat, address: address)
        }

    }
    static func open(vc: UIViewController){
        let vcc = MapApplication()
        
        if let nav = vc.navigationController {
            nav.pushViewController(vcc, animated: true)
        }
    }

}
class AddressInfo: NSObject {
    var lng = ""
    var lat = ""
    var address = ""
    init(lng:String, lat:String, address: String) {
        super.init()
        self.lng = lng
        self.lat = lat
        self.address = address
    }
}
