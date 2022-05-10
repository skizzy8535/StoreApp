//
//  CartTableViewCell.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/26.
//

import UIKit


protocol CartTableDelegate{
    func countDownCups(with cellIndex : Int)
    func countUpCups(with cellIndex : Int)
}


class CartTableViewCell: UITableViewCell {

    var delegate : CartTableDelegate?
    
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkOrderLabel: UILabel!
    @IBOutlet weak var drinkCupLabel: UILabel!
    @IBOutlet weak var tipdownButton: UIButton!
    @IBOutlet weak var tipupButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    @IBAction func addDrinkCup(_ sender: UIButton) {
        delegate?.countUpCups(with: sender.tag)
    }
    
    @IBAction func minusDrinkCup(_ sender: UIButton) {
        delegate?.countDownCups(with: sender.tag)
    }
    
    
}
