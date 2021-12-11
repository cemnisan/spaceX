//
//  NetworkManager.swift
//  spaceX
//
//  Created by Cem Nisan on 10.12.2021.
//

import Foundation
import Alamofire

public typealias Completion<M> = (Result<M, NetworkError>) -> Void where M: Codable

public final class NetworkManager {
    public static let shared = NetworkManager()
}

extension NetworkManager {
    func request<M: Codable>(requestRoute: NetworkRouter,
                                   responseModel: M.Type,
                                   completion: @escaping Completion<M>) {
       do {
           let urlRequest = try requestRoute.asURLRequest()
           
           AF.request(urlRequest).validate().responseJSON { (response) in
               switch response.result {
               case .success(let data):
                   do {
                       let resultsData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                       let jsonResults = try JSONDecoder().decode(responseModel, from: resultsData)
                       
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