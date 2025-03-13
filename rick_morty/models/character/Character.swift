//
//  Character.swift
//  rick_morty
//
//  Created by Felipe Santos on 07/03/25.
//

import Foundation

struct Character : Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
}
