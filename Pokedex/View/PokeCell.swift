//
//  PokeCell.swift
//  Pokedex
//
//  Created by Paul Awadalla on 8/1/18.
//  Copyright © 2018 Paul Awadalla. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbNail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        thumbNail.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
    
}
