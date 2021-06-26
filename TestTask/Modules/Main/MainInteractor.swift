//
//  MainInteractor.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get }
    func getLaunches(filter: String)
}


class MainInteractor: MainInteractorProtocol {
    
    let network: NetworkServiceProtocol = NetworkService()
    let storage: StorageServiceProtocol = StorageService()
    
    weak var presenter: MainPresenterProtocol?
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getLaunches(filter: String) {
        if storage.launches.isEmpty {
            presenter?.showLoadIndicator(true)
            network.getAllLauncher { launches, error in
                self.presenter?.showLoadIndicator(false)
                if let error = error {
                    self.presenter?.showAlert(title: "", message: error)
                }
                if let launches = launches {
                    self.storage.saveLaunches(launches) {
                        self.presenter?.launches = self.storage.filterLaunches(filter: filter)
                    }
                    return
                }
            }
        }
        self.presenter?.launches = self.storage.filterLaunches(filter: filter)
    }
    
}
