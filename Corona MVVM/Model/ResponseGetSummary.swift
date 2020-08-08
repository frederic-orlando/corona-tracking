//
//  ResponseGetSummary.swift
//  Corona MVVM
//
//  Created by Frederic Orlando on 01/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation

class ResponseGetSummary : Codable {
    var global : Count!
    var countries : [Country]!
    
    private enum CodingKeys : String, CodingKey {
        case global = "Global"
        case countries = "Countries"
    }
}
