//
//  ViewController.swift
//  Pokedex
//
//  Created by Paul Awadalla on 8/1/18.
//  Copyright © 2018 Paul Awadalla. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlays: AVAudioPlayer!
    var inSearchMode = false
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collection.dataSource = self
        collection.delegate = self
        SearchBar.delegate = self
        //change the search button to done button
        SearchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
        
       
    }
    // function for music playing
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            musicPlays = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlays.prepareToPlay()
            musicPlays.numberOfLoops = -1
            musicPlays.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
   
    
    // parse the pokemon form the csv data
    func parsePokemonCSV(){
        // creatig the path to csv file
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            // using parser to pull out the rows
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
         // the for loop is to loop threw each row to pull out the name and pokeId
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                // creating a pokemon object
                let poke = Pokemon(name: name, pokedexId: pokeId)
                //attaching this append to my pokemon array
                pokemon.append(poke)
            }
            
        } catch  let err as NSError {
            print(err.debugDescription)
        }
    }
    
    // this function is a reusebale function so the data doesnt load all at the same time
    //dequeue the cell and sets it up.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            //call the function from Pokecell.swift
            //take the data we are passing form the pokemon object.
            let poke: Pokemon!
            // if the user is searching the poke equals to the new array of filtered pokemen
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
                // if not the goes back to back to normal array
            } else {
                poke = pokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
    
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
        
    }
    // number of items in the collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
        
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // setting the width and height in a collection view.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func musicButton(_ sender: UIButton) {
        //if else statement telling whenever is pressed show later color.
        if musicPlays.isPlaying {
            musicPlays.pause()
            sender.alpha = 0.2
        } else {
            musicPlays.play()
            sender.alpha = 1.0
        }
        
    }
    //disappearing keyboard when done editing
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if SearchBar.text == nil || SearchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            // dollar sign zero any of all objects in pokemen array
            // its a placeholder for each item in the array
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            // repopluating the data with filterdata.
            collection.reloadData()
        }
        
    }
    // peparing the segue between to views
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                    }
                }
            }
        }
    
    }

    
    


