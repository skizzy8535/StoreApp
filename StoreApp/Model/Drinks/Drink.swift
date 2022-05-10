//
//  Drink.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/16.
//

import Foundation


struct DrinkCategory {
    let name: String
    var drinks: [Drink]
}
               
struct Drink:Equatable {
    
    let drinkName:String
    let priceM:Int?
    let priceL:Int?
    let sugar:Bool
    let iceOnly :Bool
    let description:String
    let category:String
 }
    
