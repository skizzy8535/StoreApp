//
//  CartViewController.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/26.
//

import UIKit

class CartViewController: UIViewController {

    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalCupLabel: UILabel!
    @IBOutlet weak var drinkTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.drinkTableView.delegate = self
        self.drinkTableView.dataSource = self
        
        updateOrder()
        // Do any additional setup after loading the view.
        self.isModalInPresentation = true
    }
    
    
    func updateOrder(){
        
        var totalPrice = 0
        var totalCup = 0
        
        
        for order in orderDrinks {
            totalPrice += order.pricePerCup * order.numberOfCup
            totalCup += order.numberOfCup
        }
        
        totalPriceLabel.text = "總金額: \(totalPrice) 元 "
        totalCupLabel.text = "共 \(totalCup) 杯"
    }
    
    @IBAction func unwindToCartViewController(_ unwindSegue: UIStoryboardSegue) {
    
    }
    

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if segue.identifier == "showCartInfoView"{
          let cartInfoVC = segue.destination as? CartInfoViewController
          cartInfoVC?.totalCupNumber = totalCupLabel.text!
          cartInfoVC?.totalPriceNumber = totalPriceLabel.text!
        }
        
    }
    

}

extension CartViewController:UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderDrinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let drinkCell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as! CartTableViewCell
        
        let orderDrink = orderDrinks[indexPath.row]
    
        
        drinkCell.delegate = self
        drinkCell.customerName.text = orderDrink.customerName
        drinkCell.drinkImage.image = UIImage(named: orderDrink.drink.drinkName)
        drinkCell.drinkName.text = orderDrink.drink.drinkName
        drinkCell.tipupButton.tag = indexPath.row
        drinkCell.tipdownButton.tag = indexPath.row
        
        var topping :String = ""
        
        for eachTopping in orderDrink.toppings {
           topping+="/\(eachTopping)"
        }
        
        drinkCell.drinkOrderLabel.text = "\(orderDrink.size)/\(orderDrink.sugar)/\(orderDrink.temperature)\(topping)/$\(orderDrink.pricePerCup)"
        
        drinkCell.drinkCupLabel.text = "\(orderDrink.numberOfCup)杯"
        return drinkCell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        orderDrinks.remove(at: indexPath.row)
        drinkTableView.deleteRows(at: [indexPath], with: .automatic)
        drinkTableView.reloadData()
        updateOrder()
    }
    

}


extension CartViewController:CartTableDelegate{
    func countDownCups(with cellIndex: Int) {
        
        if orderDrinks[cellIndex].numberOfCup >= 1 {
            
            orderDrinks[cellIndex].numberOfCup -= 1
            updateOrder()
            let indexPath = IndexPath(row: cellIndex, section: 0)
            drinkTableView.reloadRows(at: [indexPath], with: .none)
            
        }
        
    }
    
    func countUpCups(with cellIndex: Int) {
        if orderDrinks[cellIndex].numberOfCup < 100 {
            
            orderDrinks[cellIndex].numberOfCup += 1
            updateOrder()
            let indexPath = IndexPath(row: cellIndex, section: 0)
            drinkTableView.reloadRows(at: [indexPath], with: .none)
            
        }
    }
    
    

    
    
}
