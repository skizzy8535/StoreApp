//
//  ShopViewController.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/22.
//

import UIKit

class ShopViewController: UIViewController {

    
    var drink:Drink
    var orderDrink :OrderDrink {
        didSet{
            orderDrink.updatePrice()
            updateToLatestPrice()
        }
    }
    
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkPriceLabel: UILabel!
    @IBOutlet weak var drinkCupLabel: UILabel!
    var drinkCups = 0
    var drinkFullPrice = 0
    
    init?(coder: NSCoder,drink:Drink) {
        self.drink = drink
        self.orderDrink = OrderDrink(id: nil,
                                     customerName: "",
                                     drink: drink,
                                     size: drink.priceM != nil ? "M": "L" ,
                                     sugar: sugarList[0],
                                     temperature: temperatureList[0],
                                     toppings: []
                                   )
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkNameLabel.text = drink.drinkName
        updateToLatestPrice()
    }
    

    @IBAction func updateCups(_ sender: UIStepper) {
        drinkCups = Int(sender.value)
        orderDrink.numberOfCup = drinkCups
        drinkCupLabel.text = "\(drinkCups) 杯"
    }
    
    func updateToLatestPrice(){
        drinkFullPrice = orderDrink.numberOfCup * orderDrink.pricePerCup
        drinkPriceLabel.text = "總金額：\(drinkFullPrice)元"
    }
    
    
    @IBSegueAction func ShowShopDetail(_ coder: NSCoder) -> StoreDetailViewController? {
        return StoreDetailViewController(coder: coder,drink: drink,orderDrink: orderDrink)
    }
    
    @IBAction func getDrinkDetail(_ segue:UIStoryboardSegue){
        
        
    }

    
  

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "updateOrder"{
            orderDrinks.append(orderDrink)
        }
        
    }

}
