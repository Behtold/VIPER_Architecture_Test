//
//  DetailRouter.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

protocol DetailRouterProtocol: AnyObject {
    var view: DetailViewProtocol? { get }
    //var presenter: DetailPresenterProtocol?
}

class DetailRouter: DetailRouterProtocol {
    
    weak var view: DetailViewProtocol?
    //weak var presenter: DetailPresenterProtocol?
    
    init(for view: DetailViewProtocol) {
        self.view = view
    }
}
