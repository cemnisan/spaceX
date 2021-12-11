//
//  ViewController.swift
//  spaceX
//
//  Created by Cem Nisan on 10.12.2021.
//

import UIKit

protocol ICapsulesViewController {
    func showCapsules(capsules: [CapsulesResponse])
    func showError(error: NetworkError)
}

class CapsulesViewController: UIViewController {
    
    private var capsules:[CapsulesResponse] = []
    
    lazy var capsulesViewModel: CapsulesViewModel = {
        return CapsulesViewModel(networkService: NetworkService(), delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        capsulesViewModel.fetchCapsules()
    }
}

extension CapsulesViewController: ICapsulesViewController {
    func showCapsules(capsules: [CapsulesResponse]) {
        print(capsules[0].details ?? "")
    }
    
    func showError(error: NetworkError) {
        print(error)
    }
}
