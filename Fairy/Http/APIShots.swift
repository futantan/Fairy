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
    static let token = "f12356ed02da3b0734617cad02791f6af03c9b4f486e2c107a7a4c6c28c70b9b"
//    page=\(page)&per_page=50
    /// List shots
    case ListShots(page: Int, list: ShotType, timeframe: TimeFrameType, date: String, sort: SortType)
    
//    /// Get a shot get
//    case GetShot
//    
//    /// Create a shot post
//    case CreateShot
//    
//    /// Update a shot post
//    case UpdateShot
//
//    /// Delete a shot DELETE
//    case DeleteShot
    
    var method: Alamofire.Method {
      switch self {
      case .ListShots:
        return .GET
      }
    }
    
    var URLRequest: NSMutableURLRequest {
      let result: (path: String, parameters: [String: AnyObject]) = {
        switch self {
        case .ListShots(let page, let list, let timeframe, let date, let sort):
          return ("/shots", ["page": page, "list": list.rawValue, "timeframe": timeframe.rawValue, "date": date, "sort": sort.rawValue])
        }
      }()
      
      let URL = NSURL(string: Router.basrURLString)!
      let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
      mutableURLRequest.HTTPMethod = method.rawValue
      mutableURLRequest.setValue("Bearer \(Router.token)", forHTTPHeaderField: "Authorization")
      
      return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: removeEmptyParameterInDict(result.parameters)).0
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


/// 去除字典中值为空(string 为 "")的键值对
private func removeEmptyParameterInDict(var dict: [String: AnyObject]) -> [String: AnyObject] {
  for (key, value) in dict {
    if value as? String == "" {
      dict.removeValueForKey(key)
    }
  }
  return dict
}
