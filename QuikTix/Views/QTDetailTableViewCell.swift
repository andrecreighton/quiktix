//
//  QTDetailTableViewCell.swift
//  QuikTix
//
//  Created by Andre Creighton on 1/22/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit

class QTDetailTableViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
