//
//  RealmString.swift
//  Fairy
//
//  Created by luckytantanfu on 3/4/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation
import RealmSwift

class RealmString: Object {
  dynamic var stringValue = ""
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
