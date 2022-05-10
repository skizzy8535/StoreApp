//
//  StoreDetailViewController.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/24.
//

import UIKit

class StoreDetailViewController: UITableViewController, UITextFieldDelegate {

    
    var drink:Drink
    var orderDrink :OrderDrink{
        didSet{
            performSegue(withIdentifier: "getDrinkDetail", sender: nil)
        }
    }
    var selectedToppings :[UIButton] = []
    
    @IBOutlet weak var pickDrinkImage: UIImageView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet var sizeButtons: [UIButton]!
    @IBOutlet var temperatureButtons: [UIButton]!
    @IBOutlet var sugarButtons: [UIButton]!
    @IBOutlet var toppingButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        nameTextfield.delegate = self
        nameTextfield.addTarget(self,
                                action: #selector(textFieldChange(_:)),
                                for: .editingChanged)
        changeButtonColor(allButtons: toppingButtons, selectedButtons: [toppingButtons[0]])
    }
    
    init?(coder: NSCoder,drink:Drink,orderDrink:OrderDrink) {
        self.drink = drink
        self.orderDrink = orderDrink
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initUI(){
        pickDrinkImage.image = UIImage(named: drink.drinkName)
        
        // Size
     
        if drink.priceM != nil {
             sizeButtons[0].isHidden = false
            changeButtonColor(allButtons: sizeButtons, selectedButtons: [sizeButtons[0]])
         }else{
             sizeButtons[0].isHidden = true
             changeButtonColor(allButtons: sizeButtons, selectedButtons: [sizeButtons[1]])
         }
        
        // Temperature
        
        changeButtonColor(allButtons: temperatureButtons, selectedButtons: [temperatureButtons[0]])
        
        if drink.iceOnly{
            
            for index in 3..<5{
                temperatureButtons[index].isHidden = true
            }
            
        }
        
       // Sugar
        
        changeButtonColor(allButtons: sugarButtons, selectedButtons: [sugarButtons[0]])
        
    }
    
    @objc func textFieldChange(_ textField:UITextField){
        orderDrink.customerName = nameTextfield.text ?? ""
    }
    
    func changeButtonColor(allButtons:[UIButton],selectedButtons:[UIButton]){
        for button in allButtons {
            button.configuration?.baseBackgroundColor = UIColor(named: "SecondaryColor")
            button.configuration?.baseForegroundColor = UIColor(named: "MainColor")
        }
        for button in selectedButtons {
            button.configuration?.baseBackgroundColor = UIColor(named: "MainColor")
            button.configuration?.baseForegroundColor = .white
        }
        
    }
    
    @IBAction func sizeChange(_ sender: UIButton) {
        let sizeTitle = sender.titleLabel!.text!
        orderDrink.size = sizeTitle
        changeButtonColor(allButtons: sizeButtons, selectedButtons: [sizeButtons[sender.tag]])
    }
    
    @IBAction func temperatureChange(_ sender: UIButton) {
        let temperatureTitle = sender.titleLabel!.text!
        orderDrink.temperature = temperatureTitle
        changeButtonColor(allButtons: temperatureButtons, selectedButtons: [temperatureButtons[sender.tag]])
    }
    
    
    
    @IBAction func sugarChange(_ sender: UIButton) {
        let sugarTitle = sender.titleLabel!.text!
        orderDrink.sugar = sugarTitle
        changeButtonColor(allButtons: sugarButtons, selectedButtons: [sugarButtons[sender.tag]])
    }
    
    
    
    @IBAction func toppingsChanged(_ sender: UIButton) {
        
        orderDrink.toppings = []
        
        if selectedToppings.contains(sender){
            selectedToppings.removeAll(where: {$0 == sender})
        }else{
            selectedToppings.append(sender)
            if selectedToppings.count > 2 {
                selectedToppings = []
            }
        }
        for pickedTopping in selectedToppings {
            if let topping = pickedTopping.titleLabel?.text{
                orderDrink.toppings.append(topping)
            }
        }
 
        
        changeButtonColor(allButtons: toppingButtons, selectedButtons: selectedToppings)
    }
    
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "getDrinkDetail"{
            let drinkDetailDestination = segue.destination as? ShopViewController
            
            drinkDetailDestination?.orderDrink = orderDrink
        }
        
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
}
