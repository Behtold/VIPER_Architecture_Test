//
//  DetailInteractor.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get }
}

class DetailInteractor: DetailInteractorProtocol {
    
    weak var presenter: DetailPresenterProtocol?
    
    required init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
    }
}
