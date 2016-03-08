//
//  ShotDetailDescriptionCell.swift
//  Fairy
//
//  Created by luckytantanfu on 2/26/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit

class ShotDetailDescriptionCell: UITableViewCell {
  
  @IBOutlet weak var descriptionTextView: UITextView!
  
  var model: DribbbleShotModel? {
    didSet {
      guard let model = model else { return }
      
      descriptionTextView.attributedText = model.shotAttributesDescription
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
