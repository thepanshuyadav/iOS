//
//  ContentView.swift
//  BullsEye
//
//  Created by Deepanshu Yadav on 15/10/19.
//  Copyright © 2019 Deepanshu Yadav. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    
    struct LabelStyle : ViewModifier {
        func body(content: Content)-> some View{
            return content
            .foregroundColor(.white)
            .font(Font.custom("Optima-BoldItalic", size: 20))
            .modifier(shadowStyle())
        }
    }
    struct buttonTextStyle : ViewModifier {
        func body(content: Content)-> some View{
            return content
            .foregroundColor(.black)
            .font(Font.custom("Optima-BoldItalic", size: 20))
        }
    }
    struct buttonSmallStyle : ViewModifier {
        func body(content: Content)-> some View{
            return content
            .foregroundColor(.black)
            .font(Font.custom("Optima-BoldItalic", size: 14))
        }
    }
    struct shadowStyle : ViewModifier {
        func body(content:Content) -> some View {
            content
                .shadow(color: .black, radius: 5, x: 5, y: 5)
        }
    }
    
    struct ViewStyle : ViewModifier {
        func body(content:Content) -> some View {
            content
                .foregroundColor(.yellow)
                .modifier(shadowStyle())
                .font(Font.custom("Optima-BoldItalic", size: 24))
        }
    }
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Push the slider as close as you can to: ").modifier(LabelStyle())
                Text("\(target)").modifier(ViewStyle())
            }
            Spacer()
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100").modifier(LabelStyle())
            }.padding(.horizontal, 50)
            Button(action: {
                self.alertIsVisible = true
                
            }) {
                Text("Hit Me").modifier(buttonTextStyle())
            }.alert(isPresented: $alertIsVisible){ ()-> Alert in
                return Alert(title: Text("\(alertTitle())"), message: Text("The value of slider is \(sliderValueRounded())\n"+"You scored \(self.scoreForCurrentRound()) points"), dismissButton: .default(Text("Next Round")) {
                    self.score = self.score + self.scoreForCurrentRound()
                    self.target = Int.random(in: 1...100)
                    self.round += 1
                    })
            }
            .background(Image("Btn").accentColor(.yellow))
            .modifier(shadowStyle())
            Spacer()
            HStack {
                Button(action: {
                    self.newGame()
                }) {
                    HStack{
                        Image("StartOverIcon").accentColor(.blue)
                        Text("Start Over").modifier(buttonSmallStyle())
                    }
                    
                }
                .background(Image("Btn"))
                .accentColor(.yellow)
                Spacer()
                Text("Score :").modifier(LabelStyle())
                Text("\(score)").modifier(ViewStyle())
                Spacer()
                Text("Round :").modifier(LabelStyle())
                Text("\(round)").modifier(ViewStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack{
                        Image("InfoIcon").accentColor(.blue)
                        Text("Info").modifier(buttonSmallStyle())
                    }
                }
                .background(Image("Btn"))
                .accentColor(.yellow)
            }.padding(.bottom,40)
                .padding(.horizontal, 30)
        }
        .background(Image("Background"))
    .navigationBarTitle("Bull's Eye")
    }
    func amountOff() -> Int {
        return abs(sliderValueRounded() - target)
    }
    func bonusPoints() -> Int {
        let diff = amountOff()
        var bonus : Int
        if diff==0 {
            bonus = 100
        }else if diff == 1 {
            bonus = 51
        }else if diff == 2 {
            bonus = 27
        }else {
            bonus = 0
        }
        return bonus
    }
    func newGame() {
        round = 1
        score = 0
        target = Int.random(in: 1...100)
        sliderValue = 50.0
        
    }
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    func alertTitle() -> String {
        let title : String
        let dif = amountOff()
        if(dif == 0) {
            title = "Impressive!!"
        }else if(dif<5) {
            title = "Very Close"
        }else if(dif<10) {
            title = "Not Bad"
        }else{
            title = "Are you even trying?"
        }
        return title
    }
    func scoreForCurrentRound() -> Int {
        let maximumValue = 100
        return maximumValue-amountOff() + bonusPoints()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
