//
//  ContentView.swift
//  Landmarks
//
//  Created by Deepanshu Yadav on 17/10/19.
//  Copyright © 2019 Deepanshu Yadav. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    var landmark: Landmark

    var body: some View {

        VStack {
            Map(coordinate: landmark.locationCoordinate, landmark: landmark)
                .edgesIgnoringSafeArea(.top)
            ImageView(image: landmark.image)
                .fixedSize()
                .offset(x: 0,y: -150)
                .padding(.bottom , -150)
            VStack(alignment: .leading){
                Text(landmark.name).padding()
                    .font(.title)
                    .shadow(color: .gray, radius: 2, x: 2, y: 2)
                HStack{
                    Text(landmark.city).font(Font.custom("Palatino-BoldItalic", size: 18))
                    Spacer()
                    Text(landmark.state).font(.headline)
                }
            .padding()
                
            }
            Spacer()
        }.navigationBarTitle(Text(landmark.name),displayMode: .inline)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(landmark: landmarkData[0])
    }
}
