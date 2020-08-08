//
//  ViewController.swift
//  Corona MVVM
//
//  Created by Frederic Orlando on 30/07/20.
//  Copyright © 2020 Frederic Orlando. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    @IBOutlet weak var coronaTable: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let CELL_NIB = "CoronaTableCell"
    let SEGUE_DETAIL = "showDetail"
    
    var viewModel : CoronaViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CoronaViewModel(listener: self, reloadListener: self, searchListener: self)
        
        title = "Corona Info"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        initSearch()
        initTable()
        viewModel.loadData()
    }
    
    func initTable() {
        coronaTable.dataSource = viewModel
        coronaTable.delegate = viewModel
        
        let nib = UINib(nibName: CELL_NIB, bundle: nil)
        coronaTable.register(nib, forCellReuseIdentifier: "coronaCell")
        
        coronaTable.tableFooterView = UIView();
        coronaTable.contentInsetAdjustmentBehavior = .never
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        coronaTable.refreshControl = refreshControl
    }
    
    @objc func loadData() {
        viewModel.loadData()
    }
    
    func initSearch() {
        searchController.searchResultsUpdater = viewModel
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.extendedLayoutIncludesOpaqueBars = true;
        definesPresentationContext = false
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case SEGUE_DETAIL:
            let destination = segue.destination as! CountryDetailViewController
            destination.country = sender as? Country
            break
        default:
            break
        }
    }
}

extension ViewController: CoronaViewModelDelegate, ReloadTableDelegate {
    func reloadTable() {
        coronaTable.reloadData()
        coronaTable.refreshControl?.endRefreshing()
    }
    
    func onItemClick(country: Country) {
        performSegue(withIdentifier: SEGUE_DETAIL, sender: country)
    }
}

extension ViewController: SearchControllerDelegate {
    var searchText: String {
        searchController.searchBar.text!
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
}
