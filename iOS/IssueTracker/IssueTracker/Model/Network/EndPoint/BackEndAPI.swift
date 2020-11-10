//
//  BackEndAPI.swift
//  IssueTracker
//
//  Created by a1111 on 2020/10/31.
//

import Foundation

enum BackEndAPI {
    case token
    case allIssues
    
    case allAuthors,
         allLabels,
         allMilestones,
         allAssignees
         
    case predefinedFilter(query: String)
}

extension BackEndAPI: EndPointable {
    var environmentBaseURL: String {
        switch self {
        case .token:
            return "http://\(BackEndAPICredentials.ip)/api/auth/github/ios"
        case .allIssues:
            return "http://\(BackEndAPICredentials.ip)/api/issue"
        case .allLabels:
            return "http://\(BackEndAPICredentials.ip)/api/label"
        case .allMilestones:
            return "http://\(BackEndAPICredentials.ip)/api/milestone"
        case .allAssignees, .allAuthors:
            return "http://\(BackEndAPICredentials.ip)/api/user"
        case .predefinedFilter:
            return "http://\(BackEndAPICredentials.ip)/api/issue"
        }
    }
    
    var baseURL: URLComponents {
        guard let url = URLComponents(string: environmentBaseURL) else { fatalError() } // TODO: 예외처리로 바꿔주기
        return url
    }
    
    var query: [String: String]? {
        switch self {
        case .predefinedFilter(let query):
            return ["q": query]
        default:
            return nil
        }
    }
    
    var httpMethod: HTTPMethod? {
        switch self {
        case .token:
            return .post
        case .allIssues, .allLabels, .allMilestones, .allAssignees, .allAuthors, .predefinedFilter:
            return .get
        }
    }
    
    var headers: HTTPHeader? {
        return ["Authorization": "bearer \(UserInfo.shared.accessToken)"]
    }
    
    var bodies: HTTPBody? {
        return nil
    }
}


//var bodies: HTTPBody? {
//    switch self {
//    case .accessToken(let code):
//        return ["client_id": GithubAPICredentials.clientId, "client_secret": GithubAPICredentials.clientSecret, "code": code]
//    default:
//        return nil
//    }
//}
