//
//  Issue.swift
//  GitHubReposRx
//
//  Created by Malcolm Kumwenda on 2017/06/14.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import Foundation
import Mapper

struct Issue: Mappable {
    let id: Int
    let number: Int
    let title: String
    let body: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try number = map.from("number")
        try title = map.from("title")
        try body = map.from("body")
    }
}
