//
//  Pokemon.swift
//  Pokedex
//
//  Created by Paul Awadalla on 8/1/18.
//  Copyright © 2018 Paul Awadalla. All rights reserved.
//

import Foundation

class Pokemon  {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    
    //getter
    var name: String{
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        return _description
    }
    // creating the intializer
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}
