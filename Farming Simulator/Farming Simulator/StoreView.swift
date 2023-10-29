//
//  StoreView.swift
//  Farming Simulator
//
//  Created by Nick Mountain on 10/28/23.
//

import SwiftUI

struct NewField: Identifiable {
    let id: ObjectIdentifier
    let crop: Crop
    let cost: Int
}

struct Equipment: Identifiable {
    let id: ObjectIdentifier
    let name: String
    let multiplier: Float
    var isBought: Bool
    let price: Int
}

struct StoreView: View {
    
    @Binding var fields: [Field]
    @Binding var balance: Int
    @Binding var clickMultiplier: Float
    
    var wheat = 0
    
    let fieldStore: [NewField] = [
    NewField(id: ObjectIdentifier(AnyObject.self), crop: Crop(name: "Barley", clicks: 80, price: 20), cost: 15),
    NewField(id: ObjectIdentifier(AnyObject.self), crop: Crop(name: "Soybean", clicks: 100, price: 200), cost: 100),
    NewField(id: ObjectIdentifier(AnyObject.self), crop: Crop(name: "Corn", clicks: 80, price: 500), cost: 200)
    ]
    
    @State var equipStore = [
        Equipment(id: ObjectIdentifier(AnyObject.self), name: "Hands", multiplier: 1, isBought: true, price: 0),
        Equipment(id: ObjectIdentifier(AnyObject.self), name: "Hoe", multiplier: 0.8, isBought: false, price: 50),
        Equipment(id: ObjectIdentifier(AnyObject.self), name: "John Deer T Series Class 7 Combine Model T670", multiplier: 0.6, isBought: false, price: 100),
        Equipment(id: ObjectIdentifier(AnyObject.self), name: "John Deer S Series Class 9 Combine Model S790", multiplier: 0.4, isBought: false, price: 200),
        Equipment(id: ObjectIdentifier(AnyObject.self), name: "John Deer X Series Class 11 Combine Model X9 1100", multiplier: 0.2, isBought: false, price: 300)
    ]
    
    var body: some View {
        ZStack{
            Color.yellow
                .opacity(0.5)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Text("Store")
                    .font(.largeTitle)
                Spacer()
                ScrollView {
                    LazyVStack(spacing: 5) {
                        Text("Buy New Fields")
                            .font(.title2)
                        ForEach(fieldStore.indices, id: \.self) {index in
                            NewFieldCellView(newField: fieldStore[index])
                                .onTapGesture {
                                    if (balance - fieldStore[index].cost >= 0) {
                                        fields.append(Field(id: ObjectIdentifier(AnyObject.self), crop: fieldStore[index].crop, clicksLeft: Int(Float(fieldStore[index].crop.clicks) * clickMultiplier), isEmpty: false))
                                        balance -= fieldStore[index].cost
                                    }
                                }
                                
                        }
                        Text("Change Equipment")
                            .font(.title2)
                        ForEach(equipStore.indices, id: \.self) {index in
                            NewEquipmentView(equip: equipStore[index])
                                .onTapGesture {
                                    if (balance - equipStore[index].price >= 0) {
                                        clickMultiplier = equipStore[index].multiplier
                                        balance -= equipStore[index].price
                                        equipStore[index] = Equipment(id: ObjectIdentifier(AnyObject.self), name: equipStore[index].name, multiplier: equipStore[index].multiplier, isBought: true, price: equipStore[index].price)
                                    }
                                }
                        }
                    }
                }
            }
            
            
        }
        
    }
}

struct NewFieldCellView: View {
    let newField: NewField
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.brown)
                .frame(height: 150)
                .cornerRadius(20)
                .padding(5)
            VStack {
                Text("\(newField.crop.name) Field")
                    .font(.title2).bold()
                
                HStack {
                    
                    
                    Text("Price: $\(newField.cost)")
                    Text("Clicks to harvest: \(newField.crop.clicks)")
                    Text("Value: $\(newField.crop.price)")
                    
                }
                
            }
            .padding()
            
        }
    }
}

struct NewEquipmentView: View {
    
    let equip: Equipment
    
    var body: some View {
        ZStack{
            
            if (equip.isBought){
                Rectangle()
                    .fill(Color.green)
                    .frame(height: 150)
                    .cornerRadius(20)
                    .padding(5)
            }
            else {
                Rectangle()
                    .fill(Color.brown)
                    .frame(height: 150)
                    .cornerRadius(20)
                    .padding(5)
            }
            
            VStack {
                Text("\(equip.name)")
                    .font(.title2).multilineTextAlignment(.center).bold()
                HStack {
                    
                    Text("Price: $\(equip.price)")
                    Text("Click Multiplier: \(equip.multiplier)")
                    
                }
            }
            
        }
    }
}

#Preview {
    @State var fields: [Field] = []
    @State var balance: Int = 0
    @State var clickMultiplier: Float = 1.0
    
    return StoreView(fields: $fields, balance: $balance, clickMultiplier: $clickMultiplier)
}
