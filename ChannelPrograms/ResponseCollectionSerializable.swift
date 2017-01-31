////
////  ResponseCollectionSerializable.swift
////  ChannelPrograms
////
////  Created by Kolya on 31.01.17.
////  Copyright © 2017 Kolya. All rights reserved.
////
//
//import Foundation
//import Alamofire
//
//public protocol ResponseObjectSerializable {
//    init?(response: HTTPURLResponse, representation: AnyObject)
//}
//
//extension Request {
//    public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
//        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
//            guard error == nil else { return .failure(error!) }
//            
//            let JSONResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
//            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
//            
//            switch result {
//            case .Success(_):
//                if let
//                    response = response,
//                    let responseObject = T(response: response, representation: value)
//                {
//                    return .Success(responseObject)
//                } else {
//                    let failureReason = "JSON could not be serialized into response object: \(value)"
//                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
//                    return .Failure(error)
//                }
//            case .Failure(let error):
//                return .Failure(error)
//            }
//        }
//        
//        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
//    }
//}
//
//public protocol ResponseCollectionSerializable {
//    static func collection(response: HTTPURLResponse, representation: AnyObject) -> [Self]
//}
//
//extension  Alamofire.DataRequest {
//    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
//        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
//            guard error == nil else { return .failure(error!) }
//            
//            let JSONSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
//            let result = JSONSerializer.serializeResponse(request, response, data, error)
//            
//            switch result {
//            case .Success(let value):
//                if let response = response {
//                    return .Success(T.collection(response: response, representation: value))
//                } else {
//                    let failureReason = "Response collection could not be serialized due to nil response"
//                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
//                    return .Failure(error)
//                }
//            case .Failure(let error):
//                return .Failure(error)
//            }
//        }
//        
//        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
//    }
//}
