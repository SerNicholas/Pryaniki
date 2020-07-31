//
//  PryanikiData.swift
//  Pryaniki
//
//  Created by Nikola on 14/07/2020.
//  Copyright © 2020 Nikola Krstevski. All rights reserved.
//

import Foundation

struct PryanikiData: Decodable {
    let data: [DataArray]
    let view: [String]
    
}

struct DataArray: Codable {
    let name: String
    let data: DataStruct
}


struct DataStruct: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variants]?

    enum CodingKeys: String, CodingKey {
        case text
        case url
        case selectedID = "selectedId"
        case variants
    }
}

struct Variants: Codable {
    let id: Int?
    let text: String?
}



