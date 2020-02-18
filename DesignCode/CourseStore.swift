//
//  CourseStore.swift
//  DesignCode
//
//  Created by Christian Ruiz on 2/17/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI
import Contentful //we installed 3rd party lib

let client = Client(spaceId: "bbm1bkvzj1sy", accessToken: "C6AKhmga7Fr3ym58VFs-hBh_StoMY0OPLuXuWhJouoM")

func getArray() {
    let query = Query.where(contentTypeId: "course")
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        print(result)
    }
}
