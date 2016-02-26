//
//  DribbbleShotModel.swift
//  Fairy
//
//  Created by luckytantanfu on 2/5/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation


struct DribbbleShotModel: ResponseObjectSerializable, ResponseCollectionSerializable {
  let id: Int
  let title: String
  let description: String?
  let width: Int
  let height: Int
  let images: DribbbleImages
  let views_count: Int
  let likes_count: Int
  let comments_count: Int
  let attachments_count: Int
  let rebounds_count: Int
  let buckets_count: Int
  let created_at: String
  let updated_at: String
  let html_url: String
  let attachments_url: String
  let buckets_url: String
  let comments_url: String
  let likes_url: String
  let projects_url: String
  let rebounds_url: String // 可能为null
  let rebound_source_url: String?
  let animated: Bool
  let tags: [String]?
  let user: DribbbleUserModel
  let team: DribbbleTeamModel? //可以为null

  init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.id = representation.valueForKeyPath("id") as! Int
    self.title = representation.valueForKeyPath("title") as! String
    self.description = representation.valueForKeyPath("description") as? String
    self.width = representation.valueForKeyPath("width") as! Int
    self.height = representation.valueForKeyPath("height") as! Int
    self.images = DribbbleImages(response: response, representation: representation.valueForKeyPath("images")!)!
    self.views_count = representation.valueForKeyPath("views_count") as! Int
    self.likes_count = representation.valueForKeyPath("likes_count") as! Int
    self.comments_count = representation.valueForKeyPath("comments_count") as! Int
    self.attachments_count = representation.valueForKeyPath("attachments_count") as! Int
    self.rebounds_count = representation.valueForKeyPath("rebounds_count") as! Int
    self.buckets_count = representation.valueForKeyPath("buckets_count") as! Int
    self.created_at = representation.valueForKeyPath("created_at") as! String
    self.updated_at = representation.valueForKeyPath("updated_at") as! String
    self.html_url = representation.valueForKeyPath("html_url") as! String
    self.attachments_url = representation.valueForKeyPath("attachments_url") as! String
    self.buckets_url = representation.valueForKeyPath("buckets_url") as! String
    self.comments_url = representation.valueForKeyPath("comments_url") as! String
    self.likes_url = representation.valueForKeyPath("likes_url") as! String
    self.projects_url = representation.valueForKeyPath("projects_url") as! String
    self.rebounds_url = representation.valueForKeyPath("rebounds_url") as! String
    self.rebound_source_url = representation.valueForKeyPath("rebound_source_url") as? String
    self.animated = representation.valueForKeyPath("animated") as! Bool
    self.tags = representation.valueForKeyPath("tags") as? [String]
    self.user = DribbbleUserModel(response: response, representation: representation.valueForKeyPath("user")!)!
    let teamRepresentation = representation.valueForKeyPath("team")
    if teamRepresentation is NSNull {
      self.team = nil
    } else {
      self.team = DribbbleTeamModel(response: response, representation: teamRepresentation!)
    }
  }
  
  static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [DribbbleShotModel] {
    var shotModels: [DribbbleShotModel] = []
    
    if let representation = representation as? [[String: AnyObject]] {
      for shotRepresentation in representation {
        if let shotModel = DribbbleShotModel(response: response, representation: shotRepresentation) {
          shotModels.append(shotModel)
        }
      }
    }
    
    return shotModels
  }
}
