//
//  FetchService.swift
//  AcronymApp
//
//  Created by Sohel Bukhari on 10/17/21.
//

import Foundation

class FetchService {
    
    func fetchData (sf: String, completion: @escaping (Bool, Forms?, String?) -> ()) {
        var urlString = "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf="
        urlString = urlString+sf
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode([Forms].self, from: data)
                        if model.count > 0 {
                            completion(true, model[0], nil)
                        } else {
                            completion(false, nil, "No Results for acronym - \(sf)")
                        }
                    } catch {
                        print("\(error)")
                        completion(false, nil, "Error: Trying to parse model")
                    }
                }
            }.resume()
        }        
    }
}
