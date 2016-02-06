//
//  DribbbleTeamModel.swift
//  Fairy
//
//  Created by luckytantanfu on 2/6/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation

struct DribbbleTeamModel: ResponseObjectSerializable {
  let id: Int
  let name: String
  let username: String
  let html_url: String
  let avatar_url: String
  let bio: String
  let location: String
  let links: DribbbleLinks
  let buckets_count: Int
  let comments_received_count: Int
  let followers_count: Int
  let followings_count: Int
  let likes_count: Int
  let likes_received_count: Int
  let members_count: Int
  let projects_count: Int
  let rebounds_received_count: Int
  let shots_count: Int
  let can_upload_shot: Bool
  let type: String
  let pro: Bool
  let buckets_url: String
  let followers_url: String
  let following_url: String
  let likes_url: String
  let projects_url: String
  let shots_url: String
  let members_url: String
  let team_shots_url: String
  let created_at: String
  let updated_at: String

  init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.id = representation.valueForKeyPath("id") as! Int
    self.name = representation.valueForKeyPath("name") as! String
    self.username = representation.valueForKeyPath("username") as! String
    self.html_url = representation.valueForKeyPath("html_url") as! String
    self.avatar_url = representation.valueForKeyPath("avatar_url") as! String
    self.bio = representation.valueForKeyPath("bio") as! String
    self.location = representation.valueForKeyPath("location") as! String
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
