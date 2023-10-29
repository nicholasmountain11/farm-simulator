//
//  ContentView.swift
//  Farming Simulator
//
//  Created by Nick Mountain on 10/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            NavigationStack {
                VStack {
                    Text("Farming Simulator")
                        .font(.largeTitle)
                    Spacer()
                    
                    Text("Click your fields to harvest and sell crops")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    Spacer()
                    Text("Use the Store to buy fields to harvest, and equipment to increase your efficiency")
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    NavigationLink(destination: GameView(),
                                   label: {
                        Text("Play!")
                            .font(.largeTitle)
                    })
                    

                }

                .padding()
                
            }

        }
 
            
    }
        
}

#Preview {
    ContentView()
}
