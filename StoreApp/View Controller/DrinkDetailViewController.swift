//
//  DrinkDetailViewController.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/26.
//

import UIKit

class DrinkDetailViewController: UIViewController {

    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var mSizeLabel: UILabel!
    @IBOutlet weak var lSizeLabel: UILabel!
    @IBOutlet weak var drinkDescription: UILabel!
    @IBOutlet weak var coldrinkOnly: UILabel!
    
    var drink:Drink
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    
    init?(coder: NSCoder,drink:Drink) {
        self.drink = drink
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initView(){
        drinkImage.image = UIImage(named: drink.drinkName)
        drinkName.text = drink.drinkName
        
        
        if drink.priceM == nil {
            mSizeLabel.isHidden = true
        }else if drink.priceL == nil{
            lSizeLabel.isHidden = true
        }
        
        drinkDescription.text = drink.description
        
        if drink.iceOnly{
            coldrinkOnly.isHidden = false
        }else{
            coldrinkOnly.isHidden = true
        }
        
        
    }

}
