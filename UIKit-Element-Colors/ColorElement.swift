//
//  File.swift
//  Colors
//
//  Created by Pavel Skaldin on 3/23/20.
//  Copyright © 2020 Grype. All rights reserved.
//

import UIKit

enum ColorElement {
    case label(String, UIColor)
    case fill(String, UIColor)
    case background(String, UIColor)
    case separator(String, UIColor)
    case text(String, UIColor)
    
    var displayName: String {
        switch self {
        case .label(_, _):
            return "𝑻  labels"
        case .text(_, _):
            return "𝑻  text"
        case .fill(_, _):
            return "▧  fills"
        case .background(_, _):
            return "▧  backgrounds"
        case .separator(_, _):
            return "▧  separators"
        }
    }
    
    var color: UIColor {
        switch self {
        case .label(_, let aColor):
            fallthrough
        case .text(_, let aColor):
            fallthrough
        case .fill(_, let aColor):
            fallthrough
        case .background(_, let aColor):
            fallthrough
        case .separator(_, let aColor):
            return aColor
        }
    }
}
