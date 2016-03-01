//
//  PullToRefreshView.swift
//  Fairy
//
//  Created by luckytantanfu on 3/1/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit

protocol PullToRefreshViewDelegate: class {
  func pulllToRefreshViewDidRefresh(pulllToRefreshView: PullToRefreshView)
  func scrollView() -> UIScrollView
}

class PullToRefreshView: UIView {
  
  var progressPercentage: CGFloat = 0.0
  var isRefreshing = false
  
  weak var delegate: PullToRefreshViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor.greenColor()
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  // 在下拉过程中的动画
  func animateWithProgress(progress: CGFloat) {
  }
  
  // 下拉到一定程度之后，确认刷新的动画
  func animateWhileRefreshing() {
    isRefreshing = true
  }
  
  func beginRefreshing() {
    isRefreshing = true
    shouldRefreshViewBeLocked(true)
  }
  
  // 当刷新工作完成之后调用
  func endRefreshing() {
    isRefreshing = false
    shouldRefreshViewBeLocked(false)
  }
  
  func shouldRefreshViewBeLocked(shouldLock: Bool) {
    guard let scrollView = delegate?.scrollView()  else { return }
    
    var contentInset = scrollView.contentInset
    contentInset.top = shouldLock ? (contentInset.top + self.frame.size.height) : (contentInset.top - self.frame.size.height)
    scrollView.contentInset = contentInset
  }
  
}

extension PullToRefreshView: UIScrollViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    // 计算向下滑动了多少距离
    let offsetY = max(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0)
    self.progressPercentage = min(offsetY / frame.size.height, 1.0)
    
    if !isRefreshing {
      animateWithProgress(progressPercentage)
    }
  }
  
  func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if !isRefreshing && progressPercentage == 1.0 {
      shouldRefreshViewBeLocked(true)
      animateWhileRefreshing()
      delegate?.pulllToRefreshViewDidRefresh(self)
    }
  }
}
