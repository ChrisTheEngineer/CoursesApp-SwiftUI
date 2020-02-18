//
//  CourseStore.swift
//  DesignCode
//
//  Created by Christian Ruiz on 2/17/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI
import Contentful //we installed 3rd party lib
import Combine

let client = Client(spaceId: "bbm1bkvzj1sy", accessToken: "C6AKhmga7Fr3ym58VFs-hBh_StoMY0OPLuXuWhJouoM")

func getArray(id: String, completion: @escaping([Entry]) -> ()) { //Entry is data model for Contentful
    let query = Query.where(contentTypeId: "course")
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            } 
        case .error(let error):
            print(error)
        }
    }
}

class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
    
    init() {
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                self.courses.append(Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subtitle"] as! String,
                    image: #imageLiteral(resourceName: "Background1"),
                    logo: #imageLiteral(resourceName: "Logo1"),
                    color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
                    show: false)
                )
            }
        }
    }
}
