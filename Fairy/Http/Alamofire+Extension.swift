//
//  Alamofire+Extension.swift
//  Fairy
//
//  Created by luckytantanfu on 2/3/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import Foundation
import Alamofire


// MARK: - Generic Response Object Serialization

/**
*  遵循该协议之后，就可以使用通用的 responseObject 方法来返回需要的对象类型
*/
public protocol ResponseObjectSerializable {
  init?(response: NSHTTPURLResponse, representation: AnyObject)
}

extension Request {
  public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
    let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
      guard error == nil else { return .Failure(error!) }
      
      let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
      let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
      
      switch result {
      case .Success(let value):
        if let
          response = response,
          responseObject = T(response: response, representation: value)
        {
          return .Success(responseObject)
        } else {
          let failureReason = "JSON could not be serialized into response object: \(value)"
          let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
          return .Failure(error)
        }
      case .Failure(let error):
        return .Failure(error)
      }
    }
    
    return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
  }
}


// MARK: - Generic Response Collection of Object Serialization

/**
*  遵循该协议之后，就可以使用通用的 responseCollection 方法来返回需要的对象类型的 collection
*/
public protocol ResponseCollectionSerializable {
  static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Self]
}

extension Alamofire.Request {
  public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
    let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
      guard error == nil else { return .Failure(error!) }
      
      let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
      let result = JSONSerializer.serializeResponse(request, response, data, error)
      
      switch result {
      case .Success(let value):
        if let response = response {
          return .Success(T.collection(response: response, representation: value))
        } else {
          let failureReason = "响应集合无法解析，因为服务器响应为空"
          let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
          return .Failure(error)
        }
      case .Failure(let error):
        return .Failure(error)
      }
    }
    
    return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
  }
}