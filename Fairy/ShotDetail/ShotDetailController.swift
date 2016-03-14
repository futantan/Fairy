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
  
  var shotModel: DribbbleShotModel!
  var commentsArray = [DribbbleCommentModel]()
  
  @IBOutlet weak var shotImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    registerCells()
    loadComments()
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
    
    static var count: Int { return ShotDetailSection.Comments.rawValue + 1 }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return ShotDetailSection.count
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
      cell.shotImageView.kf_setImageWithURL(shotModel!.images!.maxURL(), placeholderImage: nil)
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
  
  // MARK: - Table view data source
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
}

// MARK: - Helper
extension ShotDetailController {
  private func setupViews() {
    tableView.estimatedRowHeight = 64.0
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.separatorStyle = .None
  }
  
  private func registerCells() {
    tableView.registerNib(UINib(nibName: String(ShotDetailDesignerInfoCell), bundle: nil), forCellReuseIdentifier: String(ShotDetailDesignerInfoCell))
    tableView.registerNib(UINib(nibName: String(ShotDetailHeaderImageCell), bundle: nil), forCellReuseIdentifier: String(ShotDetailHeaderImageCell))
    tableView.registerNib(UINib(nibName: String(ShotInfoCell), bundle: nil), forCellReuseIdentifier: String(ShotInfoCell))
    tableView.registerNib(UINib(nibName: String(ShotDetailDescriptionCell), bundle: nil), forCellReuseIdentifier: String(ShotDetailDescriptionCell))
    tableView.registerNib(UINib(nibName: String(ShotDetailCommentCell), bundle: nil), forCellReuseIdentifier: String(ShotDetailCommentCell))
  }
  
  private func loadComments() {
    Alamofire.request(DribbbleAPI.Router.ListCommentsOfShot(id: shotModel!.id)).responseCollection { (response: Response<[DribbbleCommentModel], NSError>) in
      func failed() { print(response.result.error) }
      
      guard let commentsModels = response.result.value else { failed(); return }
      self.commentsArray = commentsModels
      
      dispatch_async(dispatch_get_main_queue()) {
        self.tableView.reloadSections(NSIndexSet(index: ShotDetailSection.Comments.rawValue), withRowAnimation: .Fade)
      }
    }
  }
}