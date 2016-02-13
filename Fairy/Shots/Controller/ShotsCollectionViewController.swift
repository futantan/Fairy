//
//  ShotsCollectionViewController.swift
//  Fairy
//
//  Created by luckytantanfu on 2/4/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher


private let CellMarginTop: CGFloat = 24.0
private let CellMarginLeft: CGFloat = 14.0
private let CellItemsMargin: CGFloat = 16.0

class ShotsCollectionViewController: UICollectionViewController {
  // data source
  var shotsArray: [DribbbleShotsModel] = []
  var populatingCells = false // 是否正在加载
  var currentPage = 1
  
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
    return shotsArray.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(ShotsCollectionViewCell), forIndexPath: indexPath) as! ShotsCollectionViewCell
    
    cell.layer.cornerRadius = 2
    cell.layer.masksToBounds = false
    cell.layer.shadowOpacity = 0.1
    cell.layer.shadowRadius = 2
    cell.layer.shadowColor = UIColor.grayColor().CGColor
    cell.layer.shadowOffset = CGSizeMake(0, 0)
    
    cell.aaaimage.kf_setImageWithURL(shotsArray[indexPath.row].images.maxImageURL(), placeholderImage: nil)
    
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: String(ShotsFooterCollectionReusableView), forIndexPath: indexPath)
  }
}

// MARK: - UICollectionViewDelegate
extension ShotsCollectionViewController {
  
}

extension ShotsCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return UIEdgeInsetsMake(CellMarginTop, CellMarginLeft, 0, CellMarginLeft)
  }
}

// MARK: - Helper
extension ShotsCollectionViewController {
  private func setupView() {
    guard let collectionView = self.collectionView else { return }
    let layout = UICollectionViewFlowLayout()
    // set size
    let itemWidth = (view.bounds.size.width - CellMarginLeft * 2 - CellItemsMargin) / 2
    // (宽度-10)/(高度-10) = 4/3 10为两个border宽度
    layout.itemSize = CGSize(width: itemWidth, height: (itemWidth - 10) * 3 / 4 + 10)
    layout.minimumInteritemSpacing = CellItemsMargin
    layout.minimumLineSpacing = 14.0
    layout.footerReferenceSize = CGSize(width: collectionView.bounds.size.width, height: 50.0)
    
    collectionView.registerClass(ShotsFooterCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: String(ShotsFooterCollectionReusableView))
    
    collectionView.collectionViewLayout = layout
    collectionView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1)
    collectionView.alwaysBounceVertical = true
  }
  
  func populateCells() {
    // 防止还在加载当前界面时加载下一个页面
    guard !populatingCells else { return }
    populatingCells = true
    
    Alamofire.request(APIShots.Router.ListShots(page: 1, list: .Default, timeframe: .Default, date: "", sort: .Default)).responseCollection { (response: Response<[DribbbleShotsModel], NSError>) in
      func failed() { self.populatingCells = false }
      guard let shotsListModel = response.result.value else { failed(); return }
      if response .result.error != nil { failed(); return }
      
//      let lastItem = self.shotsArray.count
      self.shotsArray.appendContentsOf(shotsListModel)
//      let indexPaths = (0..<self.shotsArray.count).map { NSIndexPath(forItem: $0, inSection: 0) }
      
      dispatch_async(dispatch_get_main_queue()) {
        self.collectionView?.reloadData()
//        self.collectionView!.insertItemsAtIndexPaths(indexPaths)
      }
      self.currentPage++
      self.populatingCells = false
    }
  }
  
}
