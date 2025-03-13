//
//  EpisodeService.swift
//  rick_morty
//
//  Created by Felipe Santos on 10/03/25.
//

import Foundation
import Alamofire

//class EpisodeService {
//    func fetchEpisodes(completion: @escaping ([Episode]?) -> Void) {
//        let url = "https://rickandmortyapi.com/api/episode"
//        
//        AF.request(url).responseDecodable(of: EpisodeResponse.self) { response in
//            switch response.result {
//            case .success(let data):
//                completion(data.results)
//            case .failure(let error):
//                print("Erro ao buscar personagens: \(error.localizedDescription)")
//                completion(nil)
//            }
//        }
//    }
//}

class EpisodeService {
    private var nextPageURL: String? = "https://rickandmortyapi.com/api/episode"
    var isFetchingNextPage: Bool = false
    
    func fetchService(completion: @escaping ([Episode]?) -> Void) {
        guard let url = nextPageURL, !isFetchingNextPage else { // Corrigido aqui
            return
        }
        isFetchingNextPage = true
        
        AF.request(url).responseDecodable(of: EpisodeResponse.self) { response in
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

