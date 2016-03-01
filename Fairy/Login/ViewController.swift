//
//  ViewController.swift
//  Fairy
//
//  Created by luckytantanfu on 2/1/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit
import SafariServices
import Alamofire

class ViewController: UIViewController {
//  var safariViewController: SFSafariViewController!

  override func viewDidLoad() {
    super.viewDidLoad()

    addObserverForNotification()
  }

  @IBAction func clicked(sender: AnyObject) {
//    safariViewController = SFSafariViewController(URL: OAuth.Router.OAuthURL.url)
//    self.presentViewController(safariViewController, animated: true, completion: nil)
  }

}

extension ViewController {
  func addObserverForNotification() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "fairyOAuthSuccessed", name: FairyNotification.LolitaToTimeLineNotification, object: nil)
  }
  
  func fairyOAuthSuccessed() {
//    if let safariViewController = safariViewController {
//      safariViewController.dismissViewControllerAnimated(true, completion: nil)
//    }
  }
}

