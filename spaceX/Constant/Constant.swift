//
//  Constant.swift
//  spaceX
//
//  Created by Cem Nisan on 10.12.2021.
//

import Foundation

struct K {
    
    struct App {
        static let nibName = "TableViewCell"
        static let reuseIdentifier = "capsulesReuse"
    }
    
    struct API {
        static let baseURL = "https://api.spacexdata.com/v3"
    }
    
    enum SegmentTitle: String {
        case allCapsules = "All Capsules"
        case upComing = "Up Coming"
        case past = "Past"
    }
    
}


