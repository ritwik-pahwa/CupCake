//
//  Order.swift
//  CupCake
//
//  Created by Ritwik Pahwa on 21/06/22.
//

import SwiftUI

class Order: ObservableObject, Codable{
    
    enum CodingKeys: CodingKey{
        case type, quantity, extraFrosting, sprinkles, name, address, city, zip
    }
    
    static let types = ["vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 1
    
    @Published var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                sprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var sprinkles = false
    
    
    @Published var name = ""
    @Published var address = ""
    @Published var city = ""
    @Published var zip = ""
    
    var validAdrress: Bool{
        if name.isEmpty || city.isEmpty || address.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    init (){}
    
    var cost: Double{
        
        // $2 per cake
        var cost = Double(quantity) * 2
        
        //complicated cake cost more
        
        cost += (Double(type) / 2)
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if sprinkles {
            cost += (Double(quantity) / 2)
        }
        
        return cost
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(sprinkles, forKey: .sprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        sprinkles = try container.decode(Bool.self, forKey: .sprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
        
    }
    
    
    
}
