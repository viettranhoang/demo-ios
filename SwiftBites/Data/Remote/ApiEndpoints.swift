//
//  Endpoints.swift
//  BaseIos
//
//  Created by Vit on 6/12/24.
//

import Foundation
struct EndPoints {
    static let baseUrl = "https://dummyjson.com"
    
    static var explore: URL? {
        return URL(string: "\(baseUrl)/recipes")
    }
    
}

enum MIMEType: String {
    case JSON = "application/json"
    case form = "application/x-www-form-urlencoded"
}

enum HTTPMethods: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum HTTPHeaders: String {
    case contentType = "Content-Type"
    case accept = "Accept"
    case authorization = "Authorization"
}

enum NetworkError: Error {
    case badUrl
    case badResponse
    case failedToDecodeResponse
}


