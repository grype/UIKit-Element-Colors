//
//  ColorsTableViewController.swift
//  Colors
//
//  Created by Pavel Skaldin on 3/23/20.
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

class ColorsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var colorElements: [ColorElement]!
    
    private lazy var namedColorElements: [String : [ColorElement]] = {
        var dict = [String: [ColorElement]]()
        colorElements.forEach { (element) in
            guard var values = dict[element.name] else {
                dict[element.name] = [element]
                return
            }
            values.append(element)
            dict[element.name] = values
        }
        return dict
    }()
    
    private lazy var colorElementNames: [String] = {
        return Array(namedColorElements.keys).sorted { $0 < $1 }
    }()
    
    // MARK: - Init

    private func initColors() {
        colorElements = [
            ColorElement.label("label", UIColor.label),
            ColorElement.label("secondaryLabel", UIColor.secondaryLabel),
            ColorElement.label("tertiaryLabel", UIColor.tertiaryLabel),
            ColorElement.label("quaternaryLabel", UIColor.quaternaryLabel),
            ColorElement.fill("systemFill", UIColor.systemFill),
            ColorElement.fill("secondarySystemFill", UIColor.secondarySystemFill),
            ColorElement.fill("tertiarySystemFill", UIColor.tertiarySystemFill),
            ColorElement.fill("quaternarySystemFill", UIColor.quaternarySystemFill),
            ColorElement.text("placeholderText", UIColor.placeholderText),
            ColorElement.background("systemBackground", UIColor.systemBackground),
            ColorElement.background("secondarySystemBackground", UIColor.secondarySystemBackground),
            ColorElement.background("tertiarySystemBackground", UIColor.tertiarySystemBackground),
            ColorElement.background("systemGroupedBackground", UIColor.systemGroupedBackground),
            ColorElement.background("secondarySystemGroupedBackground", UIColor.secondarySystemGroupedBackground),
            ColorElement.background("tertiarySystemGroupedBackground", UIColor.tertiarySystemGroupedBackground),
            ColorElement.separator("separator", UIColor.separator),
            ColorElement.separator("opaqueSeparator", UIColor.opaqueSeparator),
            ColorElement.text("link", UIColor.link),
            ColorElement.text("darkText", UIColor.darkText),
            ColorElement.text("lightText", UIColor.lightText)
        ]
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initColors()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        initColors()
        tableView?.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return namedColorElements.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = colorElementNames[section]
        return namedColorElements[type]!.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return colorElementNames[section].uppercased()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ColorsTableViewCell(style: .subtitle, reuseIdentifier: nil)
        let type = colorElementNames[indexPath.section]
        let element = namedColorElements[type]![indexPath.row]

        switch element {
        case .label(let name, let color):
            fallthrough
        case .text(let name, let color):
            let components = ColorComponents.from(color)
            cell.textLabel?.text = name
            cell.textLabel?.textColor = color
            cell.detailTextLabel?.text = components.rgbDescription
            cell.detailTextLabel?.textColor = UIColor.label
            cell.backgroundColor = UIColor.systemBackground
            cell.color = color
        case .separator(let name, let color):
            fallthrough
        case .fill(let name, let color):
            fallthrough
        case .background(let name, let color):
            let components = ColorComponents.from(color)
            cell.textLabel?.text = name
            cell.textLabel?.textColor = components.contrastingColor
            cell.detailTextLabel?.text = components.rgbDescription
            cell.detailTextLabel?.textColor = components.contrastingColor
            cell.backgroundColor = color
            cell.color = color
        }
        return cell
    }

}
