//
//  FavouritesViewController.swift
//  Schwifty Search
//
//  Created by Alex Logan on 22/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import UIKit
import CoreData

class FavouritesViewController: UIViewController {
    var characters: [Character] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupNavigationBar()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
    }
    
    private func setupNavigationBar() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchData))
        refreshButton.tintColor = .white
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc private func fetchData() {
        // fetch core data instead
        let results = FavouriteCharacter.storedObjects().map { (favouriteCharacter) -> Character in
            return (favouriteCharacter as! FavouriteCharacter).character
        }
        
        self.characters = results
        
        UIView.transition(with: collectionView, duration: 0.6, options: .transitionCurlDown, animations: {
            self.collectionView.reloadData()
        }) { _ in }
    }
}

extension FavouritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        var removeAddText = "Add"
        let favouriteCharacter = FavouriteCharacter.storedObjects() as? [FavouriteCharacter]
        if let favouriteCharacters = favouriteCharacter {
            if (favouriteCharacters.filter {
                $0.id == character.id
            }).first != nil {
                removeAddText = "Remove"
            }
        }
        
        let ac = UIAlertController(title: "Schwifty Search", message:
            removeAddText + " \(character.name) \(removeAddText == "add" ? "to": "from") your favourites?", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: removeAddText, style: .default){
            _ in
//            character.favourite.toggle()
            try! Context.context.save()
            self.fetchData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ _ in ac.dismiss(animated: true, completion: nil)}
        ac.addAction(addAction)
        ac.addAction(cancelAction)
        self.present(ac, animated: true, completion: nil)
    }
}

extension FavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCell
        cell.character = characters[indexPath.row]
        return cell
    }
    
    
}
