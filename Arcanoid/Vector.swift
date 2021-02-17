//
//  Vector.swift
//  Arcanoid
//
//  Created by Егор Никитин on 09.02.2021.
//

import UIKit

struct Vector {
    var a: CGPoint
    var b: CGPoint
    var dx: CGFloat {
        return b.x - a.x
    }
    var dy: CGFloat {
        return b.y - a.y
    }
}
