//
//  HomeView.swift
//  DesignCode
//
//  Created by Christian Ruiz on 2/6/20.
//  Copyright © 2020 Synthetic Fox. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                        .modifier(CustomFontModifier(size: 32)) //top font modifier takes priority over custom
                    Spacer()
                    
                    AvatarView(showProfile: $showProfile)
                    
                    Button(action: { self.showUpdate.toggle() }) {
                        Image(systemName: "bell")
                            //.renderingMode(.original)
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color("background3"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                        .sheet(isPresented: $showUpdate) { //brings up modal window
                            UpdateList()
                    }
                }
                .padding(.horizontal)
                    .padding(.leading, 14) //align title with card, 14 + default 16 = 30 (same as card)
                    .padding(.top, 30)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent = true
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) { //when embeded in HStack, will have it show horizontally
                        ForEach(sectionData) { item in
                            GeometryReader { geometry in
                                SectionView(section: item)
                                    .rotation3DEffect(Angle(degrees:
                                        Double(geometry.frame(in: .global).minX - 30) / -20 //minX is left side location, -30 offset for no starting angle, -20 so not too large of animation
                                    ), axis: (x: 0, y: 10.0, z: 0)) //y effect on hor axis
                            }
                                .frame(width: 275, height: 275) //size of card
                        }
                    }
                    .padding(30)
                        .padding(.bottom, 30) //so the shadow does not clip
                }
                .offset(y: -30) //bring course sections up due to padding for clipping in rings scrollview
                
                HStack {
                    Text("Courses")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(section: sectionData[2], width: screen.width - 60, height: 275)
                .offset(y: -60)
                .onTapGesture {
                    Buttons()
                }
                
                Spacer()
            }
            .frame(width: screen.width)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable { //identifiable so that swift can uniquely indentify each card
    var id = UUID() //gives unique id for data
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype designs in SwiftUI", text: "18 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card4")), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))), //for now must set and copy image literals outside of data
    Section(title: "Build a SwiftUI App", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card1")), color: Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))),
    Section(title: "SwiftUI Events", text: "25 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card2")), color: Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
]


struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30.0) {
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 44, height: 44, percent: 65, show: .constant(true))
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left")
                        .bold() //must set before modifier
                        .modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 mins today")
                        .modifier(FontModifier(style: .caption))
                }
                //.modifier(FontModifier()) //can apply modifier to VStack, all children would use the modifier
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
                .modifier(ShadowModifier()) //can create custom reusable modifiers (such as double shadow)
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), width: 32, height: 32, percent: 72, show: .constant(true))
                
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), width: 32, height: 32, percent: 32, show: .constant(true))
                
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
