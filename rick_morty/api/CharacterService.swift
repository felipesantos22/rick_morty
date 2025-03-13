//
//  CharacterService.swift
//  rick_morty
//
//  Created by Felipe Santos on 07/03/25.
//

import Foundation
import Alamofire

class CharacterService {
    private var nextPageURL: String? = "https://rickandmortyapi.com/api/character"
    var isFetchingNextPage: Bool = false
    func fetchCharacters(completion: @escaping ([Character]?) -> Void) {
        guard let url = nextPageURL, !isFetchingNextPage else { // Corrigido aqui
            return
        }
        isFetchingNextPage = true
        
        AF.request(url).responseDecodable(of: CharacterResponse.self) { response in
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
