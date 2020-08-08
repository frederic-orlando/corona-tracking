//
//  URL.swift
//  Corona MVVM
//
//  Created by Frederic Orlando on 31/07/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation

class URL {
    static let BASE_URL = "https://api.covid19api.com"
    static let GET_SUMMARY = BASE_URL + "/summary"
    
    class func getByCountry(slug: String) -> String {
        return BASE_URL + "/dayone/country/\(slug)"
    }
}
