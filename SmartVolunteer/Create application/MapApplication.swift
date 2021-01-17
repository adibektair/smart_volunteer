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
import CoreLocation


class MapApplication: UIViewController,MKMapViewDelegate {

    // MARK: - Navigation
    let addressText = UITextField()
    let select = GeneralButton()
    var address = AddressInfo(lng: "", lat: "", address: "")
    fileprivate var annotation: MKAnnotation!
    let mapView = MKMapView()
    lazy var locationManager: CLLocationManager = {
            var manager = CLLocationManager()
            manager.distanceFilter = 10
            manager.desiredAccuracy = kCLLocationAccuracyBest
            return manager
        }()
    var send: ((AddressInfo) -> Void)?

    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        mapSettings()
        views()
    }
    
    // MARK: - Navigation
    func views(){
        self.view.addSubview(mapView)
        mapView.easy.layout(Edges())
        mapView.mapType = .hybrid
        self.mapView.addSubview(addressText)
        addressText.placeholder = "Введите адрес"
        addressText.easy.layout(Top(24),Left(16),Right(16),Height(48))
        addressText.layer.cornerRadius = 10
        addressText.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        addressText.backgroundColor = .white
        self.view.addSubview(select)
        select.title = "Подтвердить"
        select.isAccessible = true
        select.easy.layout(Bottom(120),Left(16),Right(16))
        select.addTapGestureRecognizer {
            self.sendData()
        }
    }
    @objc func textFieldChange(_ textField: UITextField){
        self.address.address = textField.text!
    }
    func sendData(){
        if self.send != nil {
            send!(self.address)
            self.navigationController?.popViewController(animated: true)
        }
    }
    func mapSettings(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(MapApplication.mapLongPress(_:))) // colon needs to pass through info
            longPress.minimumPressDuration = 1.5 // in seconds
            //add gesture recognition
            
        let tap = UITapGestureRecognizer(target: self, action: #selector(mapLongPress(_:)))
        mapView.addGestureRecognizer(tap)
        let buttonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = buttonItem
        mapView.showsUserLocation = true
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
    }
    // func called when gesture recognizer detects a long press

    @objc func mapLongPress(_ recognizer: UIGestureRecognizer) {

        print("A long press has been detected.")

        let touchedAt = recognizer.location(in: self.mapView) // adds the location on the view it was pressed
        let touchedAtCoordinate : CLLocationCoordinate2D = mapView.convert(touchedAt, toCoordinateFrom: self.mapView) // will get coordinates
        let l = CLLocation(latitude: touchedAtCoordinate.latitude, longitude: touchedAtCoordinate.longitude)
        
        l.lookUpLocationName { (name) in
            self.updateLocationOnMap(to: l, with: name)
            self.addressText.text = name
            self.address.set(lng: "\(touchedAtCoordinate.longitude)", lat: "\(touchedAtCoordinate.latitude)", address: name!)
        }
        
        let newPin = MKPointAnnotation()
        
        newPin.coordinate = touchedAtCoordinate
        mapView.addAnnotation(newPin)


    }
   

    
    static func open(vc: UIViewController,completionHandler: @escaping (AddressInfo) -> Void){
        let vcc = MapApplication()
        vcc.send = completionHandler
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
    func set(lng:String, lat:String, address: String) {
        self.lng = lng
        self.lat = lat
        self.address = address
    }
}
extension MapApplication: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
//        let location = locations.last! as CLLocation

        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))




        //set region on the map
        self.mapView.setRegion(region, animated: true)


        if self.address.address == "" {
            location.lookUpLocationName { (name) in
                self.updateLocationOnMap(to: location, with: name)
                self.addressText.text = name
                self.address.set(lng: "\(location.coordinate.longitude)", lat: "\(location.coordinate.latitude)", address: name!)
            }
        }
        
    }
    
    func updatePlaceMark(to address: String) {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemark = placemarks?.first,
                let location = placemark.location
            else { return }
            
            self.updateLocationOnMap(to: location, with: placemark.name)
        }
    }
    
    
    
    
    func updateLocationOnMap(to location: CLLocation, with title: String?) {
        
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotation(point)
        
        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        self.mapView.setRegion(viewRegion, animated: true)
        
    }
    
}

extension CLLocation {
    
    func lookUpLocationName(_ handler: @escaping (String?) -> Void) {
            
            lookUpPlaceMark { (placemark) in
                handler(placemark?.name)
            }
        }
    func lookUpPlaceMark(_ handler: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
            
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(self) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                handler(firstLocation)
            }
            else {
                // An error occurred during geocoding.
                handler(nil)
            }
        }
    }
}

