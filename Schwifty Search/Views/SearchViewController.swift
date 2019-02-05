//
//  SearchViewController.swift
//  Schwifty Search
//
//  Created by Alex Logan on 22/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import UIKit

class SearchViewController : UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var characters: [Character] = [] {
        didSet {
            filteredCharacters = characters
        }
    }
    
    var filteredCharacters: [Character] = []

    override func viewDidLoad() {
        characters = Character.storedObjects()
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate {
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        tableCell.textLabel?.text = characters[indexPath.row].name
        tableCell.detailTextLabel?.text = characters[indexPath.row].species
        print(characters[indexPath.row].name)
        return tableCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters.count
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCharacters = characters.filter({
            return $0.name.contains(searchText)
        })
    }
}

extension SearchViewController: UISearchDisplayDelegate {
    
}
