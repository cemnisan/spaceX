//
//  Rockets.swift
//  spaceX
//
//  Created by Cem Nisan on 10.12.2021.
//

import Foundation


// MARK: - Rockets Response Model
struct CapsulesResponse:Codable {
    let capsuleSerial, capsuleID, status, originalLaunch: String?
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
