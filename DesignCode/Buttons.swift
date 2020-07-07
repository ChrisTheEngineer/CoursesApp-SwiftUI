//
//  Buttons.swift
//  DesignCode
//
//  Created by Christian Ruiz on 7/7/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        VStack { //Neumorphic Buttons
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width:200, height: 60)
                .background(
                    ZStack {
                        Color(#colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1)) //same as drop shadow
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous) //upper left brightness
                            .foregroundColor(.white)
                            .blur(radius:4)
                            .offset(x:-8, y:-8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous) //foreground color
                            //.foregroundColor(Color(#colorLiteral(red: 0.9121050239, green: 0.865039587, blue: 1, alpha: 1))) //same as overall background
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9121050239, green: 0.865039587, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                            .padding(2)
                            .blur(radius:2)
                    }
            )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1)), radius: 20, x: 20, y: 20)
                .shadow(color: Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9121050239, green: 0.865039587, blue: 1, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
