  //
//  Dashboard.swift
//  Seazoned
//
//  Created by Student on 02/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SVProgressHUD
import FirebaseCore
import FirebaseMessaging
import FirebaseInstanceID
  import Firebase
class Dashboard: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,CLLocationManagerDelegate {
    
    
    @IBOutlet weak var lbl_count: UILabel!

    

    var mylat:String!
    var mylong:String!
    
   var   flag_guest :String!
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    
     @IBOutlet var btn_msg: UIButton!
     @IBOutlet var btn_profile: UIButton!
     @IBOutlet var btn_n: UIButton!
    
   
    @IBOutlet var bell_view: UIView!
    
    @IBOutlet var lower_view: UIView!

    @IBOutlet var v1: UIView!
    
    @IBOutlet var v2: UIView!
    
    @IBOutlet var v3: UIView!
    
    @IBOutlet var v4: UIView!
    
    @IBOutlet var v5: UIView!
    
    @IBOutlet var v6: UIView!
    
    @IBOutlet var v7: UIView!
    
    @IBOutlet var col: UICollectionView!
    
    var weather_ary:NSArray!
    
    @IBOutlet weak var lbl_condition: UILabel!
    
    @IBOutlet weak var lbl_location: UILabel!
    
    @IBOutlet weak var lbl_date: UILabel!
    
    @IBOutlet weak var lbl_degree: UILabel!
    
    @IBOutlet var scroll: UIScrollView!
    
     @IBOutlet weak var red_msg: UIImageView!
    
    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var d: UILabel!
    
    @IBOutlet weak var c: UILabel!
    
    @IBAction func menu(_ sender: Any) {
    }
    
    @IBAction func notification(_ sender: Any) {
        
        if UserDefaults.standard.value(forKey: "session") != nil
        {
            
            let str_session = UserDefaults.standard.value(forKey: "session") as! String
            if str_session=="1"
            {
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "notlst") as! NotificationList
               
                self.navigationController?.pushViewController(obj, animated: true)
                
            }
            else
            {
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
                self.navigationController?.pushViewController(obj, animated: false)
            }
            
            
        }
        else
        {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
            self.navigationController?.pushViewController(obj, animated: false)
        }
        
        
    }
    
