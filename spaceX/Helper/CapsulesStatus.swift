//
//  CapsulesStatus.swift
//  spaceX
//
//  Created by Cem Nisan on 15.12.2021.
//

import Foundation

enum CapsulesStatus {
    case unkown
    case destroyed
    case active
    case retired
    
    static func getStatus(status: String) -> CapsulesStatus? {
        switch status {
        case "unknown":
            return .unkown
        case "destroyed":
            return .destroyed
        case "active":
            return .active
        case "retired":
            return .retired
        default:
            return nil
        }
    }
    
}
