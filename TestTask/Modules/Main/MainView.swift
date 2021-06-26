//
//  MainView.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get }
    func showLoadIndicator(_: Bool)
    func reloadData(_:[LaunchViewModel])
    func showAlert(title: String, message: String)
}

class MainView: UIViewController, MainViewProtocol  {
    
    private let launchIdentifier = "LaunchCell"
    var presenter: MainPresenterProtocol?
    
    @IBOutlet weak var launchNameFilterField: UITextField!
    @IBOutlet weak var launchesTable: LaunchTableView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchNameFilterField.delegate = self
        launchesTable.delegate = self
        presenter?.viewDidLoad()
    }
    
    func reloadData(_ launches:[LaunchViewModel]) {
        launchesTable.launches = launches
    }
    
    func showLoadIndicator(_ show: Bool) {
        DispatchQueue.main.async {
            self.view.bringSubviewToFront(self.loadIndicator)
            self.loadIndicator.isHidden = !show
        }
    }
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: launchesTable.delegate
extension MainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectLaunchById(
            launchesTable.launches[indexPath.row].id
        )
    }
}

// MARK: rocketFilterField.delegate

extension MainView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString?{
            return presenter?.filterText(text.replacingCharacters(in: range, with: string)) ?? true
        }
        return true
    }
    
}
