//
//  Count.swift
//  Corona MVVM
//
//  Created by Frederic Orlando on 31/07/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation
import Charts

class Count : Codable {
    var totalConfirmed : Int = 0
    var totalDeaths : Int = 0
    var totalRecovered : Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case totalConfirmed = "TotalConfirmed"
        case totalDeaths = "TotalDeaths"
        case totalRecovered = "TotalRecovered"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalConfirmed = try container.decode(Int.self, forKey: .totalConfirmed)
        totalDeaths = try container.decode(Int.self, forKey: .totalDeaths)
        totalRecovered = try container.decode(Int.self, forKey: .totalRecovered)
    }
}
