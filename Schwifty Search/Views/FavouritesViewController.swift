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
        let predicate = NSPredicate(format: "favourite = YES")
        let fetchRequest = NSFetchRequest<Character>(entityName: Character.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchRequest.predicate = predicate
        let results = try! Character.context.fetch(fetchRequest)
        self.characters = results
        
        UIView.transition(with: collectionView, duration: 0.6, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        }) { _ in }
    }
}

extension FavouritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let removeAddText = character.favourite ? "Remove" : "Add"
        let ac = UIAlertController(title: "Schwifty Search", message:
            removeAddText + " \(character.name) \(character.favourite ? "from" : "to") your favourites?", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: removeAddText, style: .default){
            _ in
            character.favourite.toggle()
            try! Character.context.save()
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
