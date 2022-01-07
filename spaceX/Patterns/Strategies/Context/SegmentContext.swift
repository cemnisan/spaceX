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
    
    func fetchCapsules(_ segmentTitle: String, viewModel: CapsulesViewModel){
        strategy.fetchCapsulesWithSegmentTitle(title: segmentTitle, from: viewModel)
    }
}
