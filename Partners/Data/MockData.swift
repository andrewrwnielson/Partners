//
//  MockData.swift
//  Partners
//
//  Created by Andrew Nielson on 8/15/24.
//

import Foundation
import MapKit

struct MockData {
    static let users: [User] = [
        User(userName: "Ivan Rakitic", location: CLLocationCoordinate2D(latitude: 41.3851, longitude: 2.1734)),
        User(userName: "Andres Iniesta", location: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917)),
        User(userName: "Sergio Ramos", location: CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7038)),
        User(userName: "Antoine Griezmann", location: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522)),
        User(userName: "Zlatan Ibrahimovic", location: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)),
        User(userName: "Fernando Torres", location: CLLocationCoordinate2D(latitude: 53.4084, longitude: -2.9916))
    ]
    
    static var posts: [Post] {
        [
            Post(user: users[0],
                 postImage: "post_1",
                 caption: "SERIAL, n. A literary work, usually a story that is not true, creeping through several issues of a newspaper or magazine.",
                 likes: "Leo Messi and others liked",
                 location: "Barcelona, Spain",
                 coordinates: CLLocationCoordinate2D(latitude: 41.3851, longitude: 2.1734)),
            Post(user: users[1],
                 postImage: "post_2",
                 caption: "I'm doing philosophy like an old woman, first I'm looking for my pencil, then I'm looking for my glasses, then I'm looking for my pencil again",
                 likes: "Wayne Rooney and others liked",
                 location: "Tokyo, Japan",
                 coordinates: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917)),
            Post(user: users[2],
                 postImage: "post_3",
                 caption: "The way in which men cling to old institutions after the life has departed out of them, and out of themselves, reminds me of those monkeys which cling by their tails ... beyond the hunter's reach long after they are dead.",
                 likes: "Leo Messi and others liked",
                 location: "Madrid, Spain",
                 coordinates: CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7038)),
            Post(user: users[3],
                 postImage: "post_4",
                 caption: "I invite you to sit down in front of your television set when your station goes on the air ... and keep your eyes glued to that set until the station signs off. I can assure you that you will observe a great wasteland.",
                 likes: "David Beckham and others liked",
                 location: "Paris, France",
                 coordinates: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522)),
            Post(user: users[4],
                 postImage: "post_5",
                 caption: "O speculators about perpetual motion, how many vain chimeras have you created in the like quest? Go and take your place with the seekers after gold.",
                 likes: "Sherlock Holmes and others liked",
                 location: "Los Angeles, USA",
                 coordinates: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)),
            Post(user: users[5],
                 postImage: "post_6",
                 caption: "After all, for mankind as a whole there are no exports. We did not start developing by obtaining foreign exchange from Mars or the moon. Mankind is a closed society.",
                 likes: "John Watson and others liked",
                 location: "Liverpool, England",
                 coordinates: CLLocationCoordinate2D(latitude: 53.4084, longitude: -2.9916))
        ]
    }
}
