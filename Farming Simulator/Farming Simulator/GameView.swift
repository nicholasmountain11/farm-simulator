//
//  GameView.swift
//  Farming Simulator
//
//  Created by Nick Mountain on 10/28/23.
//

import SwiftUI

var idCount: Int = 0



struct Field: Identifiable {
    
    let id: ObjectIdentifier
    var crop: Crop
    var clicksLeft: Int
    var isEmpty: Bool
}

struct GameView: View {
    
    @State var balance = 100
    @State var clickMultiplier: Float = 1
    
    @State var fields: [Field] = [
        //        Field(id: ObjectIdentifier(AnyObject.self), crop: Crop(name: "wheat", clicks: 4, price: 10), clicksLeft: 4, isEmpty: false),
        //        Field(id: ObjectIdentifier(AnyObject.self), crop: Crop(name: "corn", clicks: 7, price: 15), clicksLeft: 7, isEmpty: false)
    ]
    
    var body: some View {

        NavigationStack {
            VStack {
                HStack {
//                    Text("Fields")
//                        .font(.title)
//                        .padding()
//                    Spacer()
                    Text("Balance: $\(balance)")
                        .font(.title3)
                        .padding()
                    Text("Multiplier: \(clickMultiplier)")
                }
                Text("Your Fields")
                    .font(.largeTitle)
                    .padding()
                
                NavigationLink(destination: StoreView(fields: $fields, balance: $balance, clickMultiplier: $clickMultiplier), label: {
                    Text("Store")
                })
                Spacer()
                ScrollView {
                    LazyVStack(spacing: 5) {
                        ForEach(fields.indices, id: \.self) {index in
                            FieldCellView(field: fields[index])
                            
                                .onTapGesture {
                                    if(fields[index].isEmpty){
                                        
                                    }
                                    
                                    else if (fields[index].clicksLeft == 1) {
                                        self.fields[index] = Field(id: ObjectIdentifier(AnyObject.self), crop: fields[index].crop, clicksLeft: fields[index].clicksLeft - 1, isEmpty: true)
                                        balance += self.fields[index].crop.price
                                    }
                                    
                                    else {
                                        
                                        self.fields[index] = Field(id: ObjectIdentifier(AnyObject.self), crop: fields[index].crop, clicksLeft: fields[index].clicksLeft - 1, isEmpty: fields[index].isEmpty)
                                    }
                                }
                        }
                    }
                    
                    
                }
            }
            .background(Color.green.opacity(0.7))
        }
        
    
    
    }
    
}

struct FieldCellView: View {
    let field: Field
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.brown)
                .frame(height: 150)
                .cornerRadius(20)
                .padding(5)
            HStack {
                Text("\(field.crop.name)")
                    .font(.title2).bold()
                Spacer()
                Text("\(field.clicksLeft) clicks left to harvest")
                    
            }
            .padding()
            
        }
    }
}

#Preview {
    GameView()
}
