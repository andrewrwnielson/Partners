//
//  Tip.swift
//  Partners
//
//  Created by Andrew Nielson on 8/16/24.
//

import Foundation
import TipKit

struct ScrollTip: Tip {
    var title: Text {
        Text("Friend's Times")
            .foregroundStyle(Color(hex: 0x002247))
    }
    
    var message: Text? {
        Text("Scroll to see your friend's clocks.")
    }
}
