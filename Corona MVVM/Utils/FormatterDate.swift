//
//  FormatterDate.swift
//  Corona MVVM
//
//  Created by Frederic Orlando on 06/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation

final class FormatterDate {
    static func toDate(string: String) -> Date {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = df.date(from: string)!
        return date
    }
    
    static func toDateValue(string: String) -> Int {
        let date = toDate(string: string)
        let df = DateFormatter()
        df.dateFormat = "dd"
        let dateValue = Int(df.string(from: date))!
        
        return dateValue
    }
}
