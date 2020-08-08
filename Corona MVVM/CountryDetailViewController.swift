//
//  CountryDetailViewController.swift
//  Corona MVVM
//
//  Created by Frederic Orlando on 31/07/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import UIKit
import Alamofire
import Charts

class CountryDetailViewController: UIViewController {
    @IBOutlet weak var countryNameLbl: UILabel!
    
    enum Segues {
        static let chartView = "chartView"
    }
    
    var country : Country!
    
    var chartViewController : LineChartViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Detail"
        
        countryNameLbl.text = country?.name
        
        AF.request(URL.getByCountry(slug: country.slug)).responseJSON { (response) in
            if let json = response.value as? [[String : Any]] {
                do {
                    let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    
                    self.chartViewController.dailyCounts = try! JSONDecoder().decode([DailyCount].self, from: data)
                }
                catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
            else {
                print("no data")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.chartView:
            chartViewController = segue.destination as? LineChartViewController
        default:
            break
        }
    }
}
