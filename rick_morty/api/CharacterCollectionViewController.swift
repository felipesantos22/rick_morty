//
//  CharacterCollectionViewController.swift
//  rick_morty
//
//  Created by Felipe Santos on 17/03/25.
//

import UIKit

class CharacterCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "Cell"
    private var characters: [Character] = []
    private var characterService = CharacterService()
    
    // Criar um layout antes de inicializar a CollectionView
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 280)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    // Adicionando um inicializador para a CollectionViewController com layout
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout()) // Inicializar corretamente
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        
        // Definir o layout antes de usar a collectionView
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCharacters()
    }
    
    //    private func fetchCharacters() {
    //        characterService.fetchCharacters { [weak self] characters in
    //            guard let self = self, let characters = characters else {
    //                print("Erro ao carregar personagens")
    //                return
    //            }
    //            DispatchQueue.main.async {
    //                print("Personagens carregados:", characters) // Verifique os dados recebidos
    //                self.characters = characters
    //                self.collectionView.reloadData()
    //            }
    //        }
    //    }
    
    private func fetchCharacters() {
        // Chama o serviço para buscar novos personagens
        characterService.fetchCharacters { [weak self] newCharacters in
            // Garante que `self` ainda está na memória e que os novos personagens não são nulos
            guard let self = self, let newCharacters = newCharacters, !newCharacters.isEmpty else { return }
            
            // Atualiza a interface na thread principal
            DispatchQueue.main.async {
                let startIndex = self.characters.count
                let endIndex = startIndex + newCharacters.count - 1
                let indexPaths = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
                
                // Adiciona os novos personagens ao array existente
                self.characters.append(contentsOf: newCharacters)
                
                // Usa `insertItems` para um update mais eficiente
                self.collectionView.performBatchUpdates({
                    self.collectionView.insertItems(at: indexPaths)
                }, completion: nil)
            }
        }
    }
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let character = characters[indexPath.item]
        cell.configure(with: character)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItemIndex = characters.count - 1
        if indexPath.item == lastItemIndex { // Se chegou ao fim da lista
            fetchCharacters()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectCharacter = characters[indexPath.item]
        let characterDetailViewController = CharacterDetails(character: selectCharacter)
        navigationController?.pushViewController(characterDetailViewController, animated: true)
    }
    
    
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: 150, height: 200) // Defina o tamanho desejado
    //    }
    
    
    
}

