//
//  ColorsTableViewController.swift
//  Colors
//
//  Created by Pavel Skaldin on 3/23/20.
//  Copyright © 2020 Grype. All rights reserved.
//

import UIKit

class ColorsTableViewController: UITableViewController {
    
    // MARK: - Types
    
    enum ComponentsType {
        case rgb, hsb
    }
    
    // MARK: - Properties
    
    var componentType: ComponentsType = .rgb {
        didSet {
            guard isViewLoaded else { return }
            tableView?.reloadData()
        }
    }
    
    var copyOnSelect = true
    
    private var colorElements: [ColorElement]!
    
    private lazy var namedColorElements: [String : [ColorElement]] = {
        var dict = [String: [ColorElement]]()
        colorElements.forEach { (element) in
            guard var values = dict[element.displayName] else {
                dict[element.displayName] = [element]
                return
            }
            values.append(element)
            dict[element.displayName] = values
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
    
    // MARK: - Accessing
    
    private func colorElement(at indexPath: IndexPath) -> ColorElement {
        let type = colorElementNames[indexPath.section]
        return namedColorElements[type]![indexPath.row]
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
        let element = colorElement(at: indexPath)

        switch element {
        case .label(let name, let color):
            fallthrough
        case .text(let name, let color):
            let components = ColorComponents.from(color)
            cell.textLabel?.text = name
            cell.textLabel?.textColor = color
            cell.detailTextLabel?.text = components.description(for: componentType)
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
            cell.detailTextLabel?.text = components.description(for: componentType)
            cell.detailTextLabel?.textColor = components.contrastingColor
            cell.backgroundColor = color
            cell.color = color
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard copyOnSelect else { return }
        let element = colorElement(at: indexPath)
        let componets = ColorComponents.from(element.color)
        UIPasteboard.general.string = componets.code(for: componentType)
    }

}

extension ColorComponents {
    func description(for aType: ColorsTableViewController.ComponentsType) -> String {
        switch aType {
        case .rgb:
            return rgbDescription
        case .hsb:
            return hsbDescription
        }
    }
    
    func code(for aType: ColorsTableViewController.ComponentsType) -> String {
        switch aType {
        case .rgb:
            return rgbCode
        case .hsb:
            return hsbCode
        }
    }
}
