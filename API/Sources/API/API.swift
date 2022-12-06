//
//  API.swift
//  
//
//  Created by Michael Bernat on 03.12.2022.
//

import Foundation

public protocol API {
    var baseUrlText: String { get }
    var path: String { get }
    var method: APIMethod { get }
    var headers: [String : String]? { get }
    var jsonParameters: [String : Any]? { get }
}

public extension API {
    
    /// throws APIError type only
    func makeURLRequest() throws -> URLRequest {
        guard let baseURL = URL(string: baseUrlText) else {
            throw APIError.invalidBaseURL
        }
        let url = baseURL.appending(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        if let jsonParameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: jsonParameters)
            } catch {
                throw APIError.invalidRequestJsonParameters
            }
        }
        return request
    }
    
}
