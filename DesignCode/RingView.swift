//
//  RingView.swift
//  DesignCode
//
//  Created by Christian Ruiz on 2/11/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI

struct RingView: View {
    var color1 = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    var color2 = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    var width: CGFloat = 300
    var height: CGFloat = 300
    var percent: CGFloat = 65
    
    @Binding var show: Bool
    
    var body: some View {
        let multiplier = width / 44 //is a constant, use let instead of var. original design based on width and height of 44
        let progress = 1 - percent / 100

        return ZStack { //when declaring variables within body, must return the ZStack
            Circle() //inactive circle, to complete the cirlce
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: height)
            
            Circle()
                .trim(from: show ? progress : 1, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0)
            ) //dash [20,20] gives a dashed circle
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: width, height: height)
                .shadow(color: Color(color1).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
                .onTapGesture {
                    self.show.toggle()
            }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true)) //only necessary because we have a preview
    }
}
