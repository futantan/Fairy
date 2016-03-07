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
      guard let model = model, let shotDescription = model.shotDescription else { return }
      
      let htmlPath = NSBundle.mainBundle().pathForResource("shotDescription", ofType: ".html")!
      
      do {
        let htmlString = try String(contentsOfFile: htmlPath, encoding: NSUTF8StringEncoding)
        let descriptionHtmlString = htmlString.stringByReplacingOccurrencesOfString("#shotDescription", withString: shotDescription)
        let stringWithHtmlAttributes = NSMutableAttributedString()
        try stringWithHtmlAttributes.readFromData(descriptionHtmlString.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        descriptionLabel.attributedText = stringWithHtmlAttributes
      } catch let error as NSError {
        print(error.description)
      }
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
