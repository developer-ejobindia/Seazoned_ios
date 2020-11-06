//
//  AppDelegate.swift
//  Seazoned
//
//  Created by Student on 01/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit

import MobileCoreServices
import FBSDKCoreKit
import UserNotifications
import Firebase
import FirebaseCore
import FirebaseMessaging
import FirebaseInstanceID
import GoogleSignIn
import GGLCore
import CRNotifications
import SANotificationViews
import GoogleMaps
import GooglePlaces
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,FIRMessagingDelegate {
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
   
    
let array_id = NSMutableArray()
    
    var window: UIWindow?
    var  refreshedToken : String?
    var deviceTokenString : String!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSPlacesClient.provideAPIKey("AIzaSyDofCsKNLIRpBXosz3Zw3FoVYSJOH5i9KU")

        // Override point for customization after application launch.
           FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
       // PayPal.initialize(withAppID: "APP-2Y378622S4663890K", for: ENV_LIVE)

       // PayPal.initialize(withAppID: "APP-80W284485P519543T", for: ENV_SANDBOX)
        // [PayPal initializeWithAppID:@"APP-2Y378622S4663890K" forEnvironment:ENV_LIVE];
         //[PayPal initializeWithAppID:@"APP-80W284485P519543T" forEnvironment:ENV_SANDBOX];
        
        var configError : NSError?

        GGLContext.sharedInstance().configureWithError(&configError)


        assert(configError == nil, "Error configuring Google services: \(configError)")
        
        
       // FIRMessaging.messaging().delegate = self

        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
         //    application.applicationIconBadgeNumber = 1
            // For iOS 10 data message (sent via FCM
         FIRMessaging.messaging().remoteMessageDelegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
         //   application.applicationIconBadgeNumber = 1
        }
        
       
      //  UIApplication.shared.applicationIconBadgeNumber = 0;

    //    setupBadgeNumberPermissions()
        application.registerForRemoteNotifications()
        
       // FIRApp.configure()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification(notification:)), name: NSNotification.Name.firInstanceIDTokenRefresh, object: nil)
        FIRApp.configure()

        return true
    }
    

    func setupBadgeNumberPermissions() {
        let types: UIUserNotificationType = UIUserNotificationType.badge
//        let notificationSettings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
        
         let notificationSettings: UIUserNotificationSettings = UIUserNotificationSettings.init(types: types, categories: nil)
        
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        
        
        
        
        if(url.scheme!.isEqual("fb180079246104411")) {
            //
            //   return FBSDKApplicationDelegate.shared.application(app, open: url, options: options)
            //
            //
            //
            return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
            //
            //
            // wx3308714a2c9a3aa9
        }
//        } else if(url.scheme!.isEqual("wx3308714a2c9a3aa9")) {
//
//            return WXApi.handleOpen(url, delegate: self)
//        }
            
        else
        {
            
            
            
            
            return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [UIApplicationOpenURLOptionsKey.annotation])
            //
        }
        
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
       //  setupBadgeNumberPermissions()
         // application.applicationIconBadgeNumber = 0
        
       // self.incrementBadgeNumberBy(badgeNumberIncrement: 20)
        FIRMessaging.messaging().disconnect()

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
     //   UIApplication.shared.applicationIconBadgeNumber = 0;

        UIApplication.shared.applicationIconBadgeNumber = 0;
        
        
        
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        connectToFCM()

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    // Override point for customization after application launch.
    
    
    //    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
    //        // Print notification payload data
    //        print("Push notification received: \(data)")
    //    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void)
    {
        
        
        //Foreground Process
        
        
        //   print("mmmmm \(notification)")
       
        let userInfo = notification.request.content.userInfo
        
        
        print(userInfo)
        
       let status_id = "\(userInfo["gcm.notification.status"]!)"
   // let order_id = "\(userInfo["gcm.notification.order_id"]!)"
        
        let apps = userInfo["aps"] as! NSDictionary
       
        let alert = apps["alert"] as! NSDictionary
        let body = "\(alert["body"]!)"
        

        
        
        
        



        
        
       if status_id=="3" {
            
//            let rootViewController = self.window!.rootViewController as! UINavigationController
//
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let obj = mainStoryboard.instantiateViewController(withIdentifier: "bhd3") as! BookingHistoryDetails3
//            obj.order_id=order_id
//
//
//            rootViewController.pushViewController(obj, animated: true)
        
        
        
          SANotificationView.showSABanner(title: "Seazoned", message: body, image: #imageLiteral(resourceName: "lo"),  showTime: 3)
        
        
        }
        else if status_id=="0" || status_id=="1" || status_id=="2"
        {
            
            
              SANotificationView.showSABanner(title: "Seazoned", message: body, image: #imageLiteral(resourceName: "lo"),  showTime: 3)
//            let rootViewController = self.window!.rootViewController as! UINavigationController
//
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let obj = mainStoryboard.instantiateViewController(withIdentifier: "bhd1") as! BookingHistoryDetails1
//            obj.order_id=order_id
//            obj.status=status_id
//
//
//
//            rootViewController.pushViewController(obj, animated: true)
        }
        else if status_id=="-1"
        {
//            let rootViewController = self.window!.rootViewController as! UINavigationController
//
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let obj = mainStoryboard.instantiateViewController(withIdentifier: "sh") as! ServiceHistory
//
//          
//
//            rootViewController.pushViewController(obj, animated: true)
            
            
              SANotificationView.showSABanner(title: "Seazoned", message: body, image: #imageLiteral(resourceName: "lo"),  showTime: 3)
        }
        
        else
        
       {
        let orderno = "\(userInfo["orderNo"]!)"
        
        
        UserDefaults.standard.set(orderno, forKey: "orderNo")
        
        array_id.add(orderno)
        
        UserDefaults.standard.set(array_id, forKey: "ar_value")

        SANotificationView.showSABanner(title: "Seazoned", message: body, image: #imageLiteral(resourceName: "lo"),  showTime: 3)

        
        
        }
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    //   FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: InstanceIDAPNSTokenType.sandbox)
        
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: .sandbox)
        
      FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: .prod)
        
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: .unknown)

        deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("APNs device token: \(deviceTokenString!)")
        
     //   AppManager().AlertUser("", message:  deviceTokenString, vc: self)
//                  let topWindow = UIWindow(frame: UIScreen.main.bounds)
//                 topWindow.rootViewController = UIViewController()
//                 topWindow.windowLevel = UIWindowLevelAlert + 1
//                 let alert = UIAlertController(title: "APNS", message: deviceTokenString, preferredStyle: .alert)
//                 alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
//                 // continue your work
//                 // important to hide the window after work completed.
//                 // this also keeps a reference to the window until the action is invoked.
//                 topWindow.isHidden = true
//                 }))
//                 topWindow.makeKeyAndVisible()
//                 topWindow.rootViewController?.present(alert, animated: true, completion: { _ in })
        
    }
    
  
    
    
    @objc func tokenRefreshNotification(notification: NSNotification) {
      //  refreshedToken = InstanceID.instanceID().token()!
        
//       refreshedToken = FIRInstanceID.instanceID().token()!
//        if refreshedToken != nil
//        {
//            print("InstanceID token: \(String(describing: refreshedToken))")
//        }
//
//        else
//        {
//
//            refreshedToken = ""
//
//        }
        
        
        //  UserDefaults.standard.set("ggfgfgf", forKey: "tanay"
        //   self.jjjj(nav: self, str: refreshedToken)
        
        
        
      //  connectToFCM()
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        
        
        
        // Print full message.
        print("szddd \(userInfo)")
//        let rootViewController = self.window!.rootViewController as! UINavigationController
//
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let obj = mainStoryboard.instantiateViewController(withIdentifier: "sh") as! ServiceHistory
//
//        rootViewController.navigationController?.pushViewController(obj, animated: true)
        
//
//        let messageID = userInfo["gcm.notification.service_id"] as! String
//        let service_id = "\(String(describing: messageID))"
//
//
//
//        let messageID1 = userInfo["gcm.notification.pickup_location"] as! String
//        let pickup_location = "\(String(describing: messageID1))"
//
//
//        let messageID2 = userInfo["gcm.notification.destination"] as! String
//        let destination = "\(String(describing: messageID2))"
//
//        let messageID3 = userInfo["gcm.notification.number_of_items"] as! String
//        let number_of_items = "\(String(describing: messageID3))"
//
//
//        let messageID5 = userInfo["gcm.notification.handling_fee"] as! String
//        let handling_fee = "\(String(describing: messageID5))"
//
//
//        let messageID6 = userInfo["gcm.notification.estimated_price"] as! String
//        let estimated_price = "\(String(describing: messageID6))"
//
//
//
//        let messageID7 = userInfo["gcm.notification.fullname"] as! String
//        let fullname = "\(String(describing: messageID7))"
//
//        let messageID8 = userInfo["gcm.notification.phone"] as! String
//        let phone = "\(String(describing: messageID8))"
//
//        let messageID9 = userInfo["gcm.notification.profile_image"] as! String
//        let profile_image = "\(String(describing: messageID9))"
//
//
//        // fullname":"AK","phone":"9087654321","profile_image":"Bhootnath"
//        //  estimated_price
//        // number_of_items  handling_fee
//
//
//
//        let obj = SWRevealViewController()
//
//
//        var rootViewController = self.window!.rootViewController as! SWRevealViewController
//
//
//
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//
//
//
//
//        var profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "h") as! Home
//
//        profileViewController.service_id = service_id
//
//        profileViewController.pickup_location = pickup_location
//        profileViewController.destination = destination
//        profileViewController.handling_fee = handling_fee
//        profileViewController.number_of_items = number_of_items
//        profileViewController.estimated_price = estimated_price
//        profileViewController.profile_image = profile_image
//        profileViewController.phone = phone
//        profileViewController.flaag_push = 1
//        profileViewController.full_name = fullname
//
//        //   profileViewController.flag = "1"
//        //   profileViewController.news_id = dddd
//        rootViewController.pushFrontViewController(profileViewController, animated: true)
//
//          let topWindow = UIWindow(frame: UIScreen.main.bounds)
//         topWindow.rootViewController = UIViewController()
//         topWindow.windowLevel = UIWindowLevelAlert + 1
//         let alert = UIAlertController(title: "APNS", message: userInfo.description, preferredStyle: .alert)
//         alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
//         // continue your work
//         // important to hide the window after work completed.
//         // this also keeps a reference to the window until the action is invoked.
//         topWindow.isHidden = true
//         }))
//         topWindow.makeKeyAndVisible()
//         topWindow.rootViewController?.present(alert, animated: true, completion: { _ in })
    }
    
    
    
    func incrementBadgeNumberBy(badgeNumberIncrement: Int) {
        let currentBadgeNumber = UIApplication.shared.applicationIconBadgeNumber
        let updatedBadgeNumber = currentBadgeNumber + badgeNumberIncrement
        if (updatedBadgeNumber > -1) {
            UIApplication.shared.applicationIconBadgeNumber = updatedBadgeNumber
        }
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
         //Background
        print("mmmmm \(userInfo)")
        
        if ( application.applicationState == .active )
        {
            let status_id = "\(userInfo["gcm.notification.status"]!)"
            //  let order_id = "\(userInfo["gcm.notification.order_id"]!)"
            
            if status_id=="3" {
                let order_id = "\(userInfo["gcm.notification.order_id"]!)"
                
                let rootViewController = self.window!.rootViewController as! UINavigationController
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let obj = mainStoryboard.instantiateViewController(withIdentifier: "bhd3") as! BookingHistoryDetails3
                obj.order_id=order_id
                
                //  self.window?.rootViewController = obj
                // self.window?.makeKeyAndVisible()
                
                rootViewController.pushViewController(obj, animated: true)
            }
            else if status_id=="0" || status_id=="1" || status_id=="2"
            {
                let order_id = "\(userInfo["gcm.notification.order_id"]!)"
                
                let rootViewController = self.window!.rootViewController as! UINavigationController
                
                //  let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd2") as! BookingHistoryDetails2
                //  obj.order_id="\(dict["order_id"]!)"
                //   obj.status=status
                
                //  self.navigationController?.pushViewController(obj, animated: true)
                
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let obj = mainStoryboard.instantiateViewController(withIdentifier: "bhd2") as! BookingHistoryDetails2
                //   let obj = mainStoryboard.instantiateViewController(withIdentifier: "bhd1") as! BookingHistoryDetails1
                obj.order_id=order_id
                //    obj.status=status_id
                
                //  self.window?.rootViewController = obj
                //   self.window?.makeKeyAndVisible()
                
                rootViewController.pushViewController(obj, animated: true)
            }
            else if status_id=="-1"
            {
                let order_id = "\(userInfo["gcm.notification.order_id"]!)"
                
                let rootViewController = self.window!.rootViewController as! UINavigationController
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let obj = mainStoryboard.instantiateViewController(withIdentifier: "sh") as! ServiceHistory
                
                //  self.window?.rootViewController = obj
                // self.window?.makeKeyAndVisible()
                
                rootViewController.pushViewController(obj, animated: true)
            }
                
                
            else
                
            {
                let orderno = "\(userInfo["orderNo"]!)"
                
                
                UserDefaults.standard.set(orderno, forKey: "orderNo")
                
                array_id.add(orderno)
                
                UserDefaults.standard.set(array_id, forKey: "ar_value")
                
                print("AAAAAAAAAAA: ", UserDefaults.standard.value(forKey: "ar_value") as? NSMutableArray)
                
                //            let  k = "\(array_id)"
                //            let topWindow = UIWindow(frame: UIScreen.main.bounds)
                //            topWindow.rootViewController = UIViewController()
                //            topWindow.windowLevel = UIWindowLevelAlert + 1
                //            let alert = UIAlertController(title: "APNS", message:  k, preferredStyle: .alert)
                //            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
                //                // continue your work
                //                // important to hide the window after work completed.
                //                // this also keeps a reference to the window until the action is invoked.
                //                topWindow.isHidden = true
                //            }))
                //            topWindow.makeKeyAndVisible()
                //            topWindow.rootViewController?.present(alert, animated: true, completion: { _ in })
                
                
                
            }
        }
        else
        {
            let status_id = "\(userInfo["gcm.notification.status"]!)"
            //  let order_id = "\(userInfo["gcm.notification.order_id"]!)"
            
            if status_id=="3" {
                let order_id = "\(userInfo["gcm.notification.order_id"]!)"
                
                let rootViewController = self.window!.rootViewController as! UINavigationController
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let obj = mainStoryboard.instantiateViewController(withIdentifier: "bhd3") as! BookingHistoryDetails3
                obj.order_id=order_id
                
                //  self.window?.rootViewController = obj
                // self.window?.makeKeyAndVisible()
                
                rootViewController.pushViewController(obj, animated: true)
            }
            else if status_id=="0" || status_id=="1" || status_id=="2"
            {
                let order_id = "\(userInfo["gcm.notification.order_id"]!)"
                
                let rootViewController = self.window!.rootViewController as! UINavigationController
                
                //  let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd2") as! BookingHistoryDetails2
                //  obj.order_id="\(dict["order_id"]!)"
                //   obj.status=status
                
                //  self.navigationController?.pushViewController(obj, animated: true)
                
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let obj = mainStoryboard.instantiateViewController(withIdentifier: "bhd2") as! BookingHistoryDetails2
                //   let obj = mainStoryboard.instantiateViewController(withIdentifier: "bhd1") as! BookingHistoryDetails1
                obj.order_id=order_id
                //    obj.status=status_id
                
                //  self.window?.rootViewController = obj
                //   self.window?.makeKeyAndVisible()
                
                rootViewController.pushViewController(obj, animated: true)
            }
            else if status_id=="-1"
            {
                let order_id = "\(userInfo["gcm.notification.order_id"]!)"
                
                let rootViewController = self.window!.rootViewController as! UINavigationController
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let obj = mainStoryboard.instantiateViewController(withIdentifier: "sh") as! ServiceHistory
                
                //  self.window?.rootViewController = obj
                // self.window?.makeKeyAndVisible()
                
                rootViewController.pushViewController(obj, animated: true)
            }
                
                
            else
                
            {
                let orderno = "\(userInfo["orderNo"]!)"
                
                
                UserDefaults.standard.set(orderno, forKey: "orderNo")
                
                array_id.add(orderno)
                
                UserDefaults.standard.set(array_id, forKey: "ar_value")
                
                //            let  k = "\(array_id)"
                //            let topWindow = UIWindow(frame: UIScreen.main.bounds)
                //            topWindow.rootViewController = UIViewController()
                //            topWindow.windowLevel = UIWindowLevelAlert + 1
                //            let alert = UIAlertController(title: "APNS", message:  k, preferredStyle: .alert)
                //            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
                //                // continue your work
                //                // important to hide the window after work completed.
                //                // this also keeps a reference to the window until the action is invoked.
                //                topWindow.isHidden = true
                //            }))
                //            topWindow.makeKeyAndVisible()
                //            topWindow.rootViewController?.present(alert, animated: true, completion: { _ in })
                
                
                
            }
            
        }
        // app was just brought from background to foreground
        
     //   self.incrementBadgeNumberBy(badgeNumberIncrement: 1)

       //   application.applicationIconBadgeNumber = 1

        //UserDefaults.standard.set("1", forKey: "tanay")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "sh")
        
        
        
//                    let rootViewController = self.window!.rootViewController as! UINavigationController
//
//                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//                    let obj = mainStoryboard.instantiateViewController(withIdentifier: "sh") çç
//
//                    rootViewController.navigationController?.pushViewController(obj, animated: true)
        
//        let status_id = "\(userInfo["gcm.notification.status"]!)"
//      //  let order_id = "\(userInfo["gcm.notification.order_id"]!)"
//
//        if status_id=="3" {
//            let order_id = "\(userInfo["gcm.notification.order_id"]!)"
//
//            let rootViewController = self.window!.rootViewController as! UINavigationController
//
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let obj = mainStoryboard.instantiateViewController(withIdentifier: "bhd3") as! BookingHistoryDetails3
//            obj.order_id=order_id
//
//          //  self.window?.rootViewController = obj
//           // self.window?.makeKeyAndVisible()
//
//            rootViewController.pushViewController(obj, animated: true)
//        }
//        else if status_id=="0" || status_id=="1" || status_id=="2"
//        {
//            let order_id = "\(userInfo["gcm.notification.order_id"]!)"
//
//            let rootViewController = self.window!.rootViewController as! UINavigationController
//
//          //  let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd2") as! BookingHistoryDetails2
//          //  obj.order_id="\(dict["order_id"]!)"
//            //   obj.status=status
//
//          //  self.navigationController?.pushViewController(obj, animated: true)
//
//
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//  let obj = mainStoryboard.instantiateViewController(withIdentifier: "bhd2") as! BookingHistoryDetails2
//         //   let obj = mainStoryboard.instantiateViewController(withIdentifier: "bhd1") as! BookingHistoryDetails1
//            obj.order_id=order_id
//        //    obj.status=status_id
//
//          //  self.window?.rootViewController = obj
//         //   self.window?.makeKeyAndVisible()
//
//            rootViewController.pushViewController(obj, animated: true)
//        }
//        else if status_id=="-1"
//        {
//            let order_id = "\(userInfo["gcm.notification.order_id"]!)"
//
//            let rootViewController = self.window!.rootViewController as! UINavigationController
//
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let obj = mainStoryboard.instantiateViewController(withIdentifier: "sh") as! ServiceHistory
//
//          //  self.window?.rootViewController = obj
//           // self.window?.makeKeyAndVisible()
//
//            rootViewController.pushViewController(obj, animated: true)
//        }
//
//
//        else
//
//        {
//            let orderno = "\(userInfo["orderNo"]!)"
//
//
//           UserDefaults.standard.set(orderno, forKey: "orderNo")
//
//            array_id.add(orderno)
//
//            UserDefaults.standard.set(array_id, forKey: "ar_value")
//
////            let  k = "\(array_id)"
////            let topWindow = UIWindow(frame: UIScreen.main.bounds)
////            topWindow.rootViewController = UIViewController()
////            topWindow.windowLevel = UIWindowLevelAlert + 1
////            let alert = UIAlertController(title: "APNS", message:  k, preferredStyle: .alert)
////            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
////                // continue your work
////                // important to hide the window after work completed.
////                // this also keeps a reference to the window until the action is invoked.
////                topWindow.isHidden = true
////            }))
////            topWindow.makeKeyAndVisible()
////            topWindow.rootViewController?.present(alert, animated: true, completion: { _ in })
//
//
//
//        }
//

//
//        let obj = SWRevealViewController()
//
//
//        var rootViewController = self.window!.rootViewController as! SWRevealViewController
//
//
//
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//
//
//
//
//        var profileViewController = mainStoryboard.instantiateViewController(withIdentifier: "h") as! Home
//
//        profileViewController.service_id = service_id
//
//        profileViewController.pickup_location = pickup_location
//        profileViewController.destination = destination
//        profileViewController.handling_fee = handling_fee
//        profileViewController.number_of_items = number_of_items
//        profileViewController.estimated_price = estimated_price
//        profileViewController.profile_image = profile_image
//        profileViewController.phone = phone
//        profileViewController.flaag_push = 1
//        profileViewController.full_name = fullname
        
        //   profileViewController.flag = "1"
        //   profileViewController.news_id = dddd
       // rootViewController.pushFrontViewController(profileViewController, animated: true)
        
        
        
//       let topWindow = UIWindow(frame: UIScreen.main.bounds)
//         topWindow.rootViewController = UIViewController()
//         topWindow.windowLevel = UIWindowLevelAlert + 1
//         let alert = UIAlertController(title: "APNS", message:  array_id.description, preferredStyle: .alert)
//         alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "confirm"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
//         // continue your work
//         // important to hide the window after work completed.
//         // this also keeps a reference to the window until the action is invoked.
//         topWindow.isHidden = true
//         }))
//         topWindow.makeKeyAndVisible()
//         topWindow.rootViewController?.present(alert, animated: true, completion: { _ in })
//
//
     completionHandler(UIBackgroundFetchResult.newData)
    }
  
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        // Let FCM know about the message for analytics etc.
    FIRMessaging.messaging().appDidReceiveMessage(userInfo)
        // handle your message
    }
    func connectToFCM() {
        FIRMessaging.messaging().connect { (error) in

            if (error != nil) {
                print("Unable to connect to FCM \(String(describing: error))")
            } else {
                print("Connected to FCM")
            }
        }

    }

}

