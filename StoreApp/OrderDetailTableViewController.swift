//
//  OrderDetailTableViewController.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/5/9.
//

import UIKit

class OrderDetailTableViewController: UITableViewController {

    
    
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    var orderDrinksInOrder: [OrderDrink]
    var order: Order
    
    init?(coder: NSCoder, orderDrinksInOrder: [OrderDrink], order: Order) {
        self.orderDrinksInOrder = orderDrinksInOrder
        self.order = order
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        var totalPrice: Int = 0
        var totalNumberOfCup: Int = 0
        for orderDrink in orderDrinksInOrder {
            totalPrice += orderDrink.numberOfCup * orderDrink.pricePerCup
            totalNumberOfCup += orderDrink.numberOfCup
        }
        totalPriceLabel.text = "$\(totalPrice)元 / \(totalNumberOfCup)杯"
        storeLabel.text = order.store
        dateLabel.text = order.date
        nameLabel.text = "訂購人：\(order.name)"
        phoneLabel.text = "手機號碼：\(order.phone)"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDrinksInOrder.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailTableViewCell", for: indexPath) as! OrderDetailTableViewCell
        
        let orderDrink = orderDrinksInOrder[indexPath.row]
        cell.customerNameLabel.text = orderDrink.customerName
        if orderDrink.customerName == "" {
            cell.customerNameLabel.isHidden = true
         
        } else {
            cell.customerNameLabel.isHidden = false
    
        }
        cell.drinkImageView.image = UIImage(named: orderDrink.drink.drinkName)
        cell.drinkNameLabel.text = orderDrink.drink.drinkName
        var toppingString: String = ""
        for topping in orderDrink.toppings {
            toppingString += "/\(topping)"
        }
        cell.drinkDetailLabel.text = "\(orderDrink.size)/\(orderDrink.sugar)/\(orderDrink.temperature)\(toppingString)/$\(orderDrink.pricePerCup)"
        cell.numberOfCupLabel.text = "\(orderDrink.numberOfCup)杯"
        
        return cell
    }


}

