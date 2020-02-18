//
//  Data.swift
//  DesignCode
//
//  Created by Christian Ruiz on 2/17/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI

struct Post: Codable, Identifiable {
    let id = UUID()
    var title: String
    var body: String
}

class Api {
    func getPosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in //_ means not used, can add ! after url to mean that it will not be empty, but using guard is better
            guard let data = data else { return }
            
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            
            DispatchQueue.main.async { //run async
                completion(posts)
            }
        }
    .resume()
    }
}
