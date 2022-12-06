//
//  APIError.swift
//  
//
//  Created by Michael Bernat on 03.12.2022.
//

public enum APIError: Error, Equatable, Sendable {
    case invalidBaseURL
    case invalidRequestJsonParameters
}
