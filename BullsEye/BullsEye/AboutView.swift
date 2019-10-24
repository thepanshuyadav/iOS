//
//  AboutView.swift
//  BullsEye
//
//  Created by Deepanshu Yadav on 16/10/19.
//  Copyright © 2019 Deepanshu Yadav. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    struct buttonSmallStyle : ViewModifier {
        func body(content: Content)-> some View{
            return content
            .foregroundColor(.white)
            .font(Font.custom("Optima-BoldItalic", size: 18))
        }
    }
    struct shadowStyle : ViewModifier {
        func body(content:Content) -> some View {
            content
                .shadow(color: .black, radius: 5, x: 5, y: 5)
        }
    }
    var body: some View {
        
        VStack{
            Text("🎯 Bull's Eye 🎯\n\n").bold().modifier(buttonSmallStyle()).modifier(shadowStyle())
            Text("🏅 This is my first iOS app called Bull's Eye 🏅\n").modifier(buttonSmallStyle())
            Text(" Your goal is to pull the slider as close to the target value. The closer you are, the more points you earn. \n").modifier(buttonSmallStyle()).multilineTextAlignment(.center)
            Text("⚡️ Enjoy! ⚡️").modifier(buttonSmallStyle())
        }
    .navigationBarTitle("About Game")
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
