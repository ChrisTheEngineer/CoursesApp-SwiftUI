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
        VStack(spacing: 50) { //Neumorphic Buttons
            RectangleButton()
            
            CircleButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9121050239, green: 0.865039587, blue: 1, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}

struct RectangleButton: View {
    @State var tap = false
    @State var press = false //long press
    
    var body: some View {
        Text("Button")
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width:200, height: 60)
            .background(
                ZStack {
                    Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1)) //same as drop shadow
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous) //upper left brightness
                        .foregroundColor(Color(press ? #colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
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
            .overlay(
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(Color.white.opacity(press ? 0 : 1)) //toggles icon
                        .frame(width: press ? 64 :54, height: press ? 4 : 50) //turn into line
                        .background(Color(#colorLiteral(red: 0.6530441642, green: 0.3625520468, blue: 1, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 10, x: 10, y: 10)
                        .offset(x: press ? 70 : -10, y: press ? 16 : 0) //moves to middle
                    
                    Spacer()
                }
                
        )
            .shadow(color: Color(press ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color(press ? #colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
            .scaleEffect(tap ? 1.2 : 1)
            .gesture(
                LongPressGesture(minimumDuration: 0.5, maximumDistance: 10).onChanged { value in
                    self.tap = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { //timer
                        self.tap = false
                    }
                    
                }
                .onEnded { value in
                    self.press.toggle()
                }
        )
    }
}

struct CircleButton: View {
    @State var tap = false
    @State var press = false //long press
    
    var body: some View {
        ZStack {
            Image(systemName: "sun.max")
                .font(.system(size: 44, weight: .light))
                .offset(x: press ? -90 : 0, y: press ? -90 : 0)
                .rotation3DEffect(Angle(degrees: press ? 20 : 0), axis: (x: 10, y: -10, z: 0)) //rotates icon as if around a sphere
            
            Image(systemName: "moon")
                .font(.system(size: 44, weight: .light))
                .offset(x: press ? 0 : 90, y: press ? 0 : 90)
                .rotation3DEffect(Angle(degrees: press ? 0 : 20), axis: (x: -10, y: 10, z: 0))
        }
        .frame(width: 100, height: 100)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(press ? #colorLiteral(red: 0.9121050239, green: 0.865039587, blue: 1, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9121050239, green: 0.865039587, blue: 1, alpha: 1) )]), startPoint: .topLeading, endPoint: .bottomTrailing) //secondary color is lighter / more subtle than below shadow secondary colors
                
                Circle()
                    .stroke(Color.clear, lineWidth: 10) //creates a border that's clear
                    .shadow(color: Color(press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1)), radius: 3, x: -5, y: -5)
                
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(press ? #colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: 3, y: 3)
            }
        )
            .clipShape(Circle())
            .shadow(color: Color(press ? #colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
            .shadow(color: Color(press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1)), radius: 20, x: 20, y: 20)
            .scaleEffect(tap ? 1.2 : 1)
            .gesture(
                    LongPressGesture(minimumDuration: 0.5, maximumDistance: 10).onChanged { value in
                        self.tap = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { //timer
                            self.tap = false
                        }
                        
                    }
                    .onEnded { value in
                        self.press.toggle()
                    }
            )
    }
}
