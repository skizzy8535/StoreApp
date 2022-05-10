//
//  Decode.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/16.
//

import Foundation


// Load Json File



func loadJsondata(_ fileName:String) -> Data? {
    
    let data : Data
    guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        fatalError()
    }
    
    
    do {
        data = try Data(contentsOf: file)
        return data
    } catch {
        fatalError()
    }
    
    
}



// Decode Data


func decodeJsonData<T:Decodable>(_ data:Data)-> T {

    do {
        let jsDeocder = JSONDecoder()
        return try jsDeocder.decode(T.self, from: data)
    } catch{
        fatalError()
    }
    
    
    
}
