//
//  LocationViewController.swift
//  rick_morty
//
//  Created by Felipe Santos on 08/03/25.
//

import UIKit

class LocationViewController: UITableViewController {
    
    private var locations: [Location] = []
    private let locationService = LocationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Planetas"
        view.backgroundColor = .white
        setupTableView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLocation()
    }
    
    private func setupTableView() {
        tableView.register(LocationCell.self, forCellReuseIdentifier: "LocationCell")
    }
    
    
    //    private func fetchLocation() {
    //        locationService.fetchLocations { [weak self] locations in
    //            guard let self = self, let locations = locations else { return }
    //            DispatchQueue.main.async {
    //                self.locations = locations
    //                self.tableView.reloadData()
    //            }
    //        }
    //    }
    
    /// Método responsável por buscar os personagens da API e atualizar a tabela com novos dados
    private func fetchLocation() {
        // Chama o serviço para buscar novos personagens
        locationService.fetchLocations { [weak self] newLocations in
            // Garante que `self` ainda está na memória e que os novos personagens não são nulos
            guard let self = self, let newLocations = newLocations else { return }
            
            // Atualiza a interface na thread principal
            DispatchQueue.main.async {
                // Obtém o índice do primeiro novo personagem a ser adicionado
                let startIndex = self.locations.count
                // Obtém o índice do último novo personagem a ser adicionado
                let endIndex = startIndex + newLocations.count - 1
                // Cria uma lista de `IndexPath` para os novos itens
                let indexPaths = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
                
                // Adiciona os novos personagens ao array existente
                self.locations.append(contentsOf: newLocations)
                
                // Atualiza a tabela, inserindo apenas as novas células
                self.tableView.insertRows(at: indexPaths, with: .automatic)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as? LocationCell else {
            return UITableViewCell()
        }
        let location = locations[indexPath.row]
        cell.backgroundColor = .clear
        //cell.separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        cell.configure(with: location)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIndex = locations.count - 1
        if indexPath.row == lastItemIndex { // Se chegou ao fim da lista
            fetchLocation()
        }
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
