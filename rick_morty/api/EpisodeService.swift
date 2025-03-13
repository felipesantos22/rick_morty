//
//  EpisodeService.swift
//  rick_morty
//
//  Created by Felipe Santos on 10/03/25.
//

import Foundation
import Alamofire

class EpisodeService {
    func fetchEpisodes(completion: @escaping ([Episode]?) -> Void) {
        let url = "https://rickandmortyapi.com/api/episode"
        
        AF.request(url).responseDecodable(of: EpisodeResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.results)
            case .failure(let error):
                print("Erro ao buscar personagens: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}

