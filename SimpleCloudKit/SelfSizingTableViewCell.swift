//
//  SelfSizingTableViewCell.swift
//  SimpleCloudKit
//
//  Created by Muhammad Syabran on 04/09/20.
//  Copyright © 2020 ADA. All rights reserved.
//

import UIKit

class SelfSizingTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
