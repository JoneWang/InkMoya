//
//  PluginType.swift
//  InkMoya
//
//  Created by Jone Wang on 2022/10/17.
//

import Foundation

public protocol PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest
    
    // TODO:
}
