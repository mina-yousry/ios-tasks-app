//
//  TaskTableViewCell.swift
//  Tasks App
//
//  Created by Admin on 6/29/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet var taskTitle: UILabel!
    @IBOutlet var taskDate: UILabel!
    @IBOutlet var colorImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
