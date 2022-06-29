//
//  Checkout.swift
//  CupCake
//
//  Created by Ritwik Pahwa on 21/06/22.
//

import SwiftUI

struct Checkout: View {
    @ObservedObject var order: Order

    @State var confirmationMessage = ""
    @State var showingConfirmation = false
    
    
    var body: some View {
        ScrollView{
            VStack{
//                AsyncImage(url: URL(string: "https://hws.dev/img/cupcake@3x.jpg"), scale: 3){ image in
//                    image
//                        .resizable()
//                        .scaledToFit()
//                }
//                placeholder :{
//                    ProgressView()
//                }
//                .frame(height: 233)

                Text("Your Total is \(order.quantity, format: .currency(code: "USD"))")

                Button("Place Order"){
                    Task{
                     await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank You!", isPresented: $showingConfirmation){
            Button("Ok"){}
        }message: {
            Text(confirmationMessage)
        }
    }


    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else{
            print("Failed to encode")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"


        do{
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)

            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x\(Order.types[decodedOrder.type].lowercased()) cupcake is on its way!"
            showingConfirmation = true
        }
        catch{
            print("checkout failed")
        }
    }
}

struct Checkout_Previews: PreviewProvider {
    static var previews: some View {
        Checkout(order: Order())
    }
}
