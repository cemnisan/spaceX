//
//  NetworkError.swift
//  spaceX
//
//  Created by Cem Nisan on 10.12.2021.
//

import Foundation

public enum NetworkError: Error {
    case parseError
    case badUrlError
    case badRequestError
    
    var errorMessage: String {
        switch self {
        case .parseError:
            return "parseError"
        case .badUrlError:
            return "badUrlError"
        case .badRequestError:
            return "badRequest"
        }
    }
}

