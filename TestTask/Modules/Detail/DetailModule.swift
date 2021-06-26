//
//  DetailModule.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

import UIKit

class DetailModule {
    
    static func configure(launch: Launch) -> UIViewController {
        let view = DetailView(nibName: "DetailView", bundle: nil)
        view.title = launch.name
        let presenter = DetailPresenter(for: view, launch: launch)
        let interactor = DetailInteractor(presenter: presenter)
        let router = DetailRouter(for: view)
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}
