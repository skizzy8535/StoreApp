//
//  OrderDrink.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/21.
//

import Foundation


struct OrderDrink {
     
      let id: String?
      var customerName: String = ""
      let drink: Drink
      var size: String
      var sugar: String
      var temperature: String
      var toppings: [String]
    
      var pricePerCup: Int = 0
      var numberOfCup: Int = 1

    
    mutating func updatePrice() {
        
        let initalDrinkPrice = size == "M" ? drink.priceM! : drink.priceL!
        
        var toppingPrice = 0
        
        for topping in toppings {
            
            if let price = toppingList[topping] {
                toppingPrice += price
            }
            
        }
        
        pricePerCup = initalDrinkPrice+toppingPrice
        
        
    }
     
    
    
}
