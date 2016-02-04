//
//  ShotsCollectionViewController.swift
//  Fairy
//
//  Created by luckytantanfu on 2/4/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ShotsCollectionViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

// MARK: - UICollectionViewDataSource
extension ShotsCollectionViewController {
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
    cell.backgroundColor = UIColor.redColor()
    cell.layer.borderColor = UIColor.whiteColor().CGColor
    cell.layer.borderWidth = 5
    
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension ShotsCollectionViewController {
  /*
  // Uncomment this method to specify if the specified item should be highlighted during tracking
  override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return true
  }
  */
  
  /*
  // Uncomment this method to specify if the specified item should be selected
  override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return true
  }
  */
  
  /*
  // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
  override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return false
  }
  
  override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
  return false
  }
  
  override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
  
  }
  */
}

extension ShotsCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return UIEdgeInsetsMake(24, 19, 0, 19)
  }
}

// MARK: - Helper
extension ShotsCollectionViewController {
  private func setupView() {
    guard let collectionView = self.collectionView else { return }
    let layout = UICollectionViewFlowLayout()
    // set size
    let itemWidth = (view.bounds.size.width - 19 * 2 - 26) / 2
    layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 3 / 4)
    
    layout.minimumInteritemSpacing = 26.0
    layout.minimumLineSpacing = 24.0
    
    layout.footerReferenceSize = CGSize(width: collectionView.bounds.size.width, height: 100.0)
    
    collectionView.collectionViewLayout = layout
    collectionView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1)
    collectionView.alwaysBounceVertical = true
  }
}
