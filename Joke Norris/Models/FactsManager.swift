//
//  FactsManager.swift
//  Joke Norris
//
//  Created by Developer on 10/02/2019.
//  Copyright © 2019 Farsen. All rights reserved.
//

import Foundation

class FactsManager: Decodable {
    var facts: Array<Fact>
    let endPoint: String = "https://www.chucknorrisfacts.fr/api/get?"
    
    init(){
        self.facts = []
    }
    
    func getImageFacts(completion: @escaping ([Fact]?, Error?)->()) {
        let params: String = "data=type:img"
        let request: String = endPoint + params
        
        let session = URLSession.shared
        let task = session.dataTask(with: URL(string: request)!) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let imgFacts = try? jsonDecoder.decode([Fact].self, from: data) else {
                completion(nil, error)
                return
            }
            
            self.facts = imgFacts
            
            completion(imgFacts, error)
        }
        
        task.resume()
    }
    
    func getTextesFacts(page: Int = 1, completion: @escaping ([Fact]?, Error?) -> ()) {
        let params: String = "data=type:txt;page:\(page)"
        let request: String = endPoint + params
        
        let session = URLSession.shared
        let task = session.dataTask(with: URL(string: request)!) {(data, URLResponse, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard var txtFacts = try? jsonDecoder.decode([Fact].self, from: data) else {
                completion(nil, error)
                return
            }
            
            for (index, element) in txtFacts.enumerated() {
                txtFacts[index].fact = element.fact.html2String
                txtFacts[index].rating = element.points.toDouble / element.vote.toDouble
                
                let contains = self.facts.contains(where: { (fact) -> Bool in
                    return fact.id == element.id
                })
                
                if(!contains) {self.facts.append(txtFacts[index])}
            }
            
            completion(txtFacts, error)
        }
        
        task.resume()
        
    }
    
}
