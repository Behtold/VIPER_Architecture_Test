//
//  LaunchViewModel.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 26.06.2021.
//

import UIKit // UIColor хочу 🥺 А еще там Foundation есть (нужен для DateFormatter)

struct LaunchViewModel {
    let id: Int
    let name: String?
    let date: String?
    let successSymbol: String?
    let successColor: UIColor
    let details: UITableViewCell.AccessoryType
    
    
    init(_ launch: Launch) {
        id = launch.id
        name = launch.name
        
        if let date = launch.date {
            let formater = DateFormatter()
            formater.dateFormat = "HH:mm:ss dd.MM.yyyy"
            self.date = formater.string(from: date)
        } else {
            date = nil
        }
        switch launch.success {
        case true:
            successSymbol = "✔︎"
            successColor = .green
        case false:
            successSymbol = "✘"
            successColor = .red
        default:
            successSymbol = "?"
            successColor = .lightGray
        }
        details = (launch.details == nil) ? .none : .detailDisclosureButton 
        
    }
}
