//
//  Country.swift
//  Corona MVVM
//
//  Created by Frederic Orlando on 30/07/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation

class Country : Count {
    var name : String = ""
    var code : String = ""
    var slug : String = ""
    
    private enum CodingKeys: String, CodingKey {
        case name = "Country"
        case code = "CountryCode"
        case slug = "Slug"
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decode(String.self, forKey: .code)
        slug = try container.decode(String.self, forKey: .slug)
    }
}
