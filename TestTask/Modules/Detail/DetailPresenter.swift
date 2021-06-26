//
//  DetailPresenter.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

protocol DetailPresenterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    var router: DetailRouterProtocol? { set get }
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    
    var launch: Launch
    
    required init(for view: DetailViewProtocol, launch: Launch) {
        self.launch = launch
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setDetailInfo(launch.details)
    }
}
