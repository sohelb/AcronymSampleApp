//
//  ViewController.swift
//  AcronymApp
//
//  Created by Sohel Bukhari on 10/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel = {
        AcronymViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.acronymViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let cellModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellModel
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getAcronymsFor(sf: searchBar.text ?? "")
    }
}


