//
//  LaunchViewCell.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 26.06.2021.
//

import UIKit

class LaunchViewCell: UITableViewCell {
    
    @IBOutlet weak var success: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var details: UILabel!
    
    var launch: LaunchViewModel! {
        didSet {
            name.text = launch.name
            details.text = launch.date
            success.text = launch.successSymbol
            success.textColor = launch.successColor
            accessoryType = launch.details
        }
    }
}
