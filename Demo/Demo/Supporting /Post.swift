//
//  Post.swift
//  Demo
//
//  Created by Deepanshu Yadav on 17/11/19.
//  Copyright © 2019 Deepanshu Yadav. All rights reserved.
//

import SwiftUI

struct Post: View {
    var body: some View {
        VStack {
            HStack{
                Image("user")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("@unofficialnsut")
                Spacer()
            }.padding(10)
            HStack{
                Image("demo")
                .resizable()
                .frame(width: 400, height: 400)
                .cornerRadius(10)
                
            }
        }
        
        
        
    }
}

struct Post_Previews: PreviewProvider {
    static var previews: some View {
        Post()
    }
}
