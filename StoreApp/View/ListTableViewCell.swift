//
//  ListTableViewCell.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/18.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkItemLabel: UILabel!
    @IBOutlet weak var mSizeLabel: UILabel!
    @IBOutlet weak var mPriceLabel: UILabel!
    @IBOutlet weak var lSizeLabel: UILabel!
    @IBOutlet weak var lPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
