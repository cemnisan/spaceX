//
//  SelectContext.swift
//  spaceX
//
//  Created by Cem Nisan on 7.01.2022.
//

import Foundation

enum SelectContext {
    static func getContext(_ title: String) -> SegmentContext? {
        switch title {
        case "All Capsules":
           return SegmentContext(strategy: FetchAllCapsules())
        case "Past":
           return SegmentContext(strategy: FetchPastCapsules())
        case "Up Coming":
           return SegmentContext(strategy: FetchUpComingCapsules())
        default:
            return nil
        }
    }
}
