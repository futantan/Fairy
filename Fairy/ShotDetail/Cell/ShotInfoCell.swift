//
//  ShotInfoCell.swift
//  Fairy
//
//  Created by luckytantanfu on 2/26/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit

class ShotInfoCell: UITableViewCell {
  
  @IBOutlet weak var faviConImageView: UIImageView!
  @IBOutlet weak var favNumLabel: UILabel!
  @IBOutlet weak var commentNumLabel: UILabel!
  
  var model: DribbbleShotModel? {
    didSet {
      guard let model = model else { return }
      
      favNumLabel.text = "\(model.likes_count)"
      commentNumLabel.text = "\(model.comments_count)"
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
  
  @IBAction func likeContainerPressed(sender: AnyObject) {
    print("like")
  }
  
  @IBAction func commentContainerPressed(sender: AnyObject) {
    print("comment")
  }
  
  @IBAction func bucketContainerPressed(sender: AnyObject) {
    print("bucket")
  }
  

  
  
  
}
