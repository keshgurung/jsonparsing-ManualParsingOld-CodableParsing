//
//  NetworkManager.swift
//  Demojson
//
//  Created by Kesh Gurung on 12/07/2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    
    func getPokemonManually() -> Pokemon? {
       
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
        
        // last one pokemon

        guard let pokemonArr = base["pokemon"] as? [[String: Any]] else { return nil }
        var finalAbilites: [Poke] = []
        pokemonArr.forEach { value in
            guard let pokeDict = value["pokemon"] as? [String: Any] else { return }
            guard let abilityRep = self.createNameLink(dict: pokeDict) else { return }
            guard let slot = value["slot"] as? Int else { return }
            finalAbilites.append(Poke(pokemon: abilityRep, slot: slot))
        }
      
        
         guard let gameArr = base["game_indices"] as? [[String: Any]] else { return nil }
         var finalGameIndicies: [GameInd] = []
         gameArr.forEach { value in
             guard let game_index = value["game_index"] as? Int else { return }
             guard let poDict = value["generation"] as? [String: Any] else { return }
             guard let pokeRep = self.createNameLink(dict: poDict) else { return }

             finalGameIndicies.append(GameInd(game_index: game_index, generation: pokeRep))
          }


        guard let damageDict = base["damage_relations"] as? [String: Any] else { return nil }

        guard let damageArr1 = damageDict["double_damage_from"] as? [[String: Any]] else { return nil }
        var finalForms1: [NameLink] = []
        damageArr1.forEach { value in
            guard let form1 = self.createNameLink(dict: value) else { return }
            finalForms1.append(form1)
        }
      


        guard let damageArr2 = damageDict["double_damage_to"] as? [[String: Any]] else { return nil }
        var finalForms2: [NameLink] = []
        damageArr2.forEach { value in
            guard let form2 = self.createNameLink(dict: value) else { return }
            finalForms2.append(form2)
        }
       
 


        guard let damageArr3 = damageDict["half_damage_from"] as? [[String: Any]] else { return nil }
        var finalForms3: [NameLink] = []
        damageArr3.forEach { value in
            guard let form3 = self.createNameLink(dict: value) else { return }
            finalForms3.append(form3)
        }
        

        guard let damageArr4 = damageDict["half_damage_to"] as? [[String: Any]] else { return nil }
        var finalForms4: [NameLink] = []
        damageArr4.forEach { value in
            guard let form4 = self.createNameLink(dict: value) else { return }
            finalForms4.append(form4)
        }
       
       
        guard let damageArr5 = damageDict["no_damage_from"] as? [Any] else { return nil }
        var finalForms5: [Any] = []
        damageArr5.forEach { val in
            finalForms5.append(val)
        }
    
       


        guard let damageArr6 = damageDict["no_damage_to"] as? [[String: Any]] else { return nil }
        var finalForms6: [NameLink] = []
        damageArr6.forEach { value in
            guard let form6 = self.createNameLink(dict: value) else { return }
            finalForms6.append(form6)
        }
       
        
        
        let damage = Damage(double_damage_form: finalForms1 , double_damage_to: finalForms2, half_damage_from: finalForms3 , half_damage_to: finalForms4, no_damage_from: finalForms5 , no_damage_to: finalForms6 )

       
        
        return Pokemon ( damage_relations: damage, game_indicies: finalGameIndicies, generation: generation, id: id, move_damage_class: move_damage_class, moves: finalmoves, name: name, pokemon: finalAbilites)
        
       
    }
    
    private func createNameLink(dict: [String: Any]) -> NameLink? {
        guard let name = dict["name"] as? String else { return nil }
        guard let url = dict["url"] as? String else { return nil }
        return NameLink(name: name, url: url)
    }
}
