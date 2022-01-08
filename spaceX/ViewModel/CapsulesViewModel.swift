//
//  CapsulesViewModel.swift
//  spaceX
//
//  Created by Cem Nisan on 11.12.2021.
//

import Foundation

final class CapsulesViewModel: ICapsulesViewModel {
    
    var capsules: [Capsules] = []
    weak var delegate: ICapsulesViewController?
    private var isLoad: Bool = false
    
    init(delegate: ICapsulesViewController) {
        self.delegate = delegate
    }

    func fetchCapsulesWithSegmentTitle(title segmentTitle: String) {
        NetworkManager.shared.request(requestRoute: NetworkRouter.getSegmentTitle(title: segmentTitle),
                                      responseModel: [Capsules].self) {[weak self] (completion) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch completion {
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
