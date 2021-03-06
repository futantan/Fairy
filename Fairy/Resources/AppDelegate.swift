//
//  AppDelegate.swift
//  Fairy
//
//  Created by luckytantanfu on 2/1/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

let uiRealm = try! Realm()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    BuddyBuildSDK.setup()
    
    // Override point for customization after application launch.
    return true
  }
  
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  
}


extension AppDelegate {
  func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    // 用户授权之后跳转到这，url 中会带有一个 code 参数，使用该参数来换取 access token
    guard let code = url.paramsInURL()["code"] else { return false}
    
    OAuth.exchangeTokenWithCode(code) { finished in
      // token 拿到之后，通知关闭浏览器界面
      if finished {
        NSNotificationCenter.defaultCenter().postNotificationName(FairyNotification.LolitaToTimeLineNotification, object: nil)
      } else {
        // TODO: 出错处理
      }
    }
    
    return true
  }
}
