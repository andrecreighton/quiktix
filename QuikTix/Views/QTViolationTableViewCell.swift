//
//  QTViolationTableViewCell.swift
//  QuikTix
//
//  Created by Andre Creighton on 1/20/19.
//  Copyright © 2019 Andre Creighton. All rights reserved.
//

import UIKit

class QTViolationTableViewCell: UITableViewCell {

  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var amountDueLabel: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
