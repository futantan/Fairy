//
//  RealmManger.swift
//  Fairy
//
//  Created by luckytantanfu on 3/4/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation
import RealmSwift


private let shredInstance = RealmManager()

class RealmManager {
  class var sharedManager: RealmManager {
    return shredInstance
  }
  
  // TODO: - use thread
  func updateShotsModelInRealm(shotModels: [DribbbleShotModel]) {
    try! uiRealm.write {
      uiRealm.deleteAll()
      uiRealm.add(shotModels)
    }
  }
  
  func shotModelsInRealm() -> [DribbbleShotModel] {
    return Array(uiRealm.objects(DribbbleShotModel))
  }
}