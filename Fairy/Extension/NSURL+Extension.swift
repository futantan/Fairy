//
//  NSURL+Extension.swift
//  Fairy
//
//  Created by luckytantanfu on 2/1/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation

extension NSURL {
  
  /**
   Return the params in url of the NSURL, format in dictionary
   */
  func paramsInURL() -> [String: String] {
    let paramKyeAndValueArray = self.query?.componentsSeparatedByString("&")
    var dictionary = [String: String]()
    
    for pairs in paramKyeAndValueArray ?? [] {
      let pair = pairs.componentsSeparatedByString("=")
      if pair.count == 2 {
        dictionary[pair[0]] = pair[1]
      }
    }
    return dictionary
  }
  
}