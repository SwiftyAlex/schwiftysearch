//
//  RecentViewController.swift
//  Schwifty Search
//
//  Created by Alex Logan on 22/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController {
    var characters: [Character] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        
        CharacterRequest().fetchCharacters{
            chars, err in
            if let chars = chars {
                self.characters.append(contentsOf: chars)
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension RecentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let favouriteCharacters = FavouriteCharacter.storedObjects() as? [FavouriteCharacter]
        var favouriteCharacterRecord: FavouriteCharacter? = nil
        var removeAddText = "Add"
        if let favouriteCharacters = favouriteCharacters {
            if let fave = (favouriteCharacters.filter {
                $0.id == character.id
            }).first {
                favouriteCharacterRecord = fave
                removeAddText = "Remove"
            }
        }
        
        let ac = UIAlertController(title: "Schwifty Search", message:
            removeAddText + " \(character.name) \(removeAddText == "Add" ? "to": "from") your favourites?", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: removeAddText, style: .default){
            _ in
            if let fave = favouriteCharacterRecord {
                Context.context.delete(fave)
            } else {
                let favouriteCharacter = FavouriteCharacter.init(entity: FavouriteCharacter.entity(), insertInto: Context.context)
                favouriteCharacter.character = character
                favouriteCharacter.id = character.id
            }
            try! Context.context.save()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ _ in ac.dismiss(animated: true, completion: nil)}
        ac.addAction(addAction)
        ac.addAction(cancelAction)
        self.present(ac, animated: true, completion: nil)
    }
}

extension RecentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCell
        cell.character = characters[indexPath.row]
        return cell
    }
    
    
}
