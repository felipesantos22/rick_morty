//
//  Location.swift
//  rick_morty
//
//  Created by Felipe Santos on 10/03/25.
//

import Foundation

struct Location : Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let created: String
}
