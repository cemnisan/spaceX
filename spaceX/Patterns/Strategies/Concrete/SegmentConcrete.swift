//
//  SegmentConcrete.swift
//  spaceX
//
//  Created by Cem Nisan on 7.01.2022.
//

import Foundation

struct FetchAllCapsules: ISegmentStrategy {
    func fetchCapsulesWithSegmentTitle() -> String {
        return "All Capsules"
    }
}

struct FetchUpComingCapsules: ISegmentStrategy {
    func fetchCapsulesWithSegmentTitle() -> String {
        return "Up Coming"
    }
}

struct FetchPastCapsules: ISegmentStrategy {
    func fetchCapsulesWithSegmentTitle() -> String {
        return "Past"
    }
}

