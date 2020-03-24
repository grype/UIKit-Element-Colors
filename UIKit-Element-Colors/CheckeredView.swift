//
//  CheckeredView.swift
//  Colors
//
//  Created by Pavel Skaldin on 3/23/20.
//  Copyright © 2020 Grype. All rights reserved.
//

import UIKit

class CheckeredView : UITableView {
    
    var diameter = CGFloat(24) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    let delta = CGFloat(2)
    
    // MARK:- UIView
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            super.draw(rect)
            return
        }
        
        context.setFillColor(UIColor.systemBackground.cgColor)
        context.fill(bounds)
        
        context.setFillColor(UIColor.label.withAlphaComponent(0.2).cgColor)
        for x in stride(from: Double(bounds.minX), to: Double(bounds.maxX), by: Double(diameter + delta)) {
            for y in stride(from: Double(bounds.minY), to: Double(bounds.maxY), by: Double(diameter + delta)) {
                let i = CGFloat(x) / diameter
                let d = diameter - (i * delta)
                guard d > 2 else { continue }
                let adjustedY = CGFloat(y) + CGFloat(diameter / 2) - CGFloat(d / delta)
                context.fillEllipse(in: CGRect(x: CGFloat(x), y: adjustedY, width: d, height: d))
            }
        }
    }
}
