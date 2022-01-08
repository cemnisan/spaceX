//
//  Strategy.swift
//  spaceX
//
//  Created by Cem Nisan on 7.01.2022.
//

import Foundation

struct SegmentContext {
    private let strategy: ISegmentStrategy
    
    init(strategy: ISegmentStrategy) {
        self.strategy = strategy
    }
    
    func fetchCapsules(from viewModel: CapsulesViewModel) {
        let segmentTitle = strategy.fetchCapsulesWithSegmentTitle()
        
        viewModel.fetchCapsulesWithSegmentTitle(title: segmentTitle)
    }
}
