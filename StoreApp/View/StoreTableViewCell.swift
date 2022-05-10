//
//  StoreTableViewCell.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/4/16.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    
    @IBOutlet weak var storeName: UILabel!
    
    @IBOutlet weak var storeAddress: UILabel!
    
    @IBOutlet weak var storeTelephoneNumber: UILabel!
    
    
    @IBOutlet weak var storeTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
