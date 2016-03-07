//
//  DribbbleShotModel.swift
//  Fairy
//
//  Created by luckytantanfu on 2/5/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation
import RealmSwift


final class DribbbleShotModel: Object {
  dynamic var id: Int = 0
  dynamic var title: String = ""
  dynamic var shotDescription: String?
  dynamic var width: Int = 0
  dynamic var height: Int = 0
  dynamic var images: DribbbleImages?
  dynamic var views_count: Int = 0
  dynamic var likes_count: Int = 0
  dynamic var comments_count: Int = 0
  dynamic var attachments_count: Int = 0
  dynamic var rebounds_count: Int = 0
  dynamic var buckets_count: Int = 0
  dynamic var created_at: NSDate?
  dynamic var updated_at: NSDate?
  dynamic var html_url: String = ""
  dynamic var attachments_url: String = ""
  dynamic var buckets_url: String = ""
  dynamic var comments_url: String = ""
  dynamic var likes_url: String = ""
  dynamic var projects_url: String = ""
  dynamic var rebounds_url: String? // 可能为null
  dynamic var rebound_source_url: String? = ""
  dynamic var animated: Bool = false
  let _backingTags = List<RealmString>()
  dynamic var user: DribbbleUserModel?
  dynamic var team: DribbbleTeamModel? //可以为null = 0
  
  var tags: [String] {
    get {
      return _backingTags.map { $0.stringValue }
    }
    set {
      _backingTags.removeAll()
      _backingTags.appendContentsOf(newValue.map({ RealmString(value: [$0]) }))
    }
  }
  
  var shotAttributesDescription: NSAttributedString? {
    get {
      guard let shotDescription = shotDescription else { return nil }
      return AttributeHtmlHelper.attributedText(.ShotDescription, content: shotDescription)
    }
  }
  
  override static func ignoredProperties() -> [String] {
    return ["tags"]
  }
}

extension DribbbleShotModel: ResponseObjectSerializable, ResponseCollectionSerializable {
  convenience init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.init()
    self.id = representation.valueForKeyPath("id") as! Int
    self.title = representation.valueForKeyPath("title") as! String
    self.shotDescription = representation.valueForKeyPath("description") as? String
    self.width = representation.valueForKeyPath("width") as! Int
    self.height = representation.valueForKeyPath("height") as! Int
    self.images = DribbbleImages(response: response, representation: representation.valueForKeyPath("images")!)!
    self.views_count = representation.valueForKeyPath("views_count") as! Int
    self.likes_count = representation.valueForKeyPath("likes_count") as! Int
    self.comments_count = representation.valueForKeyPath("comments_count") as! Int
    self.attachments_count = representation.valueForKeyPath("attachments_count") as! Int
    self.rebounds_count = representation.valueForKeyPath("rebounds_count") as! Int
    self.buckets_count = representation.valueForKeyPath("buckets_count") as! Int
    let createDateString = representation.valueForKeyPath("created_at") as! String
    self.created_at = NSDate.convertShotDateStringToNSDate(createDateString)
    let updateDateString = representation.valueForKeyPath("updated_at") as! String
    self.updated_at = NSDate.convertShotDateStringToNSDate(updateDateString)
    self.html_url = representation.valueForKeyPath("html_url") as! String
    self.attachments_url = representation.valueForKeyPath("attachments_url") as! String
    self.buckets_url = representation.valueForKeyPath("buckets_url") as! String
    self.comments_url = representation.valueForKeyPath("comments_url") as! String
    self.likes_url = representation.valueForKeyPath("likes_url") as! String
    self.projects_url = representation.valueForKeyPath("projects_url") as! String
    self.rebounds_url = representation.valueForKeyPath("rebounds_url") as? String
    self.rebound_source_url = representation.valueForKeyPath("rebound_source_url") as? String
    self.animated = representation.valueForKeyPath("animated") as! Bool
    let tagsArr =  representation.valueForKeyPath("tags") as! [String]
    self._backingTags.appendContentsOf(tagsArr.map({ RealmString(value: [$0]) }))
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
