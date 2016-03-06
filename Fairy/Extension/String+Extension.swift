//
//  String+Extension.swift
//  Fairy
//
//  Created by luckytantanfu on 3/6/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation


extension String {
  func attributeHtmlString() -> NSAttributedString? {
    do {
      let attributeString = try NSAttributedString(data: self.dataUsingEncoding(NSUnicodeStringEncoding)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
      return attributeString
    } catch {
      return nil
    }
  }
}