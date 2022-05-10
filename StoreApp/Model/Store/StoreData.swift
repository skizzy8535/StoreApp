//
//  StoreData.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/16.
//

import Foundation



struct StoreData:Codable{
    
  
    let storeItems:[StoreItems]
    
    struct StoreItems:Codable{
        
        
        let name:String
        let address:String
        let mapUrl:String
        let phone:String
        let openingHours:String
        
        enum CodingKeys :String,CodingKey {
            case name
            case address
            case mapUrl = "map_url"
            case phone
            case openingHours = "opening_hours"
            
        }
    }
    
    enum CodingKeys :String,CodingKey {
        case storeItems = "store_items"
    }
    
    
    
}



