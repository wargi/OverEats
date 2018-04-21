//
//  ServiceResult.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 12..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}

enum PostError: Error {
    case missingParameter(param: String)
    case encodingError
}

enum ServiceError: Error {
    case invalidToken
    case invalidURL
    case parsingError
}

enum AuthError: Error {
    case invalidUsername
    case invalidPassword
}
