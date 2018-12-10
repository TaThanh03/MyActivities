//
//  OneCell.swift
//  MyActivities
//
//  Created by TA Trung Thanh on 09/12/2018.
//  Copyright © 2018 TA Trung Thanh. All rights reserved.
//
import UIKit

class OneCell: NSObject {
    var label = ""
    var detail : Int
    var img : UIImage?
    init(l: String, d: Int) {
        label = l
        detail = d
    }
}
