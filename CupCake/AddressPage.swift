//
//  AddressPage.swift
//  CupCake
//
//  Created by Ritwik Pahwa on 21/06/22.
//

import SwiftUI

struct AddressPage: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Address",text:  $order.address)
                TextField("City",text:  $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section{
                NavigationLink{
                    Checkout(order: order)
                }label: {
                    Text("Checkout")
                }
            }
            .disabled(order.validAdrress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressPage_Previews: PreviewProvider {
    static var previews: some View {
        AddressPage(order: Order())
    }
}
