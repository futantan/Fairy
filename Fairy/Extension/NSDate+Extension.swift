//
//  NSDate+Extension.swift
//  Fairy
//
//  Created by luckytantanfu on 3/5/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation


extension NSDate {
  class func convertShotDateStringToNSDate(dateString: String) -> NSDate? {
    let stringToDateFormatter = NSDateFormatter()
    stringToDateFormatter.dateFormat = "yyyy-MM-dd'T'kk:mm:ssZ"
    return stringToDateFormatter.dateFromString(dateString)
  }
  
  class func convertShotDateToString(date: NSDate) -> String? {
    let dateToStringFormatter = NSDateFormatter()
    dateToStringFormatter.dateFormat = "MMM d, yyyy"
    return dateToStringFormatter.stringFromDate(date)
  }
}