//
//  Dragon.swift
//  CodableParsing
//
//  Created by Kesh Gurung on 14/07/2022.
//


import Foundation

struct Pokemon: Decodable {
    
    let damageRelations : DamageRelations
    let gameIndices : [gameIndices]
    let generation: NameLink
    let id: Int
    let moveDamageClass : NameLink
    let moves: [NameLink]
    let name: String
    let pokemon : [pokemon]
}


struct NameLink : Decodable {
    let name: String
    let url: String
}

struct DamageRelations :  Decodable {
 
//    without using enum - if used it should be for all prop inside it.
    let doubleDamageFrom : [NameLink]
    let doubleDamageTo : [NameLink]
    let halfDamageFrom : [NameLink]
    let halfDamageTo : [NameLink]
    let noDamageFrom : [String?]
    let noDamageTo : [NameLink]

    
//    let damage : [NameLink]
//    let doubleTo : [NameLink]
//    let halfDamage : [NameLink]
//    let halfTo : [NameLink]
//    let noDamage : [String?]
//    let noTo : [NameLink]

//    enum CodingKeys: String, CodingKey {
//            case damage =  "double_damage_from"
//            case doubleTo = "double_damage_to"
//            case halfDamage = "half_damage_from"
//            case halfTo = "half_damage_to"
//            case noDamage = "no_damage_from"
//            case noTo = "no_damage_to"
//        }
}
    
struct gameIndices : Decodable {
    let gameIndex: Int
    let generation : NameLink
}

struct pokemon: Decodable {
    let pokemon: NameLink
    let slot: Int
}
