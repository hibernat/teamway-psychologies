//
//  TestAPI.swift
//  
//
//  Created by Michael Bernat on 03.12.2022.
//

import API

enum TestAPI: API {
    
    static let baseUrlText = "https://www.abc.com"
    static let path = "/v1/user"
    static let headers = ["Authorization" : "Bearer xxx"]
    
    
    case getSomething
    case postSomething(parameters: [String : String]?)
    
    var baseUrlText: String { Self.baseUrlText }
    
    var path: String { Self.path }
    
    var method: APIMethod {
        switch self {
        case .getSomething: return .get
        case .postSomething: return .post
        }
    }
    
    var headers: [String : String]? { Self.headers }
    
    var jsonParameters: [String : Any]? {
        switch self {
        case .getSomething: return nil
        case .postSomething(let parameters): return parameters
        }
    }
    
}

