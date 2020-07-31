//
//  PryanikiManager.swift
//  Pryaniki
//
//  Created by Nikola on 14/07/2020.
//  Copyright © 2020 Nikola Krstevski. All rights reserved.


import Foundation

class NetworkPryanikiManager {
    
    func fetchData(completion: @escaping (PryanikiData) -> Void)  {
        let urlString = "https://pryaniky.com/static/json/sample.json"
        guard  let url = URL(string: urlString) else { print("Error, line 16"); return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                let data = data,
                let pryaniki = self.parseJSON(data) else { return }
            completion(pryaniki)
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> PryanikiData? {
        let decoder = JSONDecoder()
        do {
            let pryanikiData = try decoder.decode(PryanikiData.self, from: data)
            return pryanikiData
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
        }
        return nil
    }
}
