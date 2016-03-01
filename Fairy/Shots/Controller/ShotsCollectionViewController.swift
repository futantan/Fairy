//
//  ShotsCollectionViewController.swift
//  Fairy
//
//  Created by luckytantanfu on 2/4/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit
import Alamofire


private let CellMarginTop: CGFloat = 24.0
private let CellMarginLeft: CGFloat = 14.0
private let CellItemsMargin: CGFloat = 16.0

class ShotsCollectionViewController: UICollectionViewController {
  
  var refreshView: PullToRefreshView!
  
  // data source
  var shotsArray: [DribbbleShotModel] = []
  var populatingCells = false // 是否正在加载
  var currentPage = 0
  
  var isLarge = false
  
  var netRequest: Alamofire.Request?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    populateCells()
    setup3DTouch()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetailShot" {
      let detailShotVC = segue.destinationViewController as! ShotDetailController
      let indexPath = sender as! NSIndexPath
      detailShotVC.shotModel = shotsArray[indexPath.row]
    }
  }
  
}

// MARK: - Target-Action
extension ShotsCollectionViewController {
  
  @IBAction func changeDisplayMode(sender: UIBarButtonItem) {
    isLarge = !isLarge
    collectionView?.performBatchUpdates(nil, completion: nil)
  }
}

// MARK: - UICollectionViewDataSource
extension ShotsCollectionViewController {
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return shotsArray.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(ShotsCollectionViewCell), forIndexPath: indexPath) as! ShotsCollectionViewCell
    
    cell.shotsCollectionCellModel = ShotsCollectionCellViewModel(dribbbleShotsModel: shotsArray[indexPath.row])
    
    // the last cell
    if (shotsArray.count-1 == indexPath.row) {
      populateCells()
    }
    
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: String(ShotsFooterCollectionReusableView), forIndexPath: indexPath)
  }
}

// MARK: - UICollectionViewDelegate
extension ShotsCollectionViewController {
  override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    (cell as! ShotsCollectionViewCell).cancelDownloadTask()
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("showDetailShot", sender: indexPath)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShotsCollectionViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let num: CGFloat = isLarge ? 1.0 : 2.0
    
    let itemWidth = (view.bounds.size.width - CellMarginLeft * 2 - CellItemsMargin) / num
    // (宽度-10)/(高度-10) = 4/3 10为两个border宽度
    let itemSize = CGSize(width: itemWidth, height: (itemWidth - 10) * 3 / 4 + 10)
    
    return itemSize
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 14.0
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return CellItemsMargin
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return UIEdgeInsetsMake(CellMarginTop, CellMarginLeft, 0, CellMarginLeft)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.bounds.size.width, height: 50.0)
  }
  
}

// MARK: - UIScrollViewDelegate
extension ShotsCollectionViewController {
  override func scrollViewDidScroll(scrollView: UIScrollView) {
    refreshView.scrollViewDidScroll(scrollView)
  }

  override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
  }
}

// MARK: - PullToRefreshViewDelegate

extension ShotsCollectionViewController: PullToRefreshViewDelegate {
  func pulllToRefreshViewDidRefresh(pulllToRefreshView: PullToRefreshView) {
      refreshCells()
  }
  
  func scrollView() -> UIScrollView {
    return collectionView!
  }
}

// MARK: - Helper
extension ShotsCollectionViewController {
  private func setupView() {
    guard let collectionView = self.collectionView else { return }
    
    collectionView.registerClass(ShotsFooterCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: String(ShotsFooterCollectionReusableView))
    
    collectionView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1)
    collectionView.alwaysBounceVertical = true
    
    addPullToRefreshView(collectionView)
  }
  
  private func addPullToRefreshView(collectionView: UICollectionView) {
    let kRefreshViewHeight: CGFloat = 80
    let refreshFrame = CGRectMake(0, -kRefreshViewHeight, CGRectGetWidth(view.frame), kRefreshViewHeight)
    refreshView = PullToRefreshView(frame: refreshFrame)
    collectionView.addSubview(refreshView)
    refreshView.delegate = self
  }
  
  private func refreshCells() {
    netRequest?.cancel()
    currentPage = 0
    populateCells(shouldClearData: true) {
      self.refreshView.endRefreshing()
    }
  }
  
  private func populateCells(shouldClearData shouldClearData: Bool = false, completed: (Void -> Void)? = nil) {
    // 防止还在加载当前界面时加载下一个页面
    guard !populatingCells else { return }
    
    populatingCells = true
    currentPage++
    
    netRequest = Alamofire.request(DribbbleAPI.Router.ListShots(page: currentPage, list: .Default, timeframe: .Default, date: "", sort: .Default)).responseCollection { (response: Response<[DribbbleShotModel], NSError>) in
      func failed() { self.populatingCells = false; print("failed") }
      guard let shotsModels = response.result.value else { failed(); return }
      if response .result.error != nil { failed(); return }
      
      if shouldClearData {
        self.shotsArray.removeAll()
      }
      
      let lastItem = self.shotsArray.count
      self.shotsArray.appendContentsOf(shotsModels)
      let indexPaths = (lastItem..<self.shotsArray.count).map { NSIndexPath(forItem: $0, inSection: 0) }
      
      dispatch_async(dispatch_get_main_queue()) {
        
        if shouldClearData {
          self.collectionView?.reloadData()
        } else {
          self.collectionView?.insertItemsAtIndexPaths(indexPaths)
        }

        completed?()
      }
      self.currentPage++
      self.populatingCells = false
    }
  }
  
  private func setup3DTouch() {
    if #available(iOS 9.0, *) {
      if traitCollection.forceTouchCapability == .Available {
        registerForPreviewingWithDelegate(self, sourceView: collectionView!)
      }
    }
  }
}

// MARK: - Peek & Pop
@available(iOS 9.0, *)
extension ShotsCollectionViewController: UIViewControllerPreviewingDelegate {
  func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    guard let indexPath = collectionView!.indexPathForItemAtPoint(location),
      cell = collectionView!.cellForItemAtIndexPath(indexPath) as? ShotsCollectionViewCell
      else { return nil}
    
    let identifier = String(ShotDetailController)
    guard let detailVC = storyboard?.instantiateViewControllerWithIdentifier(identifier) as? ShotDetailController else { return nil }
    detailVC.shotModel = shotsArray[indexPath.row]
    
    previewingContext.sourceRect = cell.frame
    
    return detailVC
  }
  
  func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
    showViewController(viewControllerToCommit, sender: self)
  }
}
