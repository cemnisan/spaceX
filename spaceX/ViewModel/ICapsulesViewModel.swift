//
//  ICapsulesViewModel.swift
//  spaceX
//
//  Created by Cem Nisan on 15.12.2021.
//

import Foundation

protocol ICapsulesViewModel {
    var networkService: INetworkService { get }
    var capsules:[Capsules] { get }

    func fetchAllCapsules()
    func fetchUpComingCapsules()
    func fetchPastCapsules()
    func changeLoad()
}
