//
//  CapsulesViewModel.swift
//  spaceX
//
//  Created by Cem Nisan on 11.12.2021.
//

import Foundation

protocol ICapsulesViewModel {
    var networkService: INetworkService { get }
    var capsules:[Capsules] { get }
    
    func fetchCapsules()
    func fetchUpComingCapsules()
    func fetchPastCapsules()
}

final class CapsulesViewModel: ICapsulesViewModel {
    var capsules: [Capsules] = []
    var networkService: INetworkService
    weak var delegate: ICapsulesViewController?
    
    init(networkService:INetworkService, delegate: ICapsulesViewController) {
        self.networkService = networkService
        self.delegate = delegate
    }

    func fetchCapsules() {
        networkService.getCapsules { [weak self] (result) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch result {
                case .success(let data):
                    self.capsules = data
                    delegate.showCapsules(capsules: self.capsules)
                case .failure(let error):
                    delegate.showError(error: error)
            }
        }
    }
    
    func fetchUpComingCapsules() {
        networkService.getUpComingCapsules { [weak self] (result) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch result {
                case .success(let data):
                    self.capsules = data
                    delegate.showCapsules(capsules: self.capsules)
                case .failure(let error):
                    delegate.showError(error: error)
            }
        }
    }
    
    func fetchPastCapsules() {
        networkService.getPastCapsules { [weak self] (result) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch result {
                case .success(let data):
                    self.capsules = data
                    delegate.showCapsules(capsules: self.capsules)
                case .failure(let error):
                    delegate.showError(error: error)
            }
        }
    }
}
