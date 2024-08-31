//
//  Post.swift
//  Partners
//
//  Created by Andrew Nielson on 8/15/24.
//

import Foundation
import MapKit

struct Post: Identifiable {
    let id = UUID()
    let user: User
    let postImage: String
    let caption: String
    let likes: String
    var hasLiked: Bool = false
    let location: String
    let coordinates: CLLocationCoordinate2D
}
