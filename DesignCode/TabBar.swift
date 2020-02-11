//
//  TabBar.swift
//  DesignCode
//
//  Created by Christian Ruiz on 2/10/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            
            ContentView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                
                Text("Certificates")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group { //can preview on multiple devices
            TabBar().previewDevice("iPhone 8")
            TabBar().previewDevice("iPhone 11 Pro")
        }
    }
}
