//
//  CapsulesViewModel.swift
//  spaceX
//
//  Created by Cem Nisan on 11.12.2021.
//

import Foundation

final class CapsulesViewModel: ICapsulesViewModel {
    var capsules: [Capsules] = []
    var networkService: INetworkService
    weak var delegate: ICapsulesViewController?
    private var isLoad: Bool = false
    
    init(networkService:INetworkService, delegate: ICapsulesViewController) {
        self.networkService = networkService
        self.delegate = delegate
    }

    func fetchAllCapsules() {
        networkService.getCapsules { [weak self] (result) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch result {
                case .success(let data):
                    self.capsules = data
                    delegate.didUpdateCapsules(capsules: self.capsules)
                    self.changeLoad()
                case .failure(let error):
                    delegate.didFailWithError(error: error)
            }
        }
    }
    
    func fetchUpComingCapsules() {
        networkService.getUpComingCapsules { [weak self] (result) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch result {
                case .success(let data):
                    self.capsules = data
                    delegate.didUpdateCapsules(capsules: self.capsules)
                    self.changeLoad()
                case .failure(let error):
                    delegate.didFailWithError(error: error)
            }
        }
    }
    
    func fetchPastCapsules() {
        networkService.getPastCapsules { [weak self] (result) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch result {
                case .success(let data):
                    self.capsules = data
                    delegate.didUpdateCapsules(capsules: self.capsules)
                    self.changeLoad()
                case .failure(let error):
                    delegate.didFailWithError(error: error)
            }
        }
    }
    
    func changeLoad() {
        isLoad = true
        self.delegate?.didUpdateIndicator(isLoad: isLoad)
    }
    
}
