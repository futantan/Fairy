//
//  Log.swift
//  Fairy
//
//  Created by luckytantanfu on 3/4/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation


func printLog<T>(message: T, file: String = __FILE__, method: String = __FUNCTION__, line: Int = __LINE__) {
  #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
  #endif
}