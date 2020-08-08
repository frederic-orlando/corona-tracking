//
//  CoronaTableCell.swift
//  Corona MVVM
//
//  Created by Frederic Orlando on 30/07/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import UIKit

class CoronaTableCell: UITableViewCell {
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var coronaCountLbl: UILabel!
    
    var country : Country! {
        didSet {
            initData();
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func initData() {
        countryNameLbl.text = "\(country.name) (\(country.code))"
        let confirmed = NumberFormatter.localizedString(from: NSNumber(value: country.totalConfirmed), number: NumberFormatter.Style.decimal)
        coronaCountLbl.text = "Confirmed: \(confirmed)"
    }
}
