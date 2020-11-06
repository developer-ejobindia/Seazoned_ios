//
//  Login.swift
//
//  Created by Vaibhav Jhaveri on 17/07/17
//  Copyright (c) Varshaa Weblabs. All rights reserved.
//

import Foundation

import SwiftyJSON

public class Login_data: NSObject, NSCoding {
  
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let token = "token"
        static let success = "success"
        static let msg = "msg"
         static let data1 = "data"
        
    }
    
    // MARK: Properties
    public var data1: Details?
    public var token: String?
    public var success: NSInteger?
     public var msg: String?
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
       data1 = Details(json: json[SerializationKeys.data1])
        success = json[SerializationKeys.success].intValue
        token = json[SerializationKeys.token].string
        msg = json[SerializationKeys.msg].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
      if let value = data1 { dictionary[SerializationKeys.data1] = value.dictionaryRepresentation() }
        if let value = success { dictionary[SerializationKeys.success] = value }
        if let value = token { dictionary[SerializationKeys.token] = value }
          if let value = msg { dictionary[SerializationKeys.msg] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
       self.data1 = aDecoder.decodeObject(forKey: SerializationKeys.data1) as? Details
        self.success = aDecoder.decodeObject(forKey: SerializationKeys.success) as? NSInteger
        self.token = aDecoder.decodeObject(forKey: SerializationKeys.token) as? String
        self.msg = aDecoder.decodeObject(forKey: SerializationKeys.msg) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(data1, forKey: SerializationKeys.data1)
        aCoder.encode(token, forKey: SerializationKeys.token)
        aCoder.encode(msg, forKey: SerializationKeys.msg)
        aCoder.encode(success, forKey: SerializationKeys.success)
    }
    
}
