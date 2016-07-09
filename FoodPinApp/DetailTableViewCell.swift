//
//  DetailTableViewCell.swift
//  FoodPinApp
//
//  Created by 随随意 on 16/7/7.
//  Copyright © 2016年 随随意. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var fieldLable: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var mapBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        mapBtn.hidden = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
