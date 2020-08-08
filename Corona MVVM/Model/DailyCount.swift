//
//  DailyCount.swift
//  Corona MVVM
//
//  Created by Frederic Orlando on 06/08/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import Foundation
import Charts

class DailyCount: Codable {
    var confirmed: Int!
    var date: String!
    var deaths: Int!
    var recovered: Int!
    
    private enum CodingKeys: String, CodingKey {
        case confirmed = "Confirmed"
        case date = "Date"
        case deaths = "Deaths"
        case recovered = "Recovered"
    }
     
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        confirmed = try container.decode(Int.self, forKey: .confirmed)
        date = try container.decode(String.self, forKey: .date)
        deaths = try container.decode(Int.self, forKey: .deaths)
        recovered = try container.decode(Int.self, forKey: .recovered)
    }
     
    enum Status {
        case confirmed
        case death
        case recovered
    }
     
    func getChartDataEntry(status: Status) -> ChartDataEntry {
        let x = Double(FormatterDate.toDate(string: date).timeIntervalSince1970)
        var y: Double
        
        switch status {
        case .confirmed:
            y = Double(confirmed)
        case .death:
            y = Double(deaths)
        case .recovered:
            y = Double(recovered)
        }
        
        return ChartDataEntry(x: x, y: y)
    }
}
