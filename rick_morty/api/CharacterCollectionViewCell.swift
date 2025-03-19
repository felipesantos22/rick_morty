//
//  CharacterCollectionViewCell.swift
//  rick_morty
//
//  Created by Felipe Santos on 17/03/25.
//

import UIKit
import SDWebImage

class CharacterCollectionViewCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        //view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        //view.layer.shadowOffset = CGSize(width: 2, height: 2)
        //view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private let labelStatus: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(label)
        containerView.addSubview(labelStatus)
        containerView.addSubview(speciesLabel)
        configureCellCharacter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellCharacter() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Container ocupando toda a célula
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20), // Ajuste aqui
            containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20), // Ajuste aqui
            
            // Imagem no topo
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.60), // 60% da altura
            
            // Label abaixo da imagem
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            labelStatus.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
            labelStatus.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            labelStatus.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            speciesLabel.topAnchor.constraint(equalTo: labelStatus.bottomAnchor, constant: 15),
            speciesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            speciesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            speciesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15)
            
        ])
    }
    
    func configure(with character: Character) {
        label.text = character.name
        
        labelStatus.text = character.status
        
        labelStatus.textColor = character.status == "Alive" ? .blue : .red
        
        speciesLabel.text = character.species
        
        imageView.sd_setImage(with: URL(string: character.image), completed: nil)
    }
}
