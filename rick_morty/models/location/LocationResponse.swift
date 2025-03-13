//
//  LocationResponse.swift
//  rick_morty
//
//  Created by Felipe Santos on 10/03/25.
//

import Foundation

struct LocationResponse: Decodable {
    let info: Info
    let results: [Location]
}
