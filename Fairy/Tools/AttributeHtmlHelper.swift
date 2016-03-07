//
//  AttributeHtmlHelper.swift
//  Fairy
//
//  Created by luckytantanfu on 3/7/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation


struct AttributeHtmlHelper {
  enum HtmlType: String {
    case Comment = "comment"
    case ShotDescription = "shotDescription"
  }
  
  static func attributedText(type: HtmlType, content: String) ->NSAttributedString? {
    let htmlPath = NSBundle.mainBundle().pathForResource(type.rawValue, ofType: ".html")!
    
    do {
      let htmlString = try String(contentsOfFile: htmlPath, encoding: NSUTF8StringEncoding)
      let descriptionHtmlString = htmlString.stringByReplacingOccurrencesOfString("#\(type.rawValue)", withString: content)
      let attributedString = NSMutableAttributedString()
      try attributedString.readFromData(descriptionHtmlString.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
      return attributedString
    } catch let error as NSError {
      print(error.description)
      return nil
    }
  }
}