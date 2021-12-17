//
//  NetworkRouter.swift
//  spaceX
//
//  Created by Cem Nisan on 10.12.2021.
//

import Alamofire
import Foundation

public enum NetworkRouter: URLRequestConvertible {
    case capsules
    case capsule(serialID: String)
    case upComingCapsules
    case pastCapsules
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .capsules, .capsule, .upComingCapsules, .pastCapsules:
            return .get
        }
    }
    
    // MARK: - URLPath
    private var path: String {
        switch self {
        case .capsules:
            return "/capsules"
        case .capsule(let serial_id):
            return "/capsules/\(serial_id)"
        case .upComingCapsules:
            return "/capsules/upcoming"
        case .pastCapsules:
            return "/capsules/past"
        }
    }
    
    private var baseURL: String {
        return K.API.baseURL
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .capsules, .capsule, .upComingCapsules, .pastCapsules:
            return  nil
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
}
