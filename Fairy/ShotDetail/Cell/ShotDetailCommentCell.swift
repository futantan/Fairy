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
      
      let comment = commentModel.body
      
      avatarImageView.kf_setImageWithURL(NSURL(string: commentModel.user!.avatar_url)!, placeholderImage: nil)
      userNameLabel.text = commentModel.user!.username
      commentLabel.attributedText = commentModel.commentAttributesBody
      
      let htmlPath = NSBundle.mainBundle().pathForResource("comment", ofType: ".html")!
      
      do {
        let htmlString = try String(contentsOfFile: htmlPath, encoding: NSUTF8StringEncoding)
        let descriptionHtmlString = htmlString.stringByReplacingOccurrencesOfString("#comment", withString: comment)
        let stringWithHtmlAttributes = NSMutableAttributedString()
        try stringWithHtmlAttributes.readFromData(descriptionHtmlString.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        commentLabel.attributedText = stringWithHtmlAttributes
      } catch let error as NSError {
        print(error.description)
      }
      
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
