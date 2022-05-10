//
//  OrderTableViewCell.swift
//  StoreApp
//
//  Created by 林祐辰 on 2022/5/9.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
