//
//  ICapsulesViewModel.swift
//  spaceX
//
//  Created by Cem Nisan on 15.12.2021.
//

import Foundation

protocol ICapsulesViewModel {
    var capsules:[Capsules] { get }

    func fetchCapsulesWithSegmentTitle(title segmentTitle: String)
    func changeLoad()
}
