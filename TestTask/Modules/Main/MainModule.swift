//
//  MainConfigurator.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

import UIKit

class MainModule {
    
    static func configure(title: String?) -> UIViewController {
        let view = MainView(nibName: "MainView", bundle: nil)
        view.title = title
        let presenter = MainPresenter(for: view)
        let interactor = MainInteractor(presenter: presenter)
        let router = MainRouter(for: view)
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        
        //router.presenter = presenter
        
        return view
    }
}
