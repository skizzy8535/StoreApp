//
//  OrderDrinkData.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/21.
//



import Foundation

struct OrderDrinkData:Codable {
    
    let records:[Records]

    struct Records:Codable {
        
        let id:String?
        let fields:Fields
        
        struct Fields:Codable{
            
            let customerName:String?
            let drink:String
            let size:String
            let sugar:String
            let temperature :String
            let toppings:[String]?
            let pricePerCup: Int
            let numberOfCup: Int
            let orderNo: String?
        }
        
    }
}

    
    func getOrderDrinkData(orderDrink:OrderDrink,orderNo:String)->OrderDrinkData{
        
        let orderDrinkData = OrderDrinkData(records: [.init(id: orderDrink.id,
                                                            fields: .init(customerName: orderDrink.customerName,
                                                                          drink: orderDrink.drink.drinkName,
                                                                          size: orderDrink.size,
                                                                          sugar: orderDrink.sugar,
                                                                          temperature: orderDrink.temperature,
                                                                          toppings: orderDrink.toppings,
                                                                          pricePerCup: orderDrink.pricePerCup,
                                                                          numberOfCup: orderDrink.numberOfCup,
                                                                          orderNo:
                                                                            orderNo))])
        
        return orderDrinkData
    }
    
    
    
    func uploadOrderDrinkData(orderDrink:OrderDrink,orderNo:String){
       
       let encoder = JSONEncoder()
       let orderDrinkBody = getOrderDrinkData(orderDrink: orderDrink, orderNo: orderNo)
       
        guard let uploadOrderDrinkURL = URL(string: "https://api.airtable.com/v0/\(appDrinksID)/OrderDrink?api_key=\(appDrinksKey)")else{
            return
        }
        
        
        var uploadOrderDrinkRequest = URLRequest(url: uploadOrderDrinkURL)
        uploadOrderDrinkRequest.httpMethod = "POST"
        uploadOrderDrinkRequest.httpBody = try? encoder.encode(orderDrinkBody)
        uploadOrderDrinkRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: uploadOrderDrinkRequest, completionHandler: { data, response, error in
            
            if let data = data,
               let content = String(data: data, encoding: .utf8) {
                print(content)
            }
            
    
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP response status code: \(httpResponse.statusCode)")
            }
     
            if let error = error {
                print(error.localizedDescription)
            }
            
        }).resume()
        
        
        
        
    }
    
    

