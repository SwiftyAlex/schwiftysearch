//
//  CharacterCell.swift
//  Schwifty Search
//
//  Created by Alex Logan on 22/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation
import UIKit

class CharacterCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    var character: Character? = nil {
        didSet {
            guard let character = character else {
                return
            }
            if let urlString = character.image, let url = URL(string: urlString)  {
                imageView.load(url: url)
            }
            nameLabel.text = character.name
            speciesLabel.text = character.species
        }
    }
}
