//
//  LocationService.swift
//  rick_morty
//
//  Created by Felipe Santos on 10/03/25.
//

import Foundation
import Alamofire

class LocationService {
    
    private var nextPageURL: String? = "https://rickandmortyapi.com/api/location"
    var isFetchingNextPage: Bool = false
    
    func fetchLocations(completion: @escaping ([Location]?) -> Void) {
        
        guard let url = nextPageURL, !isFetchingNextPage else { // Corrigido aqui
            return
        }
        isFetchingNextPage = true
        
        AF.request(url).responseDecodable(of: LocationResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.nextPageURL = data.info.next
                self.isFetchingNextPage = false // Liberar para próxima requisição
                completion(data.results)
            case .failure(let error):
                print("Erro ao buscar personagens: \(error.localizedDescription)")
                self.isFetchingNextPage = false // Garantir que requisições futuras sejam permitidas
                completion(nil)
            }
        }
    }
    
}
