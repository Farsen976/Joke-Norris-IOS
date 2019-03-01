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
    
    func getImageFacts(page: Int?, completion: @escaping ([Fact]?, Error?) -> ()) {
        return self.getFacts(type: "img", page: page!, completion: completion)
    }
    
    func getTextesFacts(page: Int?, completion: @escaping ([Fact]?, Error?) -> ()) {
        return self.getFacts(type: "txt", page: page!, completion: completion)
    }
    
    private func getFacts(type: String, page: Int = 1, completion: @escaping ([Fact]?, Error?) -> ()) {
        let params: String = "data=type:\(type);page:\(page)"
        let request: String = endPoint + params
        
        let session = URLSession.shared
        let task = session.dataTask(with: URL(string: request)!) {(data, URLResponse, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard var facts = try? jsonDecoder.decode([Fact].self, from: data) else {
                completion(nil, error)
                return
            }
            
            for (index, element) in facts.enumerated() {
                facts[index].fact = element.fact.html2String
                facts[index].rating = element.points.toDouble / element.vote.toDouble
                
                let contains = self.facts.contains(where: { (fact) -> Bool in
                    return fact.id == element.id
                })
                
                if(!contains) {self.facts.append(facts[index])}
            }
            
            completion(facts, error)
        }
        
        task.resume()
        
    }
    
}
