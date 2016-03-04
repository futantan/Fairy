//
//  DribbbleImages.swift
//  Fairy
//
//  Created by luckytantanfu on 2/6/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation
import RealmSwift


final class DribbbleImages: Object {
  dynamic var hidpi: String?
  dynamic var normal: String = ""
  dynamic var teaser: String = ""
  
  func maxURL() -> NSURL {
    let result = hidpi ?? normal
    return NSURL(string: result)!
  }
  
  func imageURL(animated: Bool) -> NSURL {
//    if (animated) {
//      let result = hidpi ?? normal
//      return NSURL(string: result)!
//    } else {
//      return NSURL(string: normal)!
//    }
      return NSURL(string: teaser)!
  }
}

extension DribbbleImages: ResponseObjectSerializable {
  convenience init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.init()
    self.hidpi = representation.valueForKeyPath("hidpi") as? String
    self.normal = representation.valueForKeyPath("normal") as! String
    self.teaser = representation.valueForKeyPath("teaser") as! String
  }
}