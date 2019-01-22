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
        CharacterRequest().fetchCharacters{
            chars, err in
            if let chars = chars {
                self.characters.append(contentsOf: chars)
                self.collectionView.reloadData()
            }
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CharacterCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
    }
    
}

extension RecentViewController: UICollectionViewDelegate {
    
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
