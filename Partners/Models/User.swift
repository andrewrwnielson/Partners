//
//  User.swift
//  Partners
//
//  Created by Andrew Nielson on 8/15/24.
//

import Foundation
import MapKit

struct User: Identifiable {
    var id = UUID()
    let userName: String
    var location: CLLocationCoordinate2D
}
