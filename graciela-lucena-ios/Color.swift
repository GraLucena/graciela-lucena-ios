//
//  Color.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit
import HexColors

enum Color: String {
    
    case blue = "295AA6"
    
    var color : UIColor{
        return UIColor.hx_colorWithHexRGBAString(self.rawValue)!
    }
}
