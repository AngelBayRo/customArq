//
//  URLEndpoint.swift
//  customArq
//
//  Created by angel.bayon on 19/6/22.
//

import Foundation

import UIKit

public enum Environment: Int {
    case LOC = 0
}

struct URLEndpoint {
    static let environementDefault: Environment = Environment.LOC
    
    public enum BaseURLContext {
        case backend
    }
    
    static let home: String = "/pokemon"
}

extension URLEndpoint {
    static func getBaseUrl(urlContext: BaseURLContext) -> String {
        switch urlContext {
        case .backend:
            switch self.environementDefault {
            case .LOC:
                return "https://pokeapi.co/api"
            }
        }
    }
    
    static func getVersion(urlContext: BaseURLContext) -> String {
        switch urlContext {
        case .backend:
            switch self.environementDefault {
            case .LOC:
                return "/v2"
            }
        }
    }
    
    static func buildURL(urlContext: BaseURLContext, endpoint: String) -> String {
        switch urlContext {
        case .backend:
            switch self.environementDefault {
            case .LOC:
                return getBaseUrl(urlContext: urlContext) + endpoint
            }
        }
    }
}
