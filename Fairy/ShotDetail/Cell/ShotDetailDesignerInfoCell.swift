//
//  ShotDetailDesignerInfoCell.swift
//  Fairy
//
//  Created by luckytantanfu on 2/26/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit

class ShotDetailDesignerInfoCell: UITableViewCell {
  
  @IBOutlet weak var userAvatarImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  var model: DribbbleShotModel? {
    didSet {
      guard let model = model else { return }
      
      userAvatarImageView.kf_setImageWithURL(NSURL(string: model.user!.avatar_url)!, placeholderImage: nil)
      titleLabel.text = model.title
      userNameLabel.text = "by \(model.user!.username)"
      dateLabel.text = model.updated_at
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    userAvatarImageView.layer.cornerRadius = userAvatarImageView.bounds.width/2
    userAvatarImageView.layer.masksToBounds = true
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
