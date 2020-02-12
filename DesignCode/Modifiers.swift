//
//  Modifiers.swift
//  DesignCode
//
//  Created by Christian Ruiz on 2/12/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

struct FontModifier: ViewModifier {
    var style: Font.TextStyle = .body //can made modifier more dynamic
    
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .default))
    }
}

//free fonts from fonts.google.com
struct CustomFontModifier: ViewModifier {
    var size: CGFloat = 28
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Sriracha-Regular", size: size))
    }
}
