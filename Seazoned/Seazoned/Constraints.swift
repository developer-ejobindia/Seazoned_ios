//
//  Constraints.swift
// BanBan
//
//  Created by Tanay Bhattacharjee.
//  Copyright © 2017 Tanay Bhattacharjee All rights reserved.


import Foundation
import UIKit

struct Constants {
    static let someNotification = "TEST"
}


struct Urls {
   // http://seazoned.com/api
//static let main_url      =   "http://192.168.1.2:8080/dev/seazonedapp/public/api/"
//static let main_url              = "http://103.230.103.142:8080/dev/seazonedapp/public/api/"
    
    static let main_url              = "http://seazoned.com/api/"

   // http://220.225.80.177:8080/
    static var   get_countries             = main_url+"country-list"
    
    static var   con_us             = main_url+"contact-us-user"

    static var change_password   = main_url+"change-password"
    
     static var view_card   = main_url+"view-card-list"
    
  static var  add_card   =  main_url+"add-card"
    static var  edit_card   =  main_url+"edit-card"

}





struct SearchForMultibaggerSector {
    
    static var serchValue   = ""
    static var seg_date     = ""
    
}

struct MultibaggerType {
    
    static var midCap                       =       "MID"
    static var largeCap                     =       "LARGE"
    
    
    static var midCapForHeatmap             =       "MLT-MID"
    static var largeCapForHeatmap           =       "MLT-LARGE"
    
    static var midCapForPastPerformance     =       "Mid%20Cap"
    static var LargeCapForPastPerformance   =       "Large%20Cap"
    
    
    static var typeOfMultibagger            =       ""
    static var typeOfMultibaggerForHeatMap  =       ""
    static var typeOfMultibaggerForPastPer  =       ""
}

struct ViewToHighLight {
    
    static var vwRiskView               =       ""
    static var vwInvestment             =       ""
    
    
}


struct Phone {
    
    static let iPhone_5s        =   568       //  UIScreen.main.bounds.size.height - 568
    static let iPhone_7s        =   667       // UIScreen.main.bounds.size.height-667
    static let iPhone_7s_Plus   =   736       // UIScreen.main.bounds.size.height-736
}

struct User {
    
    static var socialId         =   ""
    static var firstName        =   ""
    static var lastName         =   ""
    static var email            =   ""
    static var phone            =   ""
    static var socialToken      =   ""
    static var password         =   ""
    static var regThrough       =   ""
    static var token            =   ""
    static var OnboardinString  =   ""
    
}


struct RegThrough {
    
    static var normal           =   "normal"
    static var gmail            =   "gmail"
    static var facebook         =   "facebook"
}

