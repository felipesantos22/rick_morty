//
//  EpisodeCell.swift
//  rick_morty
//
//  Created by Felipe Santos on 10/03/25.
//

import UIKit
import SDWebImage

class EpisodeCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let createdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
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
        addSubview(nameLabel)
        addSubview(episodeLabel)
        addSubview(createdLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Ajuste correto do nameLabel
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10),
            
            // Ajuste correto do episodeLabel
            episodeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            episodeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            episodeLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10),
            
            // Ajuste correto do createdLabel
            createdLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            createdLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 5),
            createdLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10)
        ])
    }

    
    
    
    func configure(with episode: Episode) {
        nameLabel.text = episode.name
        episodeLabel.text = episode.episode
        createdLabel.text = episode.created
    }
}
