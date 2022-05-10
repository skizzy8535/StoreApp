//
//  DrinkData.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/16.
//

import Foundation


struct DrinkData:Codable {
    
    let records:[Records]
    
    
    struct Records:Codable {
        
        let id:String
        let fields:Fields
        
        struct Fields:Codable{
            
            let drinkName:String
            let priceM:Int?
            let priceL:Int?
            let sugar:String
            let iceOnly :String
            let description:String
            let category:String
        }
        
    }
    
}
