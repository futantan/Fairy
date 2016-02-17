//
//  DribbbleImages.swift
//  Fairy
//
//  Created by luckytantanfu on 2/6/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation


struct DribbbleImages: ResponseObjectSerializable {
  let hidpi: String?
  let normal: String
  let teaser: String
  
  init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.hidpi = representation.valueForKeyPath("hidpi") as? String
    self.normal = representation.valueForKeyPath("normal") as! String
    self.teaser = representation.valueForKeyPath("teaser") as! String
  }
  
  func maxImageURL() -> NSURL {
    // TODO: - 图片逻辑修改
//    let result = hidpi ?? normal
    return NSURL(string: teaser)!
  }
}