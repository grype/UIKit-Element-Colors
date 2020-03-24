//
//  ColorComponents.swift
//  Colors
//
//  Created by Pavel Skaldin on 3/23/20.
//  Copyright © 2020 Grype. All rights reserved.
//

import UIKit

struct ColorComponents {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var hue: CGFloat
    var saturation: CGFloat
    var brightness: CGFloat
    var alpha: CGFloat
    
    static var empty: ColorComponents {
        return ColorComponents(red: 0, green: 0, blue: 0, hue: 0, saturation: 0, brightness: 0, alpha: 0)
    }
    
    private func roundNumber(_ aNumber: CGFloat) -> CGFloat {
        return CGFloat ((aNumber * 100).rounded(.down)) / CGFloat(100)
    }
    
    static func from(_ aColor: UIColor) -> Self {
        var components = ColorComponents.empty
        aColor.getRed(&components.red, green: &components.green, blue: &components.blue, alpha: &components.alpha)
        aColor.getHue(&components.hue, saturation: &components.saturation, brightness: &components.brightness, alpha: &components.alpha)
        return components
    }
    
    var contrastingColor: UIColor {
        guard brightness > 0.5 else {
            return UIColor(hue: hue, saturation: saturation, brightness: 1, alpha: 1)
        }
        return UIColor(hue: hue, saturation: saturation, brightness: 0, alpha: 1)
    }
    
    var solidColor: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    var rgbDescription: String {
        return "R:\(roundNumber(red)) G:\(roundNumber(green)) B:\(roundNumber(blue)) A:\(roundNumber(alpha))"
    }
    
    var hsbDescription: String {
        return "H:\(roundNumber(hue)) S:\(roundNumber(saturation)) B:\(roundNumber(brightness)) A:\(roundNumber(alpha))"
    }
}
