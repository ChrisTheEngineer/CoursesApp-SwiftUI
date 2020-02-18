//
//  DataStore.swift
//  DesignCode
//
//  Created by Christian Ruiz on 2/17/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
