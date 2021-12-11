//
//  NetworkService.swift
//  spaceX
//
//  Created by Cem Nisan on 11.12.2021.
//

import Foundation

final class NetworkService: INetworkService {
    
    func getCapsules(completion: @escaping (Result<[CapsulesResponse], NetworkError>) -> Void) {
        NetworkManager.shared.request(requestRoute: NetworkRouter.capsules, responseModel: [CapsulesResponse].self) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
