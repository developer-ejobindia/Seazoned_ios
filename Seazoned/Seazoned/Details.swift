//
//  Details.swift
//
//  Created by Vaibhav Jhaveri on 17/07/17
//  Copyright (c) Varshaa Weblabs. All rights reserved.
//

import Foundation

import SwiftyJSON

public class Details: NSObject, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
//    "id": 11,
//    "user_id": 13,
//    "first_name": "Sauvik",
//    "last_name": "Dey",
//    "email": "svkde@gmail.com",
//    "phone_number": "9874563210",
//    "date_of_birth": "2018-01-16",
//    "address": "12B Asutosh",
//    "city": "Kolkata",
//    "state": "WB",
//    "country": "80",
//    "profile_image": null,
//    "profile_id": 2,
//    "username": "svkde@gmail.com",
//    "password": "81dc9bdb52d04dc20036dbd8313ed055",
//    "user_type": "Users",
//    "active": 1
    
    private struct SerializationKeys {
        static let first_name = "first_name"
           static let last_name = "last_name"
         static let user_id = "user_id"
           static let email = "email"
           static let phone_number = "phone_number"
           static let date_of_birth = "date_of_birth"
           static let address = "address"
           static let city = "city"
           static let state = "state"
        static let profile_image = "profile_image"
           static let country = "country"
   static let user_type = "user_type"
          static let active = "active"
   
    }
    
    // MARK: Properties
    public var first_name: String?
    public var last_name: String?
    public var user_id: String?
    public var email: String?
    public var phone_number: String?
    public var date_of_birth: String?
    public var address: String?
    public var city: String?
    public var state: String?
    public var profile_image: String?
    public var country: String?
    public var user_type: String?
    public var active: String?
   
    
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
        first_name = json[SerializationKeys.first_name].string
        last_name   = json[SerializationKeys.last_name].string
        user_id = json[SerializationKeys.user_id].string
        email = json[SerializationKeys.email].string
        phone_number = json[SerializationKeys.phone_number].string
        date_of_birth = json[SerializationKeys.date_of_birth].string
        address = json[SerializationKeys.address].string
        city = json[SerializationKeys.city].string
        state = json[SerializationKeys.state].string
        profile_image = json[SerializationKeys.profile_image].string
        country = json[SerializationKeys.country].string
        user_type = json[SerializationKeys.user_type].string
        active = json[SerializationKeys.active].string
        
      
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = first_name { dictionary[SerializationKeys.first_name] = value }
    
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.first_name = aDecoder.decodeObject(forKey: SerializationKeys.first_name) as? String
     
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(first_name, forKey: SerializationKeys.first_name)
    
    }
    
}
