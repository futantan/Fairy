//
//  OAuth.swift
//  Fairy
//
//  Created by luckytantanfu on 2/1/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyUserDefaults


struct OAuth {
  private static let BaseURLString = "https://dribbble.com/oauth/authorize"
  private static let ClientID = "51ecb3932913eb100bd41aa27be3b0627358e8af8a55b50fda95f07b8c57e48e"
  private static let ClientSecret = "f8883c2598990a33fc8736e268b2aa48fc978b5ed8a4910de7aa21f454ee4eff"
  private static let RedirectURI = "FTFairy://oauth"
  
  private static let Scope = "public+comment+write"
  
  enum Router {
    /// OAuth url
    case OAuthURL
    
    /// access token
    case TokenURL
    
    var url: NSURL {
      switch self {
      case .OAuthURL:
        let urlString = "\(OAuth.BaseURLString)?client_id=\(OAuth.ClientID)&redirect_uri=\(OAuth.RedirectURI)&scope=\(OAuth.Scope)"
        return NSURL(string: urlString)!
        
      case .TokenURL:
        return NSURL(string: "https://dribbble.com/oauth/token")!
      }
    }
  }
  
  static func exchangeTokenWithCode(code: String, complete: (finish: Bool)->Void ) {
    let parameters = [
      "client_id": OAuth.ClientID,
      "client_secret": OAuth.ClientSecret,
      "code": code,
      "redirect_uri": OAuth.RedirectURI
    ]
    
    Alamofire.request(.POST, OAuth.Router.TokenURL.url, parameters: parameters).responseJSON { response in
      if let json = response.result.value as? [String: AnyObject], access_token = json["access_token"] as? String {
        // 成功拿到 token 存储在 NSUserDefaults 中
        Defaults[.dribbbleToken] = access_token
        complete(finish: true)
        return
      }
      
      complete(finish: false)
    }
  }
}