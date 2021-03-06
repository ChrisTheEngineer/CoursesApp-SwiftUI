//
//  Buttons.swift
//  DesignCode
//
//  Created by Christian Ruiz on 7/7/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI

func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    //allows for different levels of haptic vibration
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}

func simpleSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

struct Buttons: View {
    
    var body: some View {
        VStack(spacing: 50) { //Neumorphic Buttons
            RectangleButton()
            
            
            CircleButton()
                .onTapGesture {
                    haptic(type: .success)
            }
            
            PayButton()
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
            .foregroundColor(Color(#colorLiteral(red: 0.3543717265, green: 0.1941342354, blue: 0.552323103, alpha: 1)))
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
                    impact(style: .heavy)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { //timer
                        self.tap = false
                    }
                    
                }
                .onEnded { value in
                    self.press.toggle()
                    haptic(type: .success)
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
                .foregroundColor(Color(#colorLiteral(red: 0.3543717265, green: 0.1941342354, blue: 0.552323103, alpha: 1)))
                .offset(x: press ? -90 : 0, y: press ? -90 : 0)
                .rotation3DEffect(Angle(degrees: press ? 20 : 0), axis: (x: 10, y: -10, z: 0)) //rotates icon as if around a sphere
            
            Image(systemName: "moon")
                .font(.system(size: 44, weight: .light))
                .foregroundColor(Color(#colorLiteral(red: 0.3543717265, green: 0.1941342354, blue: 0.552323103, alpha: 1)))
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

struct PayButton: View {
    @GestureState var tap = false
    @State var press = false //long press
    
    var body: some View {
        ZStack {
            Image("fingerprint")
                .opacity(press ? 0 : 1)
                .scaleEffect(press ? 0 : 1)
            
            Image("fingerprint-2")
                .clipShape(Rectangle().offset(y: tap ? 0 : 50))
                .animation(.easeInOut) // no bounce back
                .opacity(press ? 0 : 1)
                .scaleEffect(press ? 0 : 1)
            
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 44, weight: .light))
                .foregroundColor(Color(#colorLiteral(red: 0.6530441642, green: 0.3625520468, blue: 1, alpha: 1)))
                .opacity(press ? 1 : 0)
                .scaleEffect(press ? 1 : 0)
            
            
        }
        .frame(width: 120, height: 120)
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
            .overlay(//progress bar
                Circle()
                    .trim(from: tap ? 0.001 : 1, to: 1) //animates progress circle
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.6530441642, green: 0.3625520468, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 5, lineCap: .round)) //creates cirlce border
                    .frame(width: 88, height: 88) //shink
                    .rotationEffect(Angle(degrees: 90)) //start progress from top by rotating
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                    .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 5, x: 3, y: 3)
                    .animation(.easeInOut) // no bounce back
                
            )
            .shadow(color: Color(press ? #colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 20, x: -20, y: -20)
            .shadow(color: Color(press ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8195130229, green: 0.6300581098, blue: 0.8301144242, alpha: 1)), radius: 20, x: 20, y: 20)
            .scaleEffect(tap ? 1.2 : 1)
            .gesture(
                LongPressGesture().updating($tap) { currentState, gestureState, transaction in
                    gestureState = currentState
                    
                }
                .onEnded { value in
                    self.press.toggle()
                }
        )
    }
}
