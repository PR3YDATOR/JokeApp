	//
//  ViewController.swift
//  
//
//  Created by user238804 on 08/04/24.
//

import UIKit

class ViewController<T: ViewModel>: UIViewController {
    // MARK: - @IBOutlet
    var viewModel: T?

    // MARK: - Properties

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUi()
    }

    // MARK: - @IBAction

    // MARK: - Functions
    func setUi() {
        navigationController?.navigationBar.isHidden = true
    }
}
