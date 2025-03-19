//
//  EpisodeViewController.swift
//  rick_morty
//
//  Created by Felipe Santos on 08/03/25.
//

import UIKit

class EpisodeViewController: UITableViewController {
    
    private var episodes: [Episode] = []
    private let episodeService = EpisodeService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        title = "Episódios"
        view.backgroundColor = .white
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: "EpisodeCell")
        setupTableView()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchEpisodes()
    }
    
    private func setupTableView() {
        // Criando um container para o UITextField
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        // Criando o UITextField
        let searchTextField = UITextField()
        searchTextField.placeholder = "Buscar..."
        searchTextField.borderStyle = .roundedRect
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Adicionando o UITextField ao container
        titleView.addSubview(searchTextField)
        
        // Aplicando constraints ao UITextField
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -8),
            searchTextField.topAnchor.constraint(equalTo: titleView.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 30) // Altura fixa para o input
        ])
        
        // Definindo a largura do titleView para se ajustar à Navigation Bar
        titleView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        // Definindo titleView na Navigation Bar
        navigationItem.titleView = titleView
    }
    
    //    private func fetchEpisodes() {
    //        episodeService.fetchEpisodes { [weak self] episodes in
    //            guard let self = self, let episodes = episodes else { return }
    //            DispatchQueue.main.async {
    //                self.episodes = episodes
    //                self.tableView.reloadData()
    //            }
    //        }
    //    }
    
    /// Método responsável por buscar os personagens da API e atualizar a tabela com novos dados
    private func fetchEpisodes() {
        // Chama o serviço para buscar novos episodios
        episodeService.fetchService { [weak self] newEpisodes in
            // Garante que `self` ainda está na memória e que os novos episodios não são nulos
            guard let self = self, let newEpisodes = newEpisodes else { return }
            
            // Atualiza a interface na thread principal
            DispatchQueue.main.async {
                // Obtém o índice do primeiro novo personagem a ser adicionado
                let startIndex = self.episodes.count
                // Obtém o índice do último novo episodio a ser adicionado
                let endIndex = startIndex + newEpisodes.count - 1
                // Cria uma lista de `IndexPath` para os novos itens
                let indexPaths = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
                
                // Adiciona os novos episodios ao array existente
                self.episodes.append(contentsOf: newEpisodes)
                
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
        return episodes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as? EpisodeCell else {
            return UITableViewCell()
        }
        let episode = episodes[indexPath.row]
        cell.backgroundColor = .clear
        cell.configure(with: episode)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIndex = episodes.count - 1
        if indexPath.row == lastItemIndex { // Se chegou ao fim da lista
            fetchEpisodes()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectEpisode = episodes[indexPath.row]
        let episodeDetails = EpisodeDetails(episode: selectEpisode)
        navigationController?.pushViewController(episodeDetails, animated: true)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
