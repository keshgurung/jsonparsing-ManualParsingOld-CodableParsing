//
//  NetworkManager.swift
//  CodableParsing
//
//  Created by Kesh Gurung on 14/07/2022.
//

import Foundation


class NetworkManager {

    func getPokemonDecodable() -> Pokemon? {
    
        guard let path = Bundle.main.path(forResource: "Dragon", ofType: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            return pokemon
        } catch {
            print(error)
        }
        
        return nil
    }
}
