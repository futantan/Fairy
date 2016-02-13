//
//  ShotsFooterCollectionReusableView.swift
//  Fairy
//
//  Created by luckytantanfu on 2/9/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit

class ShotsFooterCollectionReusableView: UICollectionReusableView {
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    spinner.startAnimating()
    addSubview(spinner)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    spinner.center = self.center
    // TODO: - 24 is magic number use auto layout instead
    spinner.center.y -= CGFloat(24.0)
  }
}
