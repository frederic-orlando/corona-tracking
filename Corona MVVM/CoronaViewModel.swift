//
//  CoronaViewModel.swift
//  Corona MVVM
//
//  Created by Frederic Orlando on 31/07/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

protocol SearchControllerDelegate {
    var searchText: String { get }
    var isFiltering: Bool { get }
}

protocol ReloadTableDelegate {
    func reloadTable()
}

protocol CoronaViewModelDelegate {
    func onItemClick(country : Country)
}

class CoronaViewModel: NSObject {
    var listener : CoronaViewModelDelegate!
    var reloadListener : ReloadTableDelegate!
    var searchListener : SearchControllerDelegate!
    
    var countries : [Country] = [] {
        didSet {
            reloadListener.reloadTable()
        }
    }
    
    var filteredCountries : [Country] = [] {
        didSet {
            reloadListener.reloadTable()
        }
    }
    
    var isFiltering : Bool {
        return searchListener.isFiltering
    }
    
    init(listener : CoronaViewModelDelegate, reloadListener : ReloadTableDelegate, searchListener : SearchControllerDelegate) {
        self.listener = listener
        self.reloadListener = reloadListener
        self.searchListener = searchListener
    }
    
    func loadData() {
        AF.request(URL.GET_SUMMARY).responseJSON { (response) in
            let json = response.value as! [String:Any]
            
            do {
                let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response : ResponseGetSummary = try! JSONDecoder().decode(ResponseGetSummary.self, from: data)
                self.countries = response.countries
            }
            catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func filterCountryByName(_ searchText: String) {
        if countries.count != 0 {
            filteredCountries = countries.filter({ (country) -> Bool in
                return country.name.lowercased().contains(searchText.lowercased())
            })
        }
    }
}

extension CoronaViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCountries.count
        }
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coronaCell") as! CoronaTableCell
        let row  = indexPath.row
        var country : Country
        if isFiltering {
            country = filteredCountries[row]
        }
        else {
            country = countries[row]
        }
        
        cell.country = country
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row  = indexPath.row
        var country : Country
        if isFiltering {
            country = filteredCountries[row]
        }
        else {
            country = countries[row]
        }
        
        listener.onItemClick(country: country)
    }
}

extension CoronaViewModel: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterCountryByName(searchListener.searchText)
    }
}
