//
//  ContentView.swift
//  CupCake
//
//  Created by Ritwik Pahwa on 21/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type",selection: $order.type){
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                
                    Text("\(order.quantity)")
                }
                
                Section{
                    Toggle("Any Special Requirements?", isOn: $order.specialRequestEnabled.animation())
                    if(order.specialRequestEnabled == true){
                        Toggle("Add Extra Frosting", isOn: $order.extraFrosting)
                        Toggle("Add Extra Sprinkles", isOn: $order.sprinkles)
                    }
                    
                }
                
                Section{
                    NavigationLink{
                        AddressPage(order: order)
                    }label: {
                        Text("Delivery Details")
                    }
                }
                
                .navigationTitle("Cupcake corner")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
