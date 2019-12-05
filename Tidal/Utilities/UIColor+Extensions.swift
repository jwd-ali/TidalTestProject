//
//  UIColor+Extensions.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import UIKit
extension UIColor {
    
    static let universalColor1: UIColor = appColor(named: "universalcolor1")!
       
    static let universalColor2: UIColor = appColor(named: "universalcolor2")!
    
    static let universalColor3: UIColor = appColor(named: "universalcolor3")!
    
    static let universalColor4: UIColor = appColor(named: "universalcolor4")!
    
    static let universalColor5: UIColor = appColor(named: "universalcolor5")!
    
    private static func appColor(named: String) -> UIColor?{
           #if TARGET_INTERFACE_BUILDER
           return UIColor.systemGray
           #else
           return UIColor(named: named)
           #endif
       }
}
