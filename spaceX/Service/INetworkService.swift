//
//  INetworkService.swift
//  spaceX
//
//  Created by Cem Nisan on 11.12.2021.
//

import Foundation

protocol INetworkService {
    func getCapsules(completion: @escaping (Result<[CapsulesResponse], NetworkError>) -> Void)
}
