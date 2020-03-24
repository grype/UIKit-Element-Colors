//
//  File.swift
//  UIKit-Element-Colors
//
//  Created by Pavel Skaldin on 3/24/20.
//  Copyright © 2020 Grype. All rights reserved.
//

import UIKit

class ColorsTableViewCell: UITableViewCell {
    
    private(set) var colorIndicator = UIView(frame: .zero)
    
    var color: UIColor? {
        didSet {
            colorIndicator.backgroundColor = color
            setNeedsLayout()
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initColorIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initColorIndicator() {
        addSubview(colorIndicator)
    }
    
    // MARK:- UIView
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorIndicator.frame = CGRect(x: bounds.maxX - bounds.size.height, y: 0, width: bounds.size.height, height: bounds.size.height)
    }
}
