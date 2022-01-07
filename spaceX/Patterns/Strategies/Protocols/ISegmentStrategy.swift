//
//  ISegmentStrategy.swift
//  spaceX
//
//  Created by Cem Nisan on 7.01.2022.
//

import Foundation

protocol ISegmentStrategy {
    func fetchCapsulesWithSegmentTitle(title segmentTitle: String, from viewModel: CapsulesViewModel)
}
