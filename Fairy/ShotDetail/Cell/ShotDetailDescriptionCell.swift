//
//  ShotDetailDescriptionCell.swift
//  Fairy
//
//  Created by luckytantanfu on 2/26/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit

class ShotDetailDescriptionCell: UITableViewCell {
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  var model: DribbbleShotModel? {
    didSet {
      guard let model = model else { return }
      
      descriptionLabel.text = model.description
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
