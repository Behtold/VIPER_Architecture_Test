//
//  MainPresenter.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get }
    var router: MainRouterProtocol? { get }
    var interactor: MainInteractorProtocol? { get }
    var launches: [Launch] { get set }
    func viewDidLoad()
    func showLoadIndicator(_: Bool)
    func filterText(_: String) -> Bool
    func showAlert(title: String, message: String)
    func selectLaunchById(_: Int)
}


class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    
    var rocketFilter: String = ""
    
    var launches: [Launch] = [] {
        didSet {
            view?.reloadData(launches.map {
                LaunchViewModel($0)
            })
        }
    }
    
    required init(for view: MainViewProtocol) {
        self.view = view
        // self.launchesTable = view.launchTable // Вынес в MainModule
    }
    
    func viewDidLoad() {
        interactor?.getLaunches(filter: rocketFilter)
    }
    
    func showLoadIndicator(_ show: Bool) {
        view?.showLoadIndicator(show)
    }
    
    
    func filterText(_ text: String) -> Bool {
        interactor?.getLaunches(filter: text)
        return true
    }
    
    func showAlert(title: String, message: String) {
        view?.showAlert(title: title, message: message)
    }
    
    func selectLaunchById(_ id: Int) {
        guard let launch = launches.first(where: {$0.id == id}) else { return }
        router?.showDetail(about: launch)
    }
    
}
