//
//  Dragon.swift
//  Demojson
//
//  Created by Kesh Gurung on 12/07/2022.
//

import Foundation

struct Pokemon {
    
    let damage_relations : Damage
    let game_indicies : [ GameInd ]
    let generation: NameLink
    let id: Int
    let move_damage_class : NameLink
    let moves: [NameLink]
    let name: String
    let pokemon : [ Poke ]
}


struct NameLink {
    let name: String
    let url: String
}

struct Damage {
 
    let double_damage_form : [ NameLink]?
    let double_damage_to : [NameLink]?
    let half_damage_from : [NameLink]?
    let half_damage_to : [NameLink]?
    let no_damage_from : [NameLink]?
    let no_damage_to : [NameLink]?
    
}
    
struct GameInd {
    let game_index: Int
    let generation : NameLink
}

struct Poke {
    let pokemon: NameLink
    let slot: Int
}

