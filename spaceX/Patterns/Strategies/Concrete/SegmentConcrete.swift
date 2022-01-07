//
//  SegmentConcrete.swift
//  spaceX
//
//  Created by Cem Nisan on 7.01.2022.
//

import Foundation

struct FetchAllCapsules: ISegmentStrategy {
    func fetchCapsulesWithSegmentTitle(title segmentTitle: String, from viewModel: CapsulesViewModel) {
        viewModel.fetchAllCapsules()
    }
}

struct FetchUpComingCapsules: ISegmentStrategy {
    func fetchCapsulesWithSegmentTitle(title segmentTitle: String, from viewModel: CapsulesViewModel) {
        viewModel.fetchUpComingCapsules()
    }
}

struct FetchPastCapsules: ISegmentStrategy {
    func fetchCapsulesWithSegmentTitle(title segmentTitle: String, from viewModel: CapsulesViewModel) {
        viewModel.fetchPastCapsules()
    }
}

