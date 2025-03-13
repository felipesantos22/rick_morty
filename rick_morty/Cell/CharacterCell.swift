//
//  CharacterCell.swift
//  rick_morty
//
//  Created by Felipe Santos on 07/03/25.
//

import UIKit
import SDWebImage

class CharacterCell: UITableViewCell {
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupView() {
        addSubview(characterImageView)
        addSubview(nameLabel)
        addSubview(speciesLabel)
        addSubview(statusLabel)
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Configuração da imagem do personagem
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            characterImageView.centerYAnchor.constraint(equalTo: centerYAnchor), // Centraliza verticalmente
            characterImageView.widthAnchor.constraint(equalToConstant: 90),
            characterImageView.heightAnchor.constraint(equalToConstant: 90),
            
            // Configuração do nome do personagem
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10), // Posiciona no topo
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10),
            
            // Configuração da espécie do personagem (abaixo do nome)
            speciesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5), // Agora está abaixo do nome
            speciesLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10),
            
            // Configuração do status do personagem (abaixo da espécie)
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 5), // AGORA está abaixo da espécie
            statusLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10)
        ])
    }
    
    
    
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        statusLabel.text = character.status
        
        if character.status == "Alive" {
            statusLabel.textColor = .blue
        } else {
            statusLabel.textColor = .red
        }
        
        characterImageView.sd_setImage(with: URL(string: character.image), completed: nil)
    }
}
