//
//  WSError.swift
//  XSolveApp
//
//  Created by Kryg Tomasz on 05.09.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

enum WSError: Error {
    case wrongUrl
    case serviceError
    case invalidData
    case jsonDecodingFailure
    
    var localizedDescription: String {
        switch self {
        case .wrongUrl:
            return "wrongUrlAddress".localized()
        case .serviceError:
            return "errorFromWS".localized()
        case .invalidData:
            return "invalidData".localized()
        case .jsonDecodingFailure:
            return "jsonDecodingFailure".localized()
        }
    }
}
