//
//  NetworkManager.swift
//  spaceX
//
//  Created by Cem Nisan on 10.12.2021.
//

import Foundation
import Alamofire

typealias Completion<T> = (Result<T, NetworkError>) -> Void where T: Codable

final class NetworkManager {
    public static let shared = NetworkManager()
    
    private init() {}
}

extension NetworkManager {
    
    func request<T: Codable>(requestRoute: NetworkRouter,
                                   responseModel: T.Type,
                                   completion: @escaping Completion<T>) {
       do {
           let urlRequest = try requestRoute.asURLRequest()
        
           AF.request(urlRequest)
            .validate()
            .responseJSON { (response) in
               switch response.result {
               case .success(let data):
                   do {
                       let resultsData = try JSONSerialization.data(withJSONObject: data,
                                                                    options: .prettyPrinted)
                       let jsonResults = try JSONDecoder().decode(responseModel,
                                                                  from: resultsData)
                       completion(.success(jsonResults))
                   } catch {
                       completion(.failure(.parseError))
                   }
               case .failure(_):
                   completion(.failure(.badRequestError))
               }
           }
       } catch {
           completion(.failure(.badUrlError))
       }
   }
}
