//
//  Constant.swift
//  EstateBlock
//
//  Created by Dinesh Sailor on 11/17/16.
//  Copyright © 2016 Varshaa Weblabs. All rights reserved.

import UIKit
import Foundation

enum Keys {
    
    struct OneSignal {
        static let appID = "5999c3bc-5ad3-4abf-bca1-f22d7896e489"
        // static let appID = "b9b48003-a087-465f-bac3-5179bb55a3c5"
    }
    
    struct Twitter {
        static let consumerKey = "HKOlARU26FKtXPHACYcOVYzuf"
        static let secretKey = "zeNhuwLOryAkuKazQXZ1KTc9pFI7hFozm5eFfDhdlXaw1yMauI"
    }
    
}

struct Default {
	
	static let isFacebookLogin = "isFacebookLogin"
	static let isGoogleLogin = "isGoogleLogin"
	static let isTwitterLogin = "isTwitterLogin"
    
    static let sessionKey = "sessionKey"
    static let sessionKeyAvailable = "sessionKeyAvailable"
	
    static let userId = "userId"
	
	static let profilePicture = "profilePicture"
	static let email = "email"
	
	static let profile = "profile"
	static let profileAvailable = "profileAvailable"
	
	static let isDrawer = "isDrawer"
    
    static let countryName = "countryName"
    
    static let selectedLeagues = "selectedLeagues"
    static let isSelectedLeagues = "isSelectedLeagues"
	
	static let hasOneSignal = "hasOneSignal"
	static let oneSignalUserId = "OneSignalUserId"
	static let oneSignalPushToken = "OneSignalPushToken"
	
	static let tokenPrediktion1 = "tokenPrediktion1"
	static let tokenPrediktion2 = "tokenPrediktion2"
	static let tokenPrediktion3 = "tokenPrediktion3"
	static let tokenPrediktion4 = "tokenPrediktion4"
    
}

struct Notifications {
	
	static let oneSignalId = "oneSignalId"
    
    static let leagueSave = "leagueSave"
	
	static let goalDifference = "goalDifference"
	static let exactGoal = "exactGoal"
    
}

struct ScreenSize {
    static let Width = UIScreen.main.bounds.size.width
    static let Height = UIScreen.main.bounds.size.height
    static let MaxLength = max(ScreenSize.Width, ScreenSize.Height)
    static let MinLength = min(ScreenSize.Width, ScreenSize.Height)
}

struct DeviceType {
    static let iPhone = UIDevice.current.userInterfaceIdiom == .phone
    static let iPad = UIDevice.current.userInterfaceIdiom == .pad
    static let carPlay = UIDevice.current.userInterfaceIdiom == .carPlay
    static let appleTV = UIDevice.current.userInterfaceIdiom == .tv
}

struct DeviceModel {
    static let iPhone4sOrLess = DeviceType.iPhone && ScreenSize.MaxLength < 568.0
    static let iPhone5 = DeviceType.iPhone && ScreenSize.MaxLength == 568.0
    static let iPhone6 = DeviceType.iPhone && ScreenSize.MaxLength == 667.0
    static let iPhone6P = DeviceType.iPhone && ScreenSize.MaxLength == 736.0
    static let iPhone7 = DeviceType.iPhone && ScreenSize.MaxLength == 667.0
    static let iPhone7P = DeviceType.iPhone && ScreenSize.MaxLength == 736.0
    static let iPhoneSE = DeviceType.iPhone && ScreenSize.MaxLength == 736.0
    static let iPad = DeviceType.iPad && ScreenSize.MaxLength == 1024.0
    static let iPadPro9_7 = DeviceType.iPad && ScreenSize.MaxLength == 1024.0
    static let iPadPro12_9 = DeviceType.iPad && ScreenSize.MaxLength == 1366.0
}

struct iOSVersion {
    static let SystemVerson = (UIDevice.current.systemVersion as NSString).floatValue
    
    static let iOS7 = (iOSVersion.SystemVerson < 8.0 && iOSVersion.SystemVerson >= 7.0)
    static let iOS8 = (iOSVersion.SystemVerson >= 8.0 && iOSVersion.SystemVerson < 9.0)
    static let iOS9 = (iOSVersion.SystemVerson >= 9.0 && iOSVersion.SystemVerson < 10.0)
    static let iOS10 = (iOSVersion.SystemVerson >= 10.0 && iOSVersion.SystemVerson < 11.0)
}

struct Orientation {
    
    static var isLandscape: Bool {
        get {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isLandscape
                : UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    
    static var isPortrait: Bool {
        get {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isPortrait
                : UIApplication.shared.statusBarOrientation.isPortrait
        }
    }
}

struct HTML {
	static func getHTMLString(image: String) -> String {
		return "<html><head><style>*{ margin:0 auto; padding:0;background:transparent no-repeat center}div{height:100%;background:transparent url('\(image)') no-repeat center;background-size:contain}</style></head><body><div></div></body></html>"
	}
}
