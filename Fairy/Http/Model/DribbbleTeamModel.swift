//
//  DribbbleTeamModel.swift
//  Fairy
//
//  Created by luckytantanfu on 2/6/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation
import RealmSwift


final class DribbbleTeamModel: Object {
  dynamic var id: Int = 0
  dynamic var name: String = ""
  dynamic var username: String = ""
  dynamic var html_url: String = ""
  dynamic var avatar_url: String = ""
  dynamic var bio: String = ""
  dynamic var location: String?
  dynamic var links: DribbbleLinks?
  dynamic var buckets_count: Int = 0
  dynamic var comments_received_count: Int = 0
  dynamic var followers_count: Int = 0
  dynamic var followings_count: Int = 0
  dynamic var likes_count: Int = 0
  dynamic var likes_received_count: Int = 0
  dynamic var members_count: Int = 0
  dynamic var projects_count: Int = 0
  dynamic var rebounds_received_count: Int = 0
  dynamic var shots_count: Int = 0
  dynamic var can_upload_shot: Bool = false
  dynamic var type: String = ""
  dynamic var pro: Bool = false
  dynamic var buckets_url: String = ""
  dynamic var followers_url: String = ""
  dynamic var following_url: String = ""
  dynamic var likes_url: String = ""
  dynamic var projects_url: String = ""
  dynamic var shots_url: String = ""
  dynamic var members_url: String = ""
  dynamic var team_shots_url: String = ""
  dynamic var created_at: String = ""
  dynamic var updated_at: String = ""
}

extension DribbbleTeamModel: ResponseObjectSerializable {
  convenience init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.init()
    self.id = representation.valueForKeyPath("id") as! Int
    self.name = representation.valueForKeyPath("name") as! String
    self.username = representation.valueForKeyPath("username") as! String
    self.html_url = representation.valueForKeyPath("html_url") as! String
    self.avatar_url = representation.valueForKeyPath("avatar_url") as! String
    self.bio = representation.valueForKeyPath("bio") as! String
    let locationRepresentation = representation.valueForKeyPath("location")
    if locationRepresentation is NSNull {
      self.location = nil
    } else {
      self.location = locationRepresentation as? String
    }
    self.links = DribbbleLinks(response: response, representation: representation.valueForKeyPath("links")!)!
    self.buckets_count = representation.valueForKeyPath("buckets_count") as! Int
    self.comments_received_count = representation.valueForKeyPath("comments_received_count") as! Int
    self.followers_count = representation.valueForKeyPath("followers_count") as! Int
    self.followings_count = representation.valueForKeyPath("followings_count") as! Int
    self.likes_count = representation.valueForKeyPath("likes_count") as! Int
    self.likes_received_count = representation.valueForKeyPath("likes_received_count") as! Int
    self.members_count = representation.valueForKeyPath("members_count") as! Int
    self.projects_count = representation.valueForKeyPath("projects_count") as! Int
    self.rebounds_received_count = representation.valueForKeyPath("rebounds_received_count") as! Int
    self.shots_count = representation.valueForKeyPath("shots_count") as! Int
    self.can_upload_shot = representation.valueForKeyPath("can_upload_shot") as! Bool
    self.type = representation.valueForKeyPath("type") as! String
    self.pro = representation.valueForKeyPath("pro") as! Bool
    self.buckets_url = representation.valueForKeyPath("buckets_url") as! String
    self.followers_url = representation.valueForKeyPath("followers_url") as! String
    self.following_url = representation.valueForKeyPath("following_url") as! String
    self.likes_url = representation.valueForKeyPath("likes_url") as! String
    self.projects_url = representation.valueForKeyPath("projects_url") as! String
    self.shots_url = representation.valueForKeyPath("shots_url") as! String
    self.members_url = representation.valueForKeyPath("members_url") as! String
    self.team_shots_url = representation.valueForKeyPath("team_shots_url") as! String
    self.created_at = representation.valueForKeyPath("created_at") as! String
    self.updated_at = representation.valueForKeyPath("updated_at") as! String
  }
}
