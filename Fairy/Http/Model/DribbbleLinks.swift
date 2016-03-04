//
//  DribbbleLinks.swift
//  Fairy
//
//  Created by luckytantanfu on 2/6/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation
import RealmSwift


final class DribbbleLinks: Object {
  dynamic var web: String?
  dynamic var twitter: String?
}

extension DribbbleLinks: ResponseObjectSerializable {
  convenience init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.init()
    self.web = representation.valueForKey("web") as? String
    self.twitter = representation.valueForKey("twitter") as? String
  }
}