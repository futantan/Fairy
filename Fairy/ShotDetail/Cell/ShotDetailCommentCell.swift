//
//  ShotDetailCommentCell.swift
//  Fairy
//
//  Created by luckytantanfu on 2/28/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit

class ShotDetailCommentCell: UITableViewCell {
  
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  
  var model: DribbbleCommentModel? {
    didSet {
      guard let commentModel = model else { return }
      
      avatarImageView.kf_setImageWithURL(NSURL(string: commentModel.user!.avatar_url)!, placeholderImage: nil)
      userNameLabel.text = commentModel.user!.username
      commentLabel.attributedText = commentModel.commentAttributesBody  
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    avatarImageView.layer.masksToBounds = true
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