//    func load_services()
//    {
//
//    }
    
    
    
    func noti_count()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        
        let token = UserDefaults.standard.object(forKey: "token")
        if  token  ==  nil
        {
            
            SVProgressHUD.dismiss()
        }
            
        else
        {
        //  http://192.168.1.2:8080/dev/ondemandcrapp/public/api/subscribe?
        // firebase_token=khbistr98w-0ghd0tjklhxvgc.....,
        //  &device_type=android
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
//        let token1 = FIRInstanceID.instanceID().token()
//        let avl = token1 as! String
//        if  avl != nil
//        {
        
           // print("-----------------------------------\(token1)")
         //   let params: Parameters  [Parameter.device_token: token1!
                                 //   ]
            
            
            Alamofire.request(Webservice.notification, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                
                .responseJSON { response in
                    //debugPrint(response.data)
                    
                    switch(response.result){
                    case .success(_):
                        let result = response.result
                        
                        let dict = result.value as! NSDictionary
                        
                        print("-----kkkkkkkk-----\(dict)")
                        
                        let succ = dict["success"] as! Int
                        
                        let msg = dict["msg"] as! String
                        
                        if succ==1
                        {
                               let notification_count1 = "\(dict["notification_count"]!)"
                            
                          //  self.lbl_count.text = notification_count1
                            
                        self.bell_view.isHidden = false
                            
                            
                            UserDefaults.standard.set("1", forKey: "noti")
                            
                            SVProgressHUD.dismiss()
                            
                        }
                        else
                        {
                            self.bell_view.isHidden = true

                            SVProgressHUD.dismiss()
                            
                        }
                 //       self.lbl_count.isHidden = true
                        
                        break
                        
                    case .failure(_):
                        print("Network Error")
                        SVProgressHUD.dismiss()
                        break
                        
                    }
            }
        }
            
       // }
            
//        else
//        {
//            // SVProgressHUD.dismiss()
//        }
    
        //SVProgressHUD.dismiss()
    }
    
    
    func subscription()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        
        if  token  ==  nil
        {
            
             SVProgressHUD.dismiss()
        }
        
        else
        {
        
        
        //  http://192.168.1.2:8080/dev/ondemandcrapp/public/api/subscribe?
        // firebase_token=khbistr98w-0ghd0tjklhxvgc.....,
        //  &device_type=android
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        let token1 = FIRInstanceID.instanceID().token()
      //  let token1 = appDelegate.deviceTokenString
        
     //   AppManager().AlertUser("", message: "\(token1?.description)", vc: self)
        if token1 != nil
       // if  avl != nil
        {
        
        print("-----------------------------------\(token1)")
            
         //   AppManager().AlertUser("", message: token1!, vc: self)
        let params: Parameters = [Parameter.device_token: token1!,
                                  Parameter.device_type: "iphone",
                                  Parameter.user_type: "user"]
        
        
        Alamofire.request(Webservice.subscribe, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON { response in
                //debugPrint(response.data)
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("----------\(dict)")
                    
                    let succ = dict["success"] as! Int
                    
                    let msg = dict["msg"] as! String
                    
                    if succ==1
                    {
                        
                        SVProgressHUD.dismiss()
                        
                    }
                    else
                    {
                       
                        SVProgressHUD.dismiss()
                        
                    }
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
        }
            
        }

        else
        {
            SVProgressHUD.dismiss()
            
             // AppManager().AlertUser("", message: token1!, vc: self)
        }
        
        //SVProgressHUD.dismiss()
            
        }
    }
    
    func loaddiscount()  {
        
        
        
      
        Alamofire.request(Webservice.serviceList, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            
            .responseJSON { response in
                //debugPrint(response.data)
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("---discount-------\(dict)")
                    
                    let succ = dict["success"] as! Int
                    
                    let rate = "\(dict["tax_rate"]!)"
                    
                    
                    
                    UserDefaults.standard.set(rate, forKey: "rate")
                    
                    
                    print("rate-------\(rate)")
                    
                    
                    // let msg = dict["msg"] as! String
                    
                    if succ==1
                    {
                        
                        //                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
                        //                        self.navigationController?.pushViewController(obj, animated: true)
                        
                        
                        SVProgressHUD.dismiss()
                        
                    }
                    else
                    {
                        //AppManager().AlertUser("Message", message: msg, vc: self)
                        
                        SVProgressHUD.dismiss()
                        
                    }
                    
                    
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    
                    SVProgressHUD.dismiss()
                    
                    break
                    
                }
        }
    }
    
  
   
    
    //MARK: Services
    
    @IBAction func service_btn(_ sender: UIButton) {
        
        var ser_id:String!
        var ser_name:String!
        
        switch sender.tag {
        case 0:
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "sl") as! SearchList
//            self.navigationController?.pushViewController(obj, animated: true)
            
            ser_id="1"
            ser_name="Lawn Mowing"
            
            //break
        case 1:
            ser_id="2"
            ser_name="Leaf Removal"
            //break
        case 2:
            ser_id="3"
            ser_name="Lawn Treatment"
            //break
        case 3:
            ser_id="4"
            ser_name="Aeration"
            //break
        case 4:
            ser_id="5"
            ser_name="Sprinkler Winterizing"
            //break
        case 5:
            ser_id="6"
            ser_name="Pool Cleaning & Upkeep"
            //break
        case 6:
            ser_id="7"
            ser_name="Snow Removal"
            //break
            
        default: break
            
        }
        
       /* if UserDefaults.standard.value(forKey: "session") != nil
        {
            
            let str_session = UserDefaults.standard.value(forKey: "session") as! String
            if str_session=="1"
            {
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "sl") as! SearchList
                obj.ser_id=ser_id
                obj.ser_name=ser_name
                self.navigationController?.pushViewController(obj, animated: true)
                
            }
            else
            {
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
                self.navigationController?.pushViewController(obj, animated: false)
            }
            
            
        }
        else
        {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
            self.navigationController?.pushViewController(obj, animated: false)
        }*/
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "sl") as! SearchList
        obj.ser_id=ser_id
        obj.ser_name=ser_name
        
        obj.flag_guest  =   flag_guest
        self.navigationController?.pushViewController(obj, animated: true)
        
      
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.lbl_count.isHidden = true
  // noti_count()

        // Do any additional setup after loading the view.
        check_tab()
        let des_obj = Design()
        des_obj.round_corner(my_view: lower_view,value: 6)
        des_obj.view_round(my_view: bell_view)
        
        des_obj.view_round(my_view: v1)
        des_obj.view_round(my_view: v2)
        des_obj.view_round(my_view: v3)
        des_obj.view_round(my_view: v4)
        des_obj.view_round(my_view: v5)
        des_obj.view_round(my_view: v6)
        des_obj.view_round(my_view: v7)
        
        scroll.contentSize=CGSize (width: 0, height: v7.frame.origin.y+v7.frame.size.height+60)
        UserDefaults.standard.setValue("0", forKey: "back_flag")

        
        //loadweather()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        col.dataSource=nil
   //     self.incrementBadgeNumberBy(badgeNumberIncrement: 10)
        
        SVProgressHUD.show()
        subscription()
        loaddiscount()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        noti_count()
        self.navigationController?.isNavigationBarHidden = true
        
