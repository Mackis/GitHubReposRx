//
//  API.swift
//  GitHubReposRx
//
//  Created by Malcolm Kumwenda on 2017/06/14.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import Foundation
import Moya


enum API {
    case userProfile(username: String)
    case repos(username: String)
    case repo(fullname: String)
    case issues(repositoryFullName: String)
}

private extension String {
    var URLEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}


extension API: TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    
    var path: String {
        switch self {
        case .userProfile(let username): return "/users/\(username.URLEscaped)/repos"
        case .repos(let username): return "/users/\(username.URLEscaped)/repos"
        case .repo(let fullname): return "/repos/\(fullname.URLEscaped)"
        case .issues(let reposname): return "/repos/\(reposname.URLEscaped)/issues"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
        switch self {
        case .repos(_):
            return "{{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}}}".utf8Encoded
        case .userProfile(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".utf8Encoded
        case .repo(_):
            return "{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}".utf8Encoded
        case .issues(_):
            return "{\"id\": 132942471, \"number\": 405, \"title\": \"Updates example with fix to String extension by changing to Optional\", \"body\": \"Fix it pls.\"}".utf8Encoded
        }
    }
    
    var task: Task {
        return .request
    }
}
