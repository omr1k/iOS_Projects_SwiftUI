//
//  Order.swift
//  CupcakeCorner
//
//  Created by Omar Khattab on 02/09/2022.
//

import SwiftUI
//import Foundation

class OrderClass: ObservableObject{
    
    @Published var orderInit : orderStruct
    
    init() {
            orderInit = orderStruct()
        }
    
}

struct orderStruct : Codable{
    var type : Int = 0
    var quantity : Int = 1
    
    var extraFrosting : Bool = false
    var addSprinkles : Bool = false
    
    var name : String = ""
    var streetAddress : String = ""
    var city : String = ""
    var zip : String = ""
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    
    var hasValidAddress: Bool {
        
        if nameValidation && cityValidation && zipValidation == true {
            return true
        }
        return false
    }
    
    // swift not accept "\" alone and we should change it to "\\"" in regex
    
    var nameValidation : Bool{
        let nameRegex = "^[a-zA-Z]+(([\\'\\,\\.\\- ][a-zA-Z ])?[a-zA-Z]*)*$"
        if name.range(of: nameRegex,options: .regularExpression) == nil{
            return false
        }
        return true
    }
    
    var cityValidation : Bool{
        let cityRegex = "^[a-zA-Z]+(([\\'\\,\\.\\- ][a-zA-Z ])?[a-zA-Z]*)*$"
        if city.range(of: cityRegex,options: .regularExpression) == nil{
            return false
        }
        return true
    }
    
    var  zipValidation : Bool{
        let zipRegex = "^[1-9]+[0-9]*$"
        if zip.range(of: zipRegex,options: .regularExpression) == nil{
            return false
        }
        return true
    }
    
//    init() { }

}// struct end
    













//xxxxxxxxxxxxxxx
//import SwiftUI
//
//
//class Order: ObservableObject,Codable{
//    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
//
//    @Published var type = 0
//    @Published var quantity = 3
//
//    @Published var specialRequestEnabled = false {
//        didSet {
//            if specialRequestEnabled == false {
//                extraFrosting = false
//                addSprinkles = false
//            }
//        }
//    }
//    @Published var extraFrosting = false
//    @Published var addSprinkles = false
//
//    @Published var name = ""
//    @Published var streetAddress = ""
//    @Published var city = ""
//    @Published var zip = ""
//
//    var hasValidAddress: Bool {
//
//        if nameValidation && cityValidation && zipValidation == true {
//            return true
//        }
//
//
////        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
////            return false
////        }
////        let streetAdressRegex = "^(\\d{3,})\\s?(\\w{0,5})\\s([a-zA-Z]{2,30})\\s([a-zA-Z]{2,15})\\.?\\s?(\\w{0,5})$"
////        if streetAddress.range(of: streetAdressRegex,options: .regularExpression) == nil{
////            return false
////        }
//
//        return false
//    }
//
//    // swift not accept "\" alone and we should change it to "\\"" in regex
//
//    var nameValidation : Bool{
//        let nameRegex = "^[a-zA-Z]+(([\\'\\,\\.\\- ][a-zA-Z ])?[a-zA-Z]*)*$"
//        if name.range(of: nameRegex,options: .regularExpression) == nil{
//            return false
//        }
//        return true
//    }
//
//    var cityValidation : Bool{
//        let cityRegex = "^[a-zA-Z]+(([\\'\\,\\.\\- ][a-zA-Z ])?[a-zA-Z]*)*$"
//        if city.range(of: cityRegex,options: .regularExpression) == nil{
//            return false
//        }
//        return true
//    }
//
//    var  zipValidation : Bool{
//        let zipRegex = "^[1-9]+[0-9]*$"
//        if zip.range(of: zipRegex,options: .regularExpression) == nil{
//            return false
//        }
//       return true
//    }
//
//
//
//
////====================
//    var cost: Double {
//        // $2 per cake
//        var cost = Double(quantity) * 2
//
//        // complicated cakes cost more
//        cost += (Double(type) / 2)
//
//        // $1/cake for extra frosting
//        if extraFrosting {
//            cost += Double(quantity)
//        }
//
//        // $0.50/cake for sprinkles
//        if addSprinkles {
//            cost += Double(quantity) / 2
//        }
//
//        return cost
//    }
//
//    // implment codable by hand
//    init() { }
//
//    enum CodingKeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
//
//}
