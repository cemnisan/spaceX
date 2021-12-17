//
//  NetworkService.swift
//  spaceX
//
//  Created by Cem Nisan on 11.12.2021.
//

import Foundation

final class NetworkService: INetworkService {
    
    func getCapsules(completion: @escaping (Result<[Capsules], NetworkError>) -> Void) {
        NetworkManager.shared.request(requestRoute: NetworkRouter.capsules, responseModel: [Capsules].self) { (result) in
            switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getUpComingCapsules(completion: @escaping (Result<[Capsules], NetworkError>) -> Void) {
        NetworkManager.shared.request(requestRoute: NetworkRouter.upComingCapsules, responseModel: [Capsules].self) { (result) in
            switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getPastCapsules(completion: @escaping (Result<[Capsules], NetworkError>) -> Void) {
        NetworkManager.shared.request(requestRoute: NetworkRouter.pastCapsules, responseModel: [Capsules].self) { (result) in
            switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
}
