//
//  Deafults.swift
//  EstateBlock
//
//  Created by Dinesh Sailor on 12/30/16.
//  Copyright © 2016 Varshaa Weblabs. All rights reserved.
//

import Foundation
import Alamofire

//  MARK - Remove Default
func removeDefaults(forKey key: String) {
    UserDefaults.standard.removeObject(forKey: key)
}

// MARK: - Defaults String Values
func setString(_ strValue: String, forKey strKey: String) {
    UserDefaults.standard.setValue(strValue, forKey: strKey)
    UserDefaults.standard.synchronize()
}

func getString(forKey key: String) -> String {
    var s: String? = nil
    s = UserDefaults.standard.string(forKey: key)
    return s!
}

// MARK: - Defaults Int Values
func setInt(_ intValue: Int, forKey intKey: String) {
    UserDefaults.standard.set(intValue, forKey: intKey)
    UserDefaults.standard.synchronize()
}

func getInt(forKey key: String) -> Int {
    var i: Int = 0
    i = Int(UserDefaults.standard.integer(forKey: key))
    return i
}

// MARK: - Defaults Boolean Values
func setBoolean(_ booleanValue: Bool, forKey booleanKey: String) {
    UserDefaults.standard.set(booleanValue, forKey: booleanKey)
    UserDefaults.standard.synchronize()
}

func getBoolean(forKey key: String) -> Bool {
    var b: Bool = false
    b = UserDefaults.standard.bool(forKey: key)
    return b
}

// MARK: - Defaults Dictionary Values
func setDictionary(dictionaryValue: [String: AnyObject], ForKey dictionaryKey: String) {
    UserDefaults.standard.set(dictionaryValue, forKey: dictionaryKey)
    UserDefaults.standard.synchronize()
}

func getDictionaryForKey(dictionaryKey: String) -> [String: AnyObject] {
    var b: [String: AnyObject] = [:]
    b = UserDefaults.standard.dictionary(forKey: dictionaryKey)! as [String : AnyObject]
    return b
}

//  MARK: - Defualts Selected Leagues Data
/*func setSelectedLeague(selectedLeague: [LeaguesData], ForKey strKey: String) {
    let encodedObject: Data = NSKeyedArchiver.archivedData(withRootObject: selectedLeague) as Data
    UserDefaults.standard.set(encodedObject, forKey: strKey)
    UserDefaults.standard.synchronize()
}

func getSelectedLeagueForKey(forKey key: String) -> [LeaguesData] {
    let encodedObject = UserDefaults.standard.object(forKey: key)
    let object: [LeaguesData] = NSKeyedUnarchiver.unarchiveObject(with: encodedObject as! Data)! as! [LeaguesData]
    return object
}

//  MARK: - Defualts Profile
func setProfile(profile: Profile, ForKey strKey: String) {
	let encodedObject: Data = NSKeyedArchiver.archivedData(withRootObject: profile) as Data
	UserDefaults.standard.set(encodedObject, forKey: strKey)
	UserDefaults.standard.synchronize()
}

func getProfileForKey(forKey key: String) -> Profile {
	let encodedObject = UserDefaults.standard.object(forKey: key)
	let object: Profile = NSKeyedUnarchiver.unarchiveObject(with: encodedObject as! Data)! as! Profile
	return object
}*/
