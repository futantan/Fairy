//
//  DribbbleLinks.swift
//  Fairy
//
//  Created by luckytantanfu on 2/6/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation


struct DribbbleLinks: ResponseObjectSerializable {
  let web: String?
  let twitter: String?
  
  init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.web = representation.valueForKey("web") as? String
    self.twitter = representation.valueForKey("twitter") as? String
  }
}