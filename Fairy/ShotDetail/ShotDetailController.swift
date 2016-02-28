//
//  ShotDetailController.swift
//  Fairy
//
//  Created by luckytantanfu on 2/25/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit
import Alamofire

class ShotDetailController: UITableViewController {
  
  var shotModel: DribbbleShotModel?
  var commentsArray = [DribbbleCommentModel]()
  
  @IBOutlet weak var shotImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    registerCells()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  enum ShotDetailSection: Int {
    /// 设计者的信息
    case DesignerInfo = 0
    /// Shot 图片
    case Shot
    /// Like | Comment | Bucket
    case ShotInfo
    /// 描述信息
    case Description
    /// Comment Header
    case CommentHeader
    /// Comments
    case Comments
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 6
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let section = ShotDetailSection(rawValue: section)!
    switch section {
    case .DesignerInfo, .Shot, .ShotInfo, .Description, .CommentHeader:
      return 1
    case .Comments:
      return commentsArray.count
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let section = ShotDetailSection(rawValue: indexPath.section)!
    switch section {
      
    case .DesignerInfo:
      let cell = tableView.dequeueReusableCellWithIdentifier(String(ShotDetailDesignerInfoCell), forIndexPath: indexPath) as! ShotDetailDesignerInfoCell
      cell.model = shotModel
      return cell
      
    case .Shot:
      let cell = tableView.dequeueReusableCellWithIdentifier(String(ShotDetailHeaderImageCell), forIndexPath: indexPath) as! ShotDetailHeaderImageCell
      cell.shotImageView.kf_setImageWithURL(shotModel!.images.maxURL(), placeholderImage: nil)
      return cell
      
    case .ShotInfo:
      let cell = tableView.dequeueReusableCellWithIdentifier(String(ShotInfoCell), forIndexPath: indexPath) as! ShotInfoCell
      cell.model = shotModel
      return cell
      
    case .Description:
      let cell = tableView.dequeueReusableCellWithIdentifier(String(ShotDetailDescriptionCell), forIndexPath: indexPath) as! ShotDetailDescriptionCell
      cell.model = shotModel
      return cell
    case .CommentHeader:
      let cell = UITableViewCell()
      cell.textLabel?.text = "comment"
      return cell
    case .Comments:
      let cell = tableView.dequeueReusableCellWithIdentifier(String(ShotDetailCommentCell), forIndexPath: indexPath) as! ShotDetailCommentCell
      cell.model = commentsArray[indexPath.row]
      return cell
    }
    
  }
  
}

// MARK: - Helper
extension ShotDetailController {
  private func setupViews() {
    tableView.estimatedRowHeight = 44.0
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.separatorStyle = .None
  }
  
  private func registerCells() {
    tableView.registerNib(UINib(nibName: String(ShotDetailDesignerInfoCell), bundle: nil), forCellReuseIdentifier: String(ShotDetailDesignerInfoCell))
    tableView.registerNib(UINib(nibName: String(ShotDetailHeaderImageCell), bundle: nil), forCellReuseIdentifier: String(ShotDetailHeaderImageCell))
    tableView.registerNib(UINib(nibName: String(ShotInfoCell), bundle: nil), forCellReuseIdentifier: String(ShotInfoCell))
    tableView.registerNib(UINib(nibName: String(ShotDetailDescriptionCell), bundle: nil), forCellReuseIdentifier: String(ShotDetailDescriptionCell))
  }
  
  private func loadComments() {
//    Alamofire.request(DribbbleAPI.Router.ListShots(page: currentPage, list: .Default, timeframe: .Default, date: "", sort: .Default)).responseCollection { (response: Response<[DribbbleShotModel], NSError>) in
//      func failed() { self.populatingCells = false }
//      guard let shotsModels = response.result.value else { failed(); return }
//      if response .result.error != nil { failed(); return }
//      
//      let lastItem = self.shotsArray.count
//      self.shotsArray.appendContentsOf(shotsModels)
//      let indexPaths = (lastItem..<self.shotsArray.count).map { NSIndexPath(forItem: $0, inSection: 0) }
//      
//      dispatch_async(dispatch_get_main_queue()) {
//        self.collectionView!.insertItemsAtIndexPaths(indexPaths)
//      }
//      self.currentPage++
//      self.populatingCells = false
//    }
  }
}