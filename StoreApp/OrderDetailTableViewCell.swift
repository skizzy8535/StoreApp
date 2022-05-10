//
//  OrderDetailTableViewCell.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/5/9.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkDetailLabel: UILabel!
    @IBOutlet weak var numberOfCupLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
