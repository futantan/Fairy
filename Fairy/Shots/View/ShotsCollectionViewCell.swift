//
//  ShotsCollectionViewCell.swift
//  Fairy
//
//  Created by luckytantanfu on 2/6/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit
import Kingfisher


class ShotsCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak private var shotsImageView: UIImageView!
  
  /// View Model
  var shotsCollectionCellModel: ShotsCollectionCellViewModel? {
    didSet {
      guard let model = shotsCollectionCellModel else { return }
      
      shotsImageView.kf_setImageWithURL(model.imageURL, placeholderImage: nil, optionsInfo: [.Transition(ImageTransition.FlipFromTop(0.5))], progressBlock: nil) { (image, error, cacheType, imageURL) -> () in
        print(error)
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configureCellStyle()
  }
  
}

// MARK: - Public API
extension ShotsCollectionViewCell {
  func cancelDownloadTask() {
    shotsImageView.kf_cancelDownloadTask()
  }
}

// MARK: - Helper
extension ShotsCollectionViewCell {
  private func configureCellStyle() {
    layer.cornerRadius = 2
    layer.masksToBounds = false
    layer.shadowOpacity = 0.1
    layer.shadowRadius = 2
    layer.shadowColor = UIColor.grayColor().CGColor
    layer.shadowOffset = CGSizeMake(0, 0)
    
    self.shotsImageView.kf_showIndicatorWhenLoading = true
  }
}