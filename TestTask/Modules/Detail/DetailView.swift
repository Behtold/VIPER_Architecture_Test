//
//  DetailView.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenter? { get }
    func setDetailInfo(_:String?)
}

class DetailView: UIViewController, DetailViewProtocol {
     
    @IBOutlet weak var detailLabel: UILabel!
    
    var presenter: DetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func setDetailInfo(_ text: String?) {
        guard let info = text else { return }
        detailLabel.text = info
    }
}
