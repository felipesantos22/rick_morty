//
//  EpisodeDetails.swift
//  rick_morty
//
//  Created by Felipe Santos on 17/03/25.
//

import UIKit

class EpisodeDetails: UIViewController {
    
    let episode: Episode?
    
    private let episodeLabel = UILabel()
    
    init(episode: Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode Details"
        view.backgroundColor = .white
        view.addSubview(episodeLabel)
        configure()
    }
    
    func configure() {
        guard let episode = episode else { return }
        episodeLabel.text = "\(episode.name)\n\(episode.created)"
        episodeLabel.numberOfLines = 0
        episodeLabel.textColor = .black
        episodeLabel.textAlignment = .center
        episodeLabel.font = .systemFont(ofSize: 20, weight: .bold)
        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            episodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            episodeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
