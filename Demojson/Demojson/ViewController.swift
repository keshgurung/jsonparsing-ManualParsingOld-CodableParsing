//
//  ViewController.swift
//  JsonDemo
//
//  Created by Kesh Gurung on 12/07/2022.
//

import UIKit

class ViewController: UIViewController {

    lazy var manualDecodeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Click Here", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15.0
        button.addTarget(self, action: #selector(self.manualDecodeButtonPressed), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()
    
    
    let network = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.manualDecodeButton)
        self.manualDecodeButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.manualDecodeButton.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.manualDecodeButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.manualDecodeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    }
    
    @objc
    func manualDecodeButtonPressed() {
       

        let pokemon = self.network.getPokemonManually()
        self.presentPokemonAlert(pokemon: pokemon)
    }
    
    func presentPokemonAlert(pokemon: Pokemon?) {
        
        guard let pokemon = pokemon else { return }

        let moves = pokemon.pokemon.compactMap { $0.pokemon.name }.reduce("") { partialResult, move in
            return partialResult + move + "\n"
        }
        print(moves)
        let alert = UIAlertController(title: pokemon.name, message: moves, preferredStyle: .alert)
        let action = UIAlertAction(title: "Sounds Good", style: .default, handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }

    }

    
}



