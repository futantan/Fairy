//
//  ShotsCollectionCellViewModel.swift
//  Fairy
//
//  Created by luckytantanfu on 2/17/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation


struct ShotsCollectionCellViewModel {
  let imageURL: NSURL
  
  init(dribbbleShotsModel: DribbbleShotsModel) {
    self.imageURL = dribbbleShotsModel.images.imageURL(dribbbleShotsModel.animated)
  }
}