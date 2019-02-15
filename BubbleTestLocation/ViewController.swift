//
//  ViewController.swift
//  BubbleTestLocation
//
//  Created by gotsira on 14/2/19.
//  Copyright © 2019 mond. All rights reserved.
//

import Alamofire
import GoogleMaps
import UIKit

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: GMSMapView!
    
    @IBAction func FindAction(_ sender: Any) {
        
        print("CALLED!")
        Alamofire.request("https://api.foursquare.com/v2/venues/search?client_id=XKLLFQ3LSFZSRFC2DVRCBJNAZNYNY31LEB4YGM2WNRRYYFDV&client_secret=CSHQPZ0CETWDWZAH5MQ1PXEZI5FGILYHZDLYJ32CVWTX2OVU&v=20180323&limit=10&ll=\(locationManager.location?.coordinate.latitude ?? 0.0),\(locationManager.location?.coordinate.longitude ?? 0.0)&quary=bubbletea")
            .responseJSON(completionHandler: {
                res in
                guard let json = res.result.value as? [String: Any] else {
                    return
                }
                
                guard let response = json["response"] as? [String: Any] else {
                    return
                }
                
                guard let venues = response["venues"] as? [[String: Any]] else {
                    return
                }
                
                venues.forEach{ venue in
                    let place = Place(venue: venue)
                    let marker = GMSMarker(position: place.location)
                    print(place.name)
                    marker.map = self.mapView
                    marker.title = place.name
                }
            }
        )
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 13.844815, longitude: 100.5682907))
        
        marker.map = mapView
    }


}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status.rawValue)
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {
            return
        }
        
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
//        mapView.camera = GMSCameraPosition

    }
}
