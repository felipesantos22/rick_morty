//
//  ViewController.swift
//  rick_morty
//
//  Created by Felipe Santos on 08/03/25.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TabBar()
        // Do any additional setup after loading the view.
    }
    
    func TabBar(){
        // Criando os ViewControllers
        let characterViewController = CharacterViewController()
        let episodeViewController = EpisodeViewController()
        let locationViewController = LocationViewController()
        let characterCollectionViewController = CharacterCollectionViewController()
        
        // Definindo os itens de TabBar
        characterViewController.tabBarItem = UITabBarItem(
            title: "Personagens",
            image: UIImage(systemName: "person.fill"), // Ícone do TabBar
            tag: 0
        )
        
        episodeViewController.tabBarItem = UITabBarItem(
            title: "Episodios",
            image: UIImage(systemName: "play.fill"), // Ícone do TabBar
            tag: 1
        )
        
        locationViewController.tabBarItem = UITabBarItem(
            title: "Localidades",
            image: UIImage(systemName: "map.fill"), // Ícone do TabBar
            tag: 2
        )
        
        characterCollectionViewController.tabBarItem = UITabBarItem(
            title: "Collection",
            image: UIImage(systemName: "person.fill"), 
            tag: 3
        )
        
        // Criando os UINavigationControllers para cada ViewController
        let characterNavController = UINavigationController(rootViewController: characterViewController)
        let episodeNavController = UINavigationController(rootViewController: episodeViewController)
        let locationNavController = UINavigationController(rootViewController: locationViewController)
        let characterCollectionNavController = UINavigationController(rootViewController: characterCollectionViewController)
        
        
        // Adicionando os ViewControllers ao TabBar
        self.viewControllers = [characterNavController, episodeNavController, locationNavController, characterCollectionNavController]
        
        // Customizando a aparência do TabBar
        tabBar.tintColor = .blue // Cor do ícone ativo
        tabBar.isTranslucent = false  // Torna o TabBar opaco (não translúcido)
    }
    
}
