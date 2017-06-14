//
//  Repo.swift
//  GitHubReposRx
//
//  Created by Malcolm Kumwenda on 2017/06/14.
//  Copyright © 2017 ByteOrbit. All rights reserved.
//

import Foundation
import Mapper

struct Repo: Mappable {
    let id: Int
    let language: String
    let name: String
    let fullName: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try language = map.from("language")
        try name = map.from("name")
        try fullName = map.from("full_name")
    }
}
