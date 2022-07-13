//
//  NetworkManager.swift
//  Demojson
//
//  Created by Kesh Gurung on 12/07/2022.
//

import Foundation

class NetworkManager {
    
    
    func getPokemonManually() -> Pokemon? {
        print("here")
        guard let path = Bundle.main.path(forResource: "Dragon", ofType: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            guard let baseDict = jsonObj as? [String: Any] else { return nil }
            return parsePokemonManually(base: baseDict)
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parsePokemonManually(base: [String: Any]) -> Pokemon? {
        print("here")
        guard let damageDict = base["damage_relations"] as? [String: Any] else { return nil }
       
        guard let damageArr1 = base["double_damage_from"] as? [[String: Any]] else { return nil }
        var finalForms1: [NameLink] = []
        damageArr1.forEach { value in
            guard let form = self.createNameLink(dict: value) else { return }
            finalForms1.append(form)
        }
        let double_damage_form = damageDict["finalForms1"]
        
        guard let damageArr2 = base["double_damage_to"] as? [[String: Any]] else { return nil }
        var finalForms2: [NameLink] = []
        damageArr2.forEach { value in
            guard let form = self.createNameLink(dict: value) else { return }
            finalForms2.append(form)
        }
        let double_damage_to = damageDict["finalForms2"]
        
        guard let damageArr3 = base["half_damage_from"] as? [[String: Any]] else { return nil }
        var finalForms3: [NameLink] = []
        damageArr3.forEach { value in
            guard let form = self.createNameLink(dict: value) else { return }
            finalForms3.append(form)
        }
        let half_damage_form = damageDict["finalForms3"]
        
        guard let damageArr4 = base["half_damage_to"] as? [[String: Any]] else { return nil }
        var finalForms4: [NameLink] = []
        damageArr4.forEach { value in
            guard let form = self.createNameLink(dict: value) else { return }
            finalForms4.append(form)
        }
        let half_damage_to = damageDict["finalForms4"]
        
        guard let damageArr5 = base["no_damage_form"] as? [[String: Any]] else { return nil }
        var finalForms5: [NameLink] = []
        damageArr5.forEach { value in
            guard let form = self.createNameLink(dict: value) else { return }
            finalForms5.append(form)
        }
        let no_damage_form = damageDict["finalForms5"]
        
        guard let damageArr6 = base["no_damage_to"] as? [[String: Any]] else { return nil }
        var finalForms6: [NameLink] = []
        damageArr6.forEach { value in
            guard let form = self.createNameLink(dict: value) else { return }
            finalForms6.append(form)
        }
        let no_damage_to = damageDict["finalForms6"]
        
        let damage = Damage(double_damage_form: double_damage_form as? [NameLink] , double_damage_to: double_damage_to as? [NameLink] , half_damage_from: half_damage_form as? [NameLink] , half_damage_to: half_damage_to as? [NameLink] , no_damage_from: no_damage_form as? [NameLink], no_damage_to: no_damage_to as? [NameLink] )
        
        
        print("first")

        guard let gameArr = base["game_indicies"] as? [[String: Any]] else { return nil }
        var finalGameIndicies: [GameInd] = []
        gameArr.forEach{ value in
            guard let game_index = value["game_index"] as? Int else { return }
            
            guard let typeDict = value["generation"] as? [String: Any] else { return }
            
            guard let typeNameLink = self.createNameLink(dict: typeDict) else { return }
            
            finalGameIndicies.append(GameInd(game_index: game_index, generation: typeNameLink))
         }
        
        guard let generationDict = base["generation"] as? [String: Any] else { return nil }
        guard let generation = self.createNameLink(dict: generationDict) else { return nil }
        
        
        guard let id = base["id"] as? Int else { return nil }
        
        guard let damageDict = base["move_damage_class"] as? [String: Any] else { return nil }
        guard let move_damage_class = self.createNameLink(dict: damageDict) else { return nil }
        
        
        guard let movesArr = base["moves"] as? [[String: Any]] else { return nil }
        var finalmoves: [NameLink] = []
        movesArr.forEach { value in
            guard let move = self.createNameLink(dict: value) else { return }
            finalmoves.append(move)
        }
        
        guard let name = base["name"] as? String else { return nil }
        
        guard let pokemonArr = base["pokemon"] as? [[String: Any]] else { return nil }
        
        // Abilities
        var finalAbilites: [Poke] = []
        pokemonArr.forEach { value in
            guard let pokeDict = value["pokemon"] as? [String: Any] else { return }
            guard let abilityRep = self.createNameLink(dict: pokeDict) else { return }
            guard let slot = value["slot"] as? Int else { return }
            finalAbilites.append(Poke(pokemon: abilityRep, slot: slot))
        }
        print("there")
        return Pokemon (damage_relations: damage, game_indicies: finalGameIndicies, generation: generation, id: id, move_damage_class: move_damage_class, moves: finalmoves, name: name, pokemon: finalAbilites)
        
       
    }
    
    private func createNameLink(dict: [String: Any]) -> NameLink? {
        guard let name = dict["name"] as? String else { return nil }
        guard let url = dict["url"] as? String else { return nil }
        return NameLink(name: name, url: url)
    }
}
