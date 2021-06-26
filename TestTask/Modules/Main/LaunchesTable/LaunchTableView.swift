//
//  LaunchTableView.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 26.06.2021.
//

import UIKit

class LaunchTableView: UITableView, UITableViewDataSource {
    
    private let launchIdentifier = "LaunchViewCell"
    
    var launches: [LaunchViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: launchIdentifier, for: indexPath) as! LaunchViewCell
        cell.launch = launches[indexPath.row]
        return cell
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dataSource = self
        rowHeight = UITableView.automaticDimension
        register(UINib(nibName: launchIdentifier, bundle: nil),
                 forCellReuseIdentifier: launchIdentifier)
    }
    
}