//        if "\(UserDefaults.standard.value(forKey: "back_flag")!)" == "1" {
//
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "sh") as! ServiceHistory
//            //            obj.ser_id=str_ser_id
//            //            obj.added_ser_id=str_landscaperid
//            self.navigationController?.pushViewController(obj, animated: true)
//
//        }
//        else
//        {
//
//        }
        
        
       //  @IBOutlet weak var red_msg: UIImageView!
//        if UserDefaults.standard.object(forKey: "ar_value") != nil
//        {
//            //   cell.backgroundColor = UIColor.red
//
//
//            var ary = NSArray()
//
//
//            ary = UserDefaults.standard.array(forKey: "ar_value")  as! NSArray
//
//
//
//            let a = "\(ary)"
//
//            if ary.count == 0
//            {
//                red_msg.isHidden = true
//
//
//            }
//            else
//
//            {
//          //  AppManager().AlertUser("", message: a, vc: self)
//
//            red_msg.isHidden = false
//            }
//        }
//
//        else
//        {
//
//            red_msg.isHidden = true
        
        
        
        //Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(redcheck), userInfo: nil, repeats: true)
        
        
        redcheck()

            
        }
    
    
    func redcheck()
    {
        
        
        if UserDefaults.standard.object(forKey: "ar_value") != nil
        {
            //   cell.backgroundColor = UIColor.red
            
            
            var ary = NSArray()
            
            
            ary = UserDefaults.standard.array(forKey: "ar_value")  as! NSArray
            
            
            
            let a = "\(ary)"
            
            if ary.count == 0
            {
                red_msg.isHidden = true
                
                
            }
            else
                
            {
                //  AppManager().AlertUser("", message: a, vc: self)
                
                red_msg.isHidden = false
            }
        }
            
        else
        {
            
            red_msg.isHidden = true

    }
        
        
     //   DataService.ds.MSGS_DB_REF.child("gg").observe(<#T##eventType: FIRDataEventType##FIRDataEventType#>, with: <#T##(FIRDataSnapshot) -> Void#>)
        
      //  OD1538569221272889
        
        
     //   let a = 1
        
        
      //  let uid = Login_data().Details.
           let token = UserDefaults.standard.object(forKey: "token")
        if  token  ==  nil
        {
            
            SVProgressHUD.dismiss()
        }
            
        else
        {
            
        let DB_BASE = FIRDatabase.database().reference()
            
            
            
            
            
            
            
            
            
            
            
            
            
        
        
       let u_id  = UserDefaults.standard.value(forKey: "u_id")

            DB_BASE.child("notification_\(u_id!)").observe(FIRDataEventType.value, with: { (snapshot) in
         //   print(snapshot)
            //if the reference have some values
   // let status = snapshot.childrenCount  + 1

    
    
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                
                let value = snapshot.value as? NSDictionary
              //  let value1 = value?.object(forKey: "date")
                
            let status = value?.value(forKey: "flag") as! String
                
                
                
                
                print("fggfgf\(value!)")
                
                
              
                
                
                
                
                
                if  status == "1"
                {
                    
                    self.red_msg.isHidden = false
                    print("ok")
                    
                }
                
                
                else
                
                {
                     self.red_msg.isHidden = true
                     print("holo nah")

                    
                }
                    
                    
           
            
                
            }
            
        })
  
        }
    }
    
    
    
    
    func check_tab()
    
    {
        
        
        
        
        
      
        
        DB_BASE.child("check_user_login").observe(FIRDataEventType.value, with: { (snapshot) in
            //   print(snapshot)
            //if the reference have some values
            // let status = snapshot.childrenCount  + 1
            
            
            
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                
                let value = snapshot.value as? NSDictionary
                //  let value1 = value?.object(forKey: "date")
                
                let status = value?.value(forKey: "check_flag") as! String
                
                
                
                
                print("fggfgf\(value!)")
                
                
                
                
                
                
                
                
                if  status == "1"
                {
                    
                    
                    self.flag_guest = "1"
                    self.btn_msg.isHidden = false
                    
                      self.btn_profile.isHidden = false
                    self.btn_n.isHidden = false

                    
                    print("ok")
                    
                }
                    
                    
                else
                    
                {
                    
                    self.flag_guest = "0"

                    self.btn_msg.isHidden = true
                    
                    self.btn_profile.isHidden = true
                    self.btn_n.isHidden = true

                    print("holo nah")
                    
                    
                }
                
                
                
                
                
            }
            
        })
        
    }
 
  
  
    
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wc", for: indexPath) as! WeatherCell
        
        let dict = weather_ary[indexPath.row+1] as! NSDictionary
        
        cell.day.text = (dict["day"] as? String)?.uppercased()
        
        cell.high.text = dict["high"] as? String
        
        cell.low.text = dict["low"] as? String
        
        let str_img = dict["code"] as? String
        
        let concat_string = (str_img! + ".png")
        
        cell.imgvw.image = UIImage (named:concat_string)
        
        cell.day.clipsToBounds=true
        cell.day.layer.cornerRadius=3
        
        return cell
    }
    
    //var locationManager = CLLocationManager()
    
    func incrementBadgeNumberBy(badgeNumberIncrement: Int) {
        let currentBadgeNumber = UIApplication.shared.applicationIconBadgeNumber
        let updatedBadgeNumber = currentBadgeNumber + badgeNumberIncrement
        if (updatedBadgeNumber > -1) {
            UIApplication.shared.applicationIconBadgeNumber = updatedBadgeNumber
        }
    }
    
    func loadweather()
    {
        
        col.dataSource=nil
        
        locationManager.requestWhenInUseAuthorization();
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            var currentLocation: CLLocation!
            currentLocation = locationManager.location
        //    print("locations = \(currentLocation.coordinate.latitude) \(currentLocation.coordinate.longitude)")
            
            
            
            
            let mylat = String(currentLocation.coordinate.latitude)
            let mylong = String(currentLocation.coordinate.longitude)
            
            let s1 = "\""
            let s2 = ")"
            
            
            
            //let str1 = "(SELECT woeid FROM geo.places WHERE text= "\(s1) \(mylat),\(mylong)\(s2)")&format=json"
            
            
            let kkk = "(\(mylat)" + "," + "\(mylong))"
            
            let str111 = "(" + "SELECT woeid FROM geo.places WHERE text=" + s1 + kkk + s1 + ")"
            
            //http://query.yahooapis.com/v1/public/yql?q=select * from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text="({28.3949},{84.1240})")&format=json
            
            let str = "http://query.yahooapis.com/v1/public/yql?q=select * from weather.forecast where woeid in \(str111) and u='f'&format=json"
            
            let urlwithPercentEscapes = str.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            
            if let url = NSURL(string:urlwithPercentEscapes!){
                if let data = try? Data(contentsOf:url as URL ){
                    do{
                        let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                        
                        
                      //  print("----------\(dict)")
                        
                        let dict_query = dict["query"] as! NSDictionary
                        
                        let dict_results = dict_query["results"] as! NSDictionary
                        
                        let dict_channel = dict_results["channel"] as! NSDictionary
                        
                        let dict_item = dict_channel["item"] as! NSDictionary
                        
                        let dict_location = dict_channel["location"] as! NSDictionary
                        
                        lbl_location.text = (dict_location["city"] as? String)! + "," + (dict_location["region"] as? String)! + "," + (dict_location["country"] as? String)!
                        
                        weather_ary = dict_item["forecast"] as! NSArray
                        
                        let condition = dict_item["condition"] as! NSDictionary
                        
                        lbl_condition.text = condition["text"] as? String
                        
                        lbl_degree.text = condition["temp"] as? String
                        
                        let str_img = condition["code"] as! String
                        
                        let concat_string = (str_img + ".png")
                        
                        imgvw.image=UIImage (named: concat_string)
                        
                        //let str_date = condition["date"] as! String
                        
                        let today_date = Date()
                        
                        //print("----\(today_date)")
                        
                        let format1 = DateFormatter()
                        format1.dateFormat="yyyy-MM-dd HH:mm:ss"
                        let str11111 = format1.string(from: today_date)
                        
                        let format222 = DateFormatter()
                        format222.dateFormat="yyyy-MM-dd HH:mm:ss"
                        let date11 = format222.date(from: str11111)
                        
                        let format2 = DateFormatter()
                        format2.dateFormat="EEEE MMMM dd"
                        let str_result = format2.string(from: date11!)
                        
                        lbl_date.text = str_result
                        
                        d.isHidden=false
                        c.isHidden=false
                        col.dataSource=self
                        col.reloadData()
                        
                    }
                    catch let error as NSError{
                        print("detail of json parsing error\n\(error)")
                    }
                }
                
            }
            
            
            
            
            
            
            
            
        }
        else{
            print("Location service disabled");
            col.dataSource=nil
            
            d.isHidden=true
            c.isHidden=true
            
            lbl_condition.text="Please Turn on"
            lbl_location.text="Location Services"
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        /*let locManager = CLLocationManager()
         locManager.requestWhenInUseAuthorization()
         
         var currentLocation: CLLocation!
         
         if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
         CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
         
         currentLocation = locManager.location
         
         
         
         print("locations = \(currentLocation.coordinate.latitude) \(currentLocation.coordinate.longitude)")*/
        
        //https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    //MARK: Tabbar
    
    @IBAction func tabbar(_ sender: UIButton) {
        
        //Help
        if sender.tag==0 {
            
            
       
            
                    let obj = self.storyboard?.instantiateViewController(withIdentifier: "faq") as! faq
                    self.navigationController?.pushViewController(obj, animated: false)
            
              
                
          
        
            
            
           
        }
        //Message
        else if sender.tag==1 {
            
            
    
                    let obj = self.storyboard?.instantiateViewController(withIdentifier: "clst") as! Chatlist
                    self.navigationController?.pushViewController(obj, animated: false)
    
                
                
    
    
            
            
            
          
        }
        //Home
        else if sender.tag==2 {
            
        }
        //Contact Us
        else if sender.tag==3 {
            
           
                    let obj = self.storyboard?.instantiateViewController(withIdentifier: "contuct") as! contuct
                    self.navigationController?.pushViewController(obj, animated: false)
            
                
                
          
  
            
            
           
        }
            //Profile
        else
        {
            
         
                    let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
                     self.navigationController?.pushViewController(obj, animated: false)
            
                
          
            
            
            
          //  let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
           // self.navigationController?.pushViewController(obj, animated: false)
        }
        
        
        
        
    }
    
    // MARK:  Gps MAP
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopMonitoringSignificantLocationChanges()
        locationManager.stopUpdatingLocation()
      //  mapView.showsUserLocation = false
        
    }
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        
        
        // locationManager.stopUpdatingLocation()
        
        let latestLocation: CLLocation = locations[locations.count - 1]
        
        mylat = String(format: "%.4f",
                       latestLocation.coordinate.latitude)
        mylong = String(format: "%.4f",
                        latestLocation.coordinate.longitude)
        
        //print("tnay-----lat-------\(str1)------lon---\(str2)")
        
        loadweather()
        
    }
    
    
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
        
        
    }

}
