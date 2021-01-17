//
//  MapVC.swift
//  SmartVolunteer
//
//  Created by Sultan on 12/31/20.
//  Copyright © 2020 Таир Адибек. All rights reserved.
//

import UIKit
import MapKit
import EasyPeasy

class MapVC: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    let mapView = MKMapView()
    var locationManager: CLLocationManager!
    var data : [Data] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setUI()
        mapSettings()
        // Do any additional setup after loading the view.
    }
    
    func mapSettings(){
//        42.894547, 71.392407
        let buttonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = buttonItem
        mapView.showsUserLocation = true
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        for i in data {
            if let lng = i.lng, let lat = i.lat {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                annotation.title = i.title
                annotation.subtitle = "\(i.id!)"
                
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
         print("calloutAccessoryControlTapped")
      }

      func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        guard let idd = (view as MKAnnotationView).annotation?.subtitle else { return }
        guard let id = Int(idd ?? "") else { return }
        if let d = data.first(where: {$0.id! == id}) {
            ApplicationVC.open(vc: self, data: d)
        }
         print("didSelectAnnotationTapped")
      }
    func setUI(){
        self.view.addSubview(mapView)
        mapView.easy.layout(Edges())
    }
   
    
    static func open(vc:UIViewController, data: [Data] = []) {
        let m = MapVC()
        m.data = data
        if let nav = vc.navigationController {
            nav.pushViewController(m, animated: true)
        }
    }
    

}
