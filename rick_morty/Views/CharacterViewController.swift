//
//  CharacterViewController.swift
//  rick_morty
//
//  Created by Felipe Santos on 07/03/25.
//


import UIKit

class CharacterViewController: UITableViewController {
    
    private var characters: [Character] = []
    private let characterService = CharacterService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Personagens"
        view.backgroundColor = .white
        setupTableView()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCharacters()
    }
    
    private func setupTableView() {
        tableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
    }
    
    
    /// Método responsável por buscar os personagens da API e atualizar a tabela com novos dados
    private func fetchCharacters() {
        // Chama o serviço para buscar novos personagens
        characterService.fetchCharacters { [weak self] newCharacters in
            // Garante que `self` ainda está na memória e que os novos personagens não são nulos
            guard let self = self, let newCharacters = newCharacters else { return }
            
            // Atualiza a interface na thread principal
            DispatchQueue.main.async {
                // Obtém o índice do primeiro novo personagem a ser adicionado
                let startIndex = self.characters.count
                // Obtém o índice do último novo personagem a ser adicionado
                let endIndex = startIndex + newCharacters.count - 1
                // Cria uma lista de `IndexPath` para os novos itens
                let indexPaths = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
                
                // Adiciona os novos personagens ao array existente
                self.characters.append(contentsOf: newCharacters)
                
                // Atualiza a tabela, inserindo apenas as novas células
                self.tableView.insertRows(at: indexPaths, with: .automatic)
            }
        }
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return characters.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else {
            return UITableViewCell()
        }
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }*/
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIndex = characters.count - 1
        if indexPath.row == lastItemIndex { // Se chegou ao fim da lista
            fetchCharacters()
        }
    }
    
}
