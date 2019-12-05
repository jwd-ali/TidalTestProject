//
//  ThemeManager.swift
//  Tidal
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import Foundation
import UIKit
enum FontSize: CGFloat {
    case extraExtraLarge = 24
    case extraLarge = 20
    case large = 15
    case medium = 14
    case small = 11
}
enum Theme: Int {
    case theme1
    
    var mainColor: UIColor {
        switch self {
        case .theme1:
            return UIColor.universalColor1
        }
    }
    var barStyle: UIBarStyle {
        switch self {
        case .theme1:
            return .default
        }
    }
}
struct ThemeManager {
    static func currentTheme() -> Theme {
        return Theme.init(rawValue: 0)!
    }
    static func applyTheme(theme: Theme) {
        
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().barTintColor = theme.mainColor
        UINavigationBar.appearance().tintColor = .universalColor3
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.universalColor3,NSAttributedString.Key.font: UIFont.systemFont(ofSize: FontSize.extraLarge.rawValue, weight: .bold)]
        UINavigationBar.appearance().isTranslucent = true
    }
    static func changeNavigationBarTint(color: UIColor){
           UINavigationBar.appearance().tintColor = color
       }
       static func resetNavigationBarTint(){
           UINavigationBar.appearance().tintColor = UIColor.systemBackground
       }
}
