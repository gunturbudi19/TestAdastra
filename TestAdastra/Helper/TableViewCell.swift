//
//  TableViewCell.swift
//  TestAdastra
//
//  Created by Guntur Budi on 02/11/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet var lblNameToDo: UILabel!
    @IBOutlet var lblCategoryToDo: UILabel!
    @IBOutlet var lblDateToDo: UILabel!
    @IBOutlet var viewBG: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
