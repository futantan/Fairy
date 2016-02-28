//
//  DribbbleCommentModel.swift
//  Fairy
//
//  Created by luckytantanfu on 2/28/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation


struct DribbbleCommentModel: ResponseObjectSerializable, ResponseCollectionSerializable {
  let id: Int
  let body: String
  let likes_count: Int
  let likes_url: String
  let created_at: String
  let updated_at: String
  let user: DribbbleUserModel

  init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.id = representation.valueForKeyPath("id") as! Int
    self.body = representation.valueForKeyPath("body") as! String
    self.likes_count = representation.valueForKeyPath("likes_count") as! Int
    self.likes_url = representation.valueForKeyPath("likes_url") as! String
    self.created_at = representation.valueForKeyPath("created_at") as! String
    self.updated_at = representation.valueForKeyPath("updated_at") as! String
    self.user = DribbbleUserModel(response: response, representation: representation.valueForKeyPath("user")!)!
  }
  
  static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [DribbbleCommentModel] {
    var commentModels: [DribbbleCommentModel] = []
    
    if let representation = representation as? [[String: AnyObject]] {
      for commentRepresentation in representation {
        if let commentModel = DribbbleCommentModel(response: response, representation: commentRepresentation) {
          commentModels.append(commentModel)
        }
      }
    }
    
    return commentModels
  }
}
