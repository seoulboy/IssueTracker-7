//
//  EndPointType.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/30.
//

import Foundation

protocol EndPointable {
    var environmentBaseURL: String { get }
    var baseURL: URL { get }
    var query: String { get }
    var httpMethod: HTTPMethod? { get }
    var headers: HTTPHeader? { get }
    var bodies: HTTPBody? { get }
}

enum HTTPMethod: String {
    case post,
         get
}
public typealias HTTPHeader = [String: String]
public typealias HTTPBody = [String: String]