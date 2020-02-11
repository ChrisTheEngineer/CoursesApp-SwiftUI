//
//  UpdateDetail.swift
//  DesignCode
//
//  Created by Christian Ruiz on 2/10/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    var update: Update = updateData[1]
    
    var body: some View {
        List { //can also use a ScrollView
            VStack {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitle(update.title)
        } //not visible in preview, dependent on nav view wrapper
            .listStyle(PlainListStyle())
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
