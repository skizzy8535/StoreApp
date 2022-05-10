//
//  OrderData.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/23.
//

import Foundation


struct OrderData: Codable {
    let records: [Record]
    struct Record: Codable {
        let id: String?
        let fields: Fields
        struct Fields: Codable {
            let name: String
            let phone: String
            let store: String?
            let date: String
            var memo: String?
        }
    }
}


