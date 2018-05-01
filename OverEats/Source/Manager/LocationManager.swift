//
//  LocationManager.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 5. 1..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct LocationManager {
    private init() {}
    
    static var setLocation: LocationData? {
        get { return nil }
        set {
            name = newValue?.name
            vicinity = newValue?.vicinity
            addressComponents = newValue?.addressComponents
            formattedAddress = newValue?.formattedAddress
            geometry = newValue?.geometry
        }
    }
    
    static var name : String?
    static var vicinity : String?
    static var addressComponents: [LongName]?
    static var formattedAddress: String?
    static var geometry: Geometry?
}
