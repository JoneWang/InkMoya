//
//  TestAPI.swift
//  InkMoya
//
//  Created by Jone Wang on 2022/10/16.
//

import Foundation
@testable import InkMoya

enum TestAPI {
    case message
}

extension TestAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://raw.githubusercontent.com")!
    }
    
    var path: String {
        "/imink-app/InkMoya/main/Tests/InkMoyaTests/test.json"
    }
    
    var method: RequestMethod {
        .get
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var querys: [(String, String?)]? {
        nil
    }
    
    var data: MediaType? {
        nil
    }
    
    var sampleData: Data {
        "Exception".data(using: .utf8)!
    }
}
