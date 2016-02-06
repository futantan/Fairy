//
//  ShotsCollectionViewController.swift
//  Fairy
//
//  Created by luckytantanfu on 2/4/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class ShotsCollectionViewController: UICollectionViewController {
  
  var populatingCells = false // 是否正在加载
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    populateCells()
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
    
    cell.layer.cornerRadius = 2
    
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
    return UIEdgeInsetsMake(24, 14, 0, 14)
  }
}

// MARK: - Helper
extension ShotsCollectionViewController {
  private func setupView() {
    guard let collectionView = self.collectionView else { return }
    let layout = UICollectionViewFlowLayout()
    // set size
    let itemWidth = (view.bounds.size.width - 14 * 2 - 16) / 2
    // (宽度-10)/(高度-10) = 4/3
    layout.itemSize = CGSize(width: itemWidth, height: (itemWidth - 10) * 3 / 4 + 10)
    
    layout.minimumInteritemSpacing = 16.0
    layout.minimumLineSpacing = 14.0
    
    layout.footerReferenceSize = CGSize(width: collectionView.bounds.size.width, height: 100.0)
    
    collectionView.collectionViewLayout = layout
    collectionView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1)
    collectionView.alwaysBounceVertical = true
  }
  
  func populateCells() {
    // 防止还在加载当前界面时加载下一个页面
    guard !populatingCells else { return }
    populatingCells = true
    
    Alamofire.request(APIShots.Router.ListShots(list: .Default, timeframe: .Default, date: "", sort: .Default)).responseJSON { (response) -> Void in
      print(response.result.value)
    }
    
//    Alamofire.request(DayDayUp.Router.TipArticleList(currentPage)).responseObject {
//      (response: Response<ArticleListModel, NSError>) in
//      func failed() { self.populatingCells = false }
//      guard let articleListModel = response.result.value else { failed(); return }
//      if response.result.error != nil { failed(); return }
//      
//      let lastItem = self.articles.count
//      let cellModels = articleListModel.data?.items ?? []
//      self.articles.appendContentsOf(cellModels)
//      let indexPaths = (lastItem..<self.articles.count).map { NSIndexPath(forItem: $0, inSection: 0) }
//      
//      dispatch_async(dispatch_get_main_queue()) {
//        self.refreshControl.endRefreshing()
//        self.collectionView!.insertItemsAtIndexPaths(indexPaths)
//      }
//      
//      self.currentPage++
//      self.populatingCells = false
//    }
  }
}
