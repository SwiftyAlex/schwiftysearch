//
//  CharacterRequest.swift
//  Schwifty Search
//
//  Created by Alex Logan on 22/01/2019.
//  Copyright © 2019 Alex Logan. All rights reserved.
//

import Foundation
import CoreData

class CharacterRequest: BaseRequest {
    typealias CharacterArrayCompletion =  ([Character]?, Error?) -> ()
    
    let url = "https://rickandmortyapi.com/api/character/"
    
    func fetchCharacters(completion: @escaping CharacterArrayCompletion){
        self.GET(url: url, params: [:], object: ModelRequest<Character>.self, completion: { data, error in
            if error != nil {
                completion(Character.storedObjects(), error)
            } else {
                try! Context.context.save()
                return completion(Character.storedObjects(), nil )
            }
        })
    }
}
