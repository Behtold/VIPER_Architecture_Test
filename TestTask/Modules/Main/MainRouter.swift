//
//  MainRouter.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
    var view: MainViewProtocol? { get }
    func showDetail(about launch: Launch)
}


class MainRouter: MainRouterProtocol {
    
    weak var view: MainViewProtocol?
    private var controller: UIViewController? {
        view as? UIViewController
    }
    
    init(for view: MainViewProtocol) {
        self.view = view
    }
    
    func showDetail(about launch: Launch) {
        let detailView = DetailModule.configure(launch: launch)
        controller?.show(detailView, sender: nil)
        // Еще вариант
        //controller?.present(detailView, animated: true, completion: nil)
    }
}
