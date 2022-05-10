//
//  DrinkCollectionViewController.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/18.
//

import UIKit

class DrinkCollectionViewController: UIViewController {

    
    var drinkCategories : [DrinkCategory] = []
    var fullCupItems = 0
    var fullCupPrice = 0
    var initScrollIndex = CGFloat(0)
    
    @IBOutlet weak var drinkCollectionView: UICollectionView!
    @IBOutlet weak var numberOfCupLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkCollectionView.delegate = self
        drinkCollectionView.dataSource = self
    
        updateCartButtons()
        categorizeDrinks()
        configreCellLayout()
    }
    
    
    
 
    
    func categorizeDrinks(){
  
        let categories = ["醇茶","奶茶","鮮奶","奶霜","農摘","季節限定"]
        
        for category in categories {
            drinkCategories.append(DrinkCategory(name: category, drinks: []))
        }
        
        for drink in allDrinks {
            if let categoryIndex = categories.firstIndex(of: drink.category){
                drinkCategories[categoryIndex].drinks.append(drink)
            }
            
        }
     }
    
    
    func updateCartButtons(){
        fullCupItems = 0
        fullCupPrice = 0

        
        for order in orderDrinks {
            fullCupItems = order.numberOfCup
            fullCupPrice = order.numberOfCup * order.pricePerCup

        }
        
   

        cartButton.configuration?.title = "購物車 $\(fullCupPrice)"
        cartButton.configuration?.attributedTitle?.font = UIFont(name: "jf-openhuninn-1.1", size: 16)
        
        
        if fullCupItems > 0 {
            numberOfCupLabel.isHidden = false
            numberOfCupLabel.text = "\(fullCupItems)"
        }else{
            numberOfCupLabel.isHidden = true
        }
        
    }

    
    @IBSegueAction func ShowShopView(_ coder: NSCoder) -> ShopViewController? {
   
        guard let drinkCollectionIndex = drinkCollectionView.indexPathsForSelectedItems else {
            return ShopViewController(coder: coder,drink:allDrinks[0])
        }
        
        let section = drinkCollectionIndex[0][0]
        let row = drinkCollectionIndex[0][1]
        let drink = drinkCategories[section].drinks[row]
    
       return ShopViewController(coder: coder,drink: drink)
        
    }
    
  

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        initScrollIndex = scrollView.contentOffset.y
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > initScrollIndex {
            cartButton.configuration?.title = ""
        }else{
            cartButton.configuration?.title = "購物車 $\(fullCupPrice)"
            cartButton.configuration?.attributedTitle?.font = UIFont(name: "jf-openhuninn-1.1", size: 16)
        }
    }
    
    @IBAction func unwindToShopView(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func updateOrder( _ segue:UIStoryboardSegue){
        updateCartButtons()
    }
    
    
    @IBAction func completeOrder(_ segue: UIStoryboardSegue) {
           orderDrinks = []
           updateCartButtons()
    }
    

    
    
}
    



extension DrinkCollectionViewController :UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        drinkCategories.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drinkCategories[section].drinks.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableTitle = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                            withReuseIdentifier: "TitleCollectionReusableView",
                                                                            for: indexPath) as? TitleCollectionReusableView
        
        reusableTitle?.collectionTitle.text = drinkCategories[indexPath.section].name
        
        return reusableTitle!
    }
 
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "DrinkItemCollectionViewCell",
                        for: indexPath) as? DrinkItemCollectionViewCell
        
        let drink = drinkCategories[indexPath.section].drinks[indexPath.row]
        
        cell?.drinkImage.image = UIImage(named: drink.drinkName)
        cell?.drinkText.text = drink.drinkName
        return cell!

    }
    
    func configreCellLayout(){
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.headerReferenceSize = CGSize(width: 0, height: 50)
        flowLayout.minimumInteritemSpacing = CGFloat(10)
        flowLayout.minimumLineSpacing = CGFloat(10)
        flowLayout.itemSize = CGSize(width: 190, height: 200)
        flowLayout.estimatedItemSize = .zero
        drinkCollectionView.collectionViewLayout = flowLayout
    }
    
    

}
