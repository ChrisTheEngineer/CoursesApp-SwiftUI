//
//  UpdateStore.swift
//  DesignCode
//
//  Created by Christian Ruiz on 2/10/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject { //storage object to update dynamic list data
    @Published var updates: [Update] = updateData
}
