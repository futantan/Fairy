//
//  APIShots.swift
//  Fairy
//
//  Created by luckytantanfu on 2/3/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation
import Alamofire


struct APIShots {
  enum Router: URLRequestConvertible {
    static let basrURLString = "https://api.dribbble.com/v1"
    
    /// List shots
    case ListShots(list: ShotType, timeframe: TimeFrameType, date: String, sort: SortType)
    
//    /// Get a shot
//    case GetShot
//    
//    /// Create a shot
//    case CreateShot
//    
//    /// Update a shot
//    case UpdateShot
//
//    /// Delete a shot
//    case DeleteShot
    
    var URLRequest: NSMutableURLRequest {
      let result: (path: String, parameters: [String: String]) = {
        switch self {
        case .ListShots(let list, let timeframe, let date, let sort):
          return ("/shots", ["list": list.rawValue, "timeframe": timeframe.rawValue, "date": date, "sort": sort.rawValue])
        }
      }()
      
      let URL = NSURL(string: Router.basrURLString)!
      let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
      let encoding = Alamofire.ParameterEncoding.URL
      
      return encoding.encode(URLRequest, parameters: removeEmptyParameterInDict(result.parameters)).0
    }
    
  }

}

// MARK: - APIShots List shots parameters type
extension APIShots.Router {
  /**
   Limit the results to a specific type with the following possible values
   
   - Default:     Results of any type
   - Animated:    Animated GIFs
   - Attachments: Shots with attachments
   - Debuts:
   - Playoffs:
   - Rebounds:
   - Teams:       Team shots
   */
  enum ShotType: String {
    case Default = ""
    case Animated = "animated"
    case Attachments = "attachments"
    case Debuts = "debuts"
    case Playoffs = "playoffs"
    case Rebounds = "rebounds"
    case Teams = "teams"
  }
  
  /**
   A period of time to limit the results to with the following possible values.
   Note that the value is ignored when sorting with recent.
   
   - Default: Results from now
   - Week:    This past week
   - Month:   This past month
   - Year:    This past year
   - Ever:    All time
   */
  enum TimeFrameType: String {
    case Default = ""
    case Week = "week"
    case Month = "month"
    case Year = "year"
    case Ever = "ever"
  }
  
  /**
   The sort field with the following possible values:
   
   - Default:  Results are sorted by popularity.
   - Comments: Most commented
   - Recent:
   - Views:    Most Viewed
   */
  enum SortType: String {
    case Default = ""
    case Comments = "comments"
    case Recent = "recent"
    case Views = "views"
  }
}

// MARK: - Helper

func removeEmptyParameterInDict(var dict: [String: String]) -> [String: String] {
  for (key, value) in dict {
    if value == "" {
      dict.removeValueForKey(key)
    }
  }
  return dict
}
