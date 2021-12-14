//
//  Rockets.swift
//  spaceX
//
//  Created by Cem Nisan on 10.12.2021.
//

import Foundation


// MARK: - Rockets Response Model
struct Capsules:Codable {
    let capsuleSerial: String?
    let capsuleID:String?
    let status:String?
    let originalLaunch:String?
    let originalLaunchUnix: Int?
    let missions: [CapsuleMission]?
    let landings: Int?
    let type, details: String?
    let reuseCount: Int?
}

// MARK: - Mission
struct CapsuleMission: Codable {
    let name: String?
    let flight: Int?
}
