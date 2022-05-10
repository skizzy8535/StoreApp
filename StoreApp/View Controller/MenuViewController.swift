//
//  MenuViewController.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/15.
//

import UIKit

class MenuViewController: UIViewController {
    
    var categoryDrinks :[Drink] = []
    var categoryIndex = 0
    
    @IBOutlet var categoryButtons: [UIButton]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var drinkTableView: UITableView!
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        drinkTableView.delegate = self
        drinkTableView.dataSource = self

        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        
        swipeLeftGestureRecognizer.direction = .left
        swipeRightGestureRecognizer.direction = .right
        
        
        drinkTableView.addGestureRecognizer(swipeLeftGestureRecognizer)
        drinkTableView.addGestureRecognizer(swipeRightGestureRecognizer)
    
        changeButtonColor(selectedButton: categoryButtons[0])
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if allDrinks == [] {
            fetchDrinks()
        }
    }

    
    func fetchDrinks(){
        loadIntroScreen()
        guard let drinkURL = URL(string: "https://api.airtable.com/v0/\(appDrinksID)/Drink?api_key=\(appDrinksKey)") else {
            return
        }
        
        URLSession.shared.dataTask(with: drinkURL) { data, response, error in
            if let data = data {
                
                let parsedDrinkData :DrinkData = decodeJsonData(data)
                self.convertDrinkData(parsedDrinkData)
                
                DispatchQueue.main.async {
                    self.getCategoryDrink(category:  "醇茶")
                    self.drinkTableView.reloadData()
                    self.dismiss(animated: true, completion: nil)

                }
            }
        }.resume()
 
        
    }

    
    func convertDrinkData(_ drinkdata :DrinkData){
       
        for drinkItem in drinkdata.records{
            
            let priceM = drinkItem.fields.priceM ?? nil
            let priceL = drinkItem.fields.priceL ?? nil
            
            let drink = Drink(drinkName: drinkItem.fields.drinkName,
                            priceM: priceM,
                            priceL: priceL,
                            sugar: drinkItem.fields.sugar == "TRUE" ? true : false,
                            iceOnly: drinkItem.fields.iceOnly == "TRUE" ? true : false,
                            description: drinkItem.fields.description,
                            category: drinkItem.fields.category
                        )
            
            allDrinks.append(drink)
        
        }
        
    }
    
    
    
    func getCategoryDrink(category:String){
        categoryDrinks = []
        
        for drink in allDrinks{
            if drink.category == category {
                categoryDrinks.append(drink)
            }
            
        }
       
        self.drinkTableView.reloadData()
    }
    
    

    func changeButtonColor(selectedButton : UIButton){
    
        for button in categoryButtons {
            button.configuration?.baseBackgroundColor = UIColor(named: "SecondaryColor")
            button.configuration?.baseForegroundColor = UIColor(named: "MainColor")
        }
        
        selectedButton.configuration?.baseBackgroundColor = UIColor(named: "MainColor")
        selectedButton.configuration?.baseForegroundColor = .white
        
    }

    
    @IBAction func categoryPressed (_ sender:UIButton) {

        
        let categoryText = sender.titleLabel!.text!
        getCategoryDrink(category: categoryText)
        
        let categoryIndex = sender.tag
        changeButtonColor(selectedButton: categoryButtons[categoryIndex])
        
        
        let scrollLimit = scrollView.contentSize.width - scrollView.frame.width
        let scrollOffset = sender.center.x - scrollView.frame.width / 2
        
        if scrollOffset < 0 {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }else if scrollOffset > scrollLimit {
            scrollView.setContentOffset(CGPoint(x: scrollOffset, y: 0), animated: true)
        }else{
            scrollView.setContentOffset(CGPoint(x: scrollLimit, y: 0), animated: true)
        }
        
        
        let topIndex = IndexPath(row: 0, section: 0)
        drinkTableView.scrollToRow(at: topIndex, at: .top, animated: true)
        
    }
    
    @IBAction func swipeLeft(){
      
        if categoryIndex < categoryDrinks.count - 1 {
            categoryIndex += 1
            categoryPressed(categoryButtons[categoryIndex])
        }
   
        
    }
    
    
    @IBAction func swipeRight(){
        
        if categoryIndex >= 1 {
            categoryIndex -= 1
            categoryPressed(categoryButtons[categoryIndex])
        }
    }
    
    
    @IBSegueAction func showDrinkDetail(_ coder: NSCoder) -> DrinkDetailViewController? {
        if let selectedRow = drinkTableView.indexPathForSelectedRow?.row {
            
            let drink = categoryDrinks[selectedRow]
            
            return DrinkDetailViewController(coder: coder, drink: drink)
        }
        
        return DrinkDetailViewController(coder: coder, drink: allDrinks[0])
    }
    
    

    func loadIntroScreen(){
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let introViewController =  storyboard.instantiateViewController(withIdentifier: "LoadViewController")
      introViewController.modalPresentationStyle = .fullScreen
      introViewController.modalTransitionStyle = .crossDissolve
     present(introViewController, animated: true)
    }
    
    
    
    
    
}


extension MenuViewController:UITableViewDelegate,UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryDrinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drinkCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell
        
        let drink = categoryDrinks[indexPath.row]
        
        
        drinkCell?.drinkImage.image = UIImage(named: drink.drinkName)
        
        drinkCell?.drinkItemLabel.text = drink.drinkName
        
        if drink.priceM != nil {
            drinkCell?.mSizeLabel.isHidden = false
            drinkCell?.mPriceLabel.isHidden = false
            drinkCell?.mPriceLabel.text = "\(drink.priceM ?? 0)"
        }else{
            drinkCell?.mSizeLabel.isHidden = true
            drinkCell?.mPriceLabel.isHidden = true
        }
        
        
        if drink.priceL != nil {
            drinkCell?.lSizeLabel.isHidden = false
            drinkCell?.lPriceLabel.isHidden = false
            drinkCell?.lPriceLabel.text = "\(drink.priceL ?? 0)"
        }else{
            drinkCell?.lSizeLabel.isHidden = true
            drinkCell?.lPriceLabel.isHidden = true
        }
     
        
        return drinkCell!
    }
    
    
}
