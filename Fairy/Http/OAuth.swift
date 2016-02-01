//
//  OAuth.swift
//  Fairy
//
//  Created by luckytantanfu on 2/1/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation
import Alamofire


struct OAuth {
  enum Router: URLRequestConvertible {
    
    static let BaseURLString = "https://dribbble.com/oauth/authorize"
    
    /// The client ID you received from Dribbble when you registered.
    static let ClientID = "51ecb3932913eb100bd41aa27be3b0627358e8af8a55b50fda95f07b8c57e48e"
    
    /// The URL in your application where users will be sent after authorization.
    static let RedirectURI = "FTFairy://oauth"
    
    static let Scope = "public+comment+write"
    
    /// OAuth url
    case OAuthURL
    
    // MARK: - URLRequestConvertible
    var URLRequest: NSMutableURLRequest  {
      let result: (path: String, parameters: [String: AnyObject])  = {
        switch self {
        case .OAuthURL:
          return ("/", ["client_id": Router.ClientID, "redirect_uri": Router.RedirectURI, "scope": Router.Scope])
        }
      }()
      
      let URL = NSURL(string: Router.BaseURLString)!
      let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
      let encoding = Alamofire.ParameterEncoding.URL

      return encoding.encode(URLRequest, parameters: result.parameters).0
    }
  }
}