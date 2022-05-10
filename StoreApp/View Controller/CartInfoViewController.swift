//
//  CartInfoViewController.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/26.
//

import UIKit

class CartInfoViewController: UIViewController {

    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalCupLabel: UILabel!
    

    var totalCupNumber = ""
    var totalPriceNumber = ""
    var order :Order = Order(orderNo: "", name: "", phone: "", store: "", date: "", memo: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalPriceLabel.text = "\(totalPriceNumber)"
        totalCupLabel.text = "\(totalCupNumber)"
    }
    

    @IBAction func checkOrder(_ sender: UIButton) {
           

        if order.name.isEmpty {
            showAlert(message: "請輸入訂購人姓名")
        } else if order.phone.isEmpty{
            showAlert(message: "請輸入手機號碼")
        }else if order.store.isEmpty{
              showAlert(message: "請輸入商店名稱")
        }else {
            uploadOrder(order: order)
        }
        
        
        
    }
    
    
    
    func showAlert(message:String){
        
        
        let alertController = UIAlertController(title: "欄位錯誤", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
        
    
    func getOrderDataBody(order:Order)->OrderData{
        
        let orderData = OrderData(records: [.init(id: nil,
                                                  fields: .init(
                                                    name: order.name,
                                                    phone: order.phone,
                                                    store: order.store,
                                                    date: order.date,
                                                    memo: order.memo))])
        
        return orderData
        
    }
 
    
    func saveToUserPhone(){
        let userDefault = UserDefaults.standard
        
        if var orderNos = userDefault.array(forKey: "AllOrderNos"){
            orderNos += [order.orderNo]
            userDefault.set(orderNos, forKey: "AllOrderNos")
        }else{
            let orderNos = [order.orderNo]
            userDefault.set(orderNos, forKey: "AllOrderNos")
            
        }
        
    }
    
    func uploadOrder(order:Order){
        
        let encoder = JSONEncoder()
        let orderDataBody :OrderData = getOrderDataBody(order: order)
        
        guard let uploadOrderURL = URL(string: "https://api.airtable.com/v0/\(appDrinksID)/Order?api_key=\(appDrinksKey)")else{
            return
        }
        
        var uploadOrderRequest = URLRequest(url: uploadOrderURL)
        uploadOrderRequest.httpMethod = "POST"
        uploadOrderRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        uploadOrderRequest.httpBody = try? encoder.encode(orderDataBody)
        URLSession.shared.dataTask(with: uploadOrderRequest, completionHandler: { data, response, error in
            
            if let data = data {
            
                let orderData :OrderData = decodeJsonData(data)
                
                if let orderID = orderData.records[0].id{
                    self.order.orderNo = orderID
                }
                
            }
            
            if let response = response as? HTTPURLResponse{
                print("HTTP Response :\(response)")
            }
            
            for orderDrink in orderDrinks{
                uploadOrderDrinkData(orderDrink: orderDrink, orderNo: self.order.orderNo)
            }
            
            
            self.saveToUserPhone()
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeOrder", sender: nil)
            }
            

            
            
        }).resume()
        
    }
    
   
    
    
    @IBAction func unwindToCartInfoView(_ segue: UIStoryboardSegue) {
        

         }

    }
    
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    

