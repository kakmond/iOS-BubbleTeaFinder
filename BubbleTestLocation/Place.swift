//
//  Place.swift
//  BubbleTestLocation
//
//  Created by gotsira on 14/2/19.
//  Copyright © 2019 mond. All rights reserved.
//

import GoogleMaps
import Foundation

class Place {
    let name: String
    let location: CLLocationCoordinate2D
    
    init(venue: [String: Any]) {
        self.name = venue["name"] as? String ?? ""
        let rawLocation = venue["location"] as? [String: Any] ?? [:]
        let lat = rawLocation["lat"] as? Double ?? 0.0
        let lng = rawLocation["lng"] as? Double ?? 0.0
        self.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)

    }
}
