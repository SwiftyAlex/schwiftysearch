//
//  EpisodeRequest.swift
//  Schwifty Search
//
//  Created by Alex Logan on 22/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation
import CoreData

class EpisodeRequest: BaseRequest {
    typealias EpisodeArrayCompletion =  ([Episode]?, Error?) -> ()
    
    let url = "https://rickandmortyapi.com/api/episode/"
    
    func fetchEpisodes(completion: @escaping EpisodeArrayCompletion){
        self.GET(url: url, params: [:], object: ModelRequest<Episode>.self, completion: { data, error in
            if error != nil {
                completion(Episode.storedObjects(), error)
            } else {
                try! Episode.context.save()
                return completion(Episode.storedObjects(), nil )
            }
        })
    }
}
