//
//  Group.swift
//  Partners
//
//  Created by Andrew Nielson on 8/15/24.
//

import Foundation

struct Group: Identifiable {
    var id = UUID()
    var group: [User]
}
