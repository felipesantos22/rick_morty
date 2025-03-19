//
//  CharacterDetails.swift
//  rick_morty
//
//  Created by Felipe Santos on 17/03/25.
//

import UIKit

class CharacterDetails: UIViewController {
    
    let character: Character?
    
    private let characterLabel = UILabel()
    
    init(character: Character?) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(characterLabel)
        
        if let character = character {
            characterLabel.text = character.name
        }
        
        detasilsCharacter()
    }
    
    func detasilsCharacter() {
        characterLabel.font = UIFont.boldSystemFont(ofSize: 20)
        characterLabel.textColor = .black
        characterLabel.textAlignment = .center
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            characterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
