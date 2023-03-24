//
//  ContentView.swift
//  Wather day
//
//  Created by Uma Bugrayeva on 10.02.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var shortURL = URLShortenManager()
    var body: some View {
        ZStack{
            Image("free")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .opacity(1.0)
            
            VStack {
                Image.init(systemName: shortURL.image2Weath)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .font(.system(size: 50, weight: .bold, design: .serif))
                    .padding()
                    .frame(width: 200, height: 100, alignment: .trailing)
                HStack{
                    TextField("City", text: $shortURL.citi)
                        .textSelection(.enabled)
                        .foregroundColor(.green)
                        .font(.title)
                        .background(Color.white.opacity(0.5).cornerRadius(10))
                        .bold()
                    
                    TextField("Temperatyre", text: $shortURL.tempi)
                        .textSelection(.enabled)
                        .foregroundColor(.black)
                        .font(.system(size: 30, weight: .bold, design: .serif))
                        .bold()
                }
                Button(action: {
                    shortURL.getData()
                }, label: {
                    Text("update".uppercased())
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.3).cornerRadius(10))
                }).padding()
            }
            .padding()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
