//
//  RecipeRemote.swift
//  BaseIos
//
//  Created by Vit on 6/12/24.
//
import Foundation

protocol RecipeRemote {
    
    func fetchExplore() async throws -> [RecipeDto]
}

class RecipeRemoteImpl: RecipeRemote {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
    }
    
    func fetchExplore() async throws -> [RecipeDto] {
        guard let url = EndPoints.explore else {
            throw NetworkError.badUrl
        }
        let result: RecipeResponse = try await performRequest(url: url, method: .GET)
        return result.recipes
    }
    
    private func performRequest<T>(
        url: URL,
        method: HTTPMethods,
        body: Encodable? = nil,
        headers: [String: String] = [:],
        customBody: Data? = nil
    ) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(MIMEType.JSON.rawValue, forHTTPHeaderField: HTTPHeaders.accept.rawValue)
        request.addValue(MIMEType.JSON.rawValue, forHTTPHeaderField: HTTPHeaders.contentType.rawValue)
        
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        
        if let customBody = customBody {
            request.httpBody = customBody
        } else if let body = body {
            request.httpBody = try encoder.encode(body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badResponse
            }
            
            if T.self == Void.self {
                return () as! T
            }
            if let decodableType = T.self as? Decodable.Type {
                guard let result = try? decoder.decode(decodableType, from: data) as? T else {
                    throw NetworkError.failedToDecodeResponse
                }
                return result
            }
            
            throw NetworkError.badResponse
            
        } catch {
            throw NetworkError.failedToDecodeResponse
        }
    }
}
