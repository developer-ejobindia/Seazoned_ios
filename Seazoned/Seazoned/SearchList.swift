//
//  SearchList.swift
//  Seazoned
//
//  Created by Apple on 26/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import Kingfisher
import WARangeSlider
import CoreLocation
import GoogleMaps
import GooglePlaces
import Firebase
class SearchList: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,trasfardata,UIPickerViewDataSource,UIPickerViewDelegate,CLLocationManagerDelegate {
    var mylat:String!
    var mylong:String!
    var flag_guest:String!
    var lat = Double()
    var long = Double()
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    @IBOutlet weak var auto_view: UIView!
     @IBOutlet var btn_n: UIButton!
    @IBOutlet weak var auto_txt: UITextField!
    
    @IBOutlet weak var col: UICollectionView!
    
    @IBOutlet weak var lower_view: UIView!
    
    @IBOutlet var bell_view: UIView!
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var nodata: UILabel!
    
    @IBOutlet weak var sorting: UITextField!
    
     @IBOutlet weak var red_msg: UIImageView!
    var ary:NSArray!
    
    var ser_id:String!
    
    var ser_name:String!
    
    var min_rate:String!
    var max_rate:String!
    var  locationstart_curent_location = CLLocation()

    var str_city:String!
    var str_country:String!
    var str_zip:String!
    var str_state:String!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var view1:UIView!
    
    var rangeSlider = RangeSlider()
    
    @IBOutlet var fakeview: UIView!
    
    var  blurEffectView = UIVisualEffectView()
    
    @IBOutlet weak var results: UILabel!
    
    var pick :UIPickerView!
    
    var filter_price=""
    
    var filter_ary = ["None","Low To High","High To Low"]
    
    func picker(_ textField : UITextField){
        
        self.pick = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        
        self.pick.backgroundColor = UIColor.white
        
        textField.inputView = self.pick
        
        pick.dataSource = self
        
        pick.delegate = self
        
        //getchildren()
        
        pick.tag=0
        
        // ToolBar
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = .default
        
        toolBar.isTranslucent = true
        
        toolBar.tintColor = UIColor.black
        
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SearchList.doneClick))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(SearchList.cancelClick))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    
    
    @objc func doneClick() {
        
        sorting.resignFirstResponder()
        
    }
    
    
    
    @objc func cancelClick() {
        
        sorting.resignFirstResponder()
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        
        return filter_ary.count
        
        
        
    }
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        
    {
        
        
        
        return filter_ary[row]
        
        
        
    }
    
    
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        
    {
        
        
        
        sorting.text = filter_ary[pick.selectedRow(inComponent: 0)]
        
        
        
        if sorting.text=="None"
            
        {
            
            filter_price=""
            
        }
            
        else if sorting.text=="Low To High"
            
        {
            
            filter_price="l"
            
        }
            
        else
            
        {
            
            filter_price="h"
            
        }
    
    
    
    }
    
    
    @IBAction func btn(_ sender: Any) {
        
        let s = UIStoryboard.init(name: "Main", bundle: nil)
        
        let obj = s.instantiateViewController(withIdentifier: "ga") as! google_auto
        //self.present(obj, animated: true, completion: nil)
        obj.delegate=self
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    
    func addresssend(add: String, city: String, country: String, zipcode: String, state: String) {
        auto_txt.text=add
        str_city=city
        str_country=country
        str_zip=zipcode
        str_state=state
        
//        SVProgressHUD.show()
//        loaddata()
        
    }
    
    
        
        
    var lat1:String!
    var long1:String!
    
    func fetchlatlong(lat: String, long: String) {
        lat1 = lat
        long1 = long
        
//        SVProgressHUD.show()
//        loaddata()
        
        
        
        if self.flag_guest == "1"
        {
            
            SVProgressHUD.show()
            loaddata()
        }
            
        else
            
        {
            
            SVProgressHUD.show()
            loaddata_GUEST()
            
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        
        if  textField == auto_txt
        {
            
            
//            let s = UIStoryboard.init(name: "Main", bundle: nil)
//
//            let obj = s.instantiateViewController(withIdentifier: "ga") as! google_auto
//            //self.present(obj, animated: true, completion: nil)
//            self.navigationController?.pushViewController(obj, animated: true)
            
            
        }
        
        
    }
    
    @IBAction func apply(_ sender: Any) {
        
        cross()
        SVProgressHUD.show()
        loaddata()
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        cross()
        
    }
    
    @IBAction func filter(_ sender: Any) {
        
        if auto_txt.text=="" {
            
            AppManager().AlertUser("WARNING", message: "Please Select Location", vc: self)

            
        }
        else
        {
            
            popup()
            
        }
        
    }
    
    func  popup()
    {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.view.bounds
        
        self.view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        
        self.view.addSubview(self.view1)
        
        self.view1.center =  self.view.center
        
        self.view1.transform = CGAffineTransform (scaleX: 1.3, y: 1.3)
        
        self.view1.alpha = 0
        
        
        
        UIView.animate(withDuration: 0.3, animations: {
            
            
            self.view1.alpha = 1
            
            self.view1.transform = .identity
            
            
        })
        
        
        
    }
    
    func cross()
    {
        self.blurEffectView.removeFromSuperview()
        
        UIView.animate(withDuration: 0.3, animations: {
            
            
            
            
            self.view1.transform = CGAffineTransform (scaleX: 1.3, y: 1.3)
            
            
            self.view1.alpha=1
            
            
        })
        
        
        self.view1.removeFromSuperview()
        
        
        
    }
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        if  token  ==  nil
        {
            
            SVProgressHUD.dismiss()
        }
            
        else
        {
        
        
        
        
        // print(token)
        
        //address=kolkata&city=kolkata&state=wb&country=india&postal_code=700102&service_id=7
        
        let headers: HTTPHeaders = [
            "token": token as! String,

            ]
        
        
//        let params: Parameters = [Parameter.address: auto_txt.text!,
//                                  Parameter.city: str_city!,
//                                  Parameter.state: str_state!,
//                                  Parameter.country: str_country!,
//                                  Parameter.postal_code: str_zip!,
//                                  Parameter.service_id: ser_id!
//        ]
        
        let params: Parameters = [Parameter.latitude: lat1!,
                                  Parameter.longitude: long1!,
                                  Parameter.service_id: ser_id!,
                                  "min_rate":min_rate!,
                                  "max_rate":max_rate!,
                                  "filter_price":filter_price
            
            
            
        ]
        
        print("--gggg-\(params)-jjj---\(Webservice.provider_list_by_service_location)")
        Alamofire.request(Webservice.provider_list_by_service_location, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
//                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
//                        self.navigationController?.pushViewController(obj, animated: true)
                        
                        self.ary = dict["data"] as! NSArray
                        
                        self.col.dataSource=self
                        
                        self.col.isHidden = false
                        
                        self.col.reloadData()
                        
                        self.nodata.isHidden=true
                        
                        self.results.text = "\(String(self.ary.count)) result(s) found"
                        
                        self.results.textAlignment = .center
                        
                     //   self.place.text = "\(self.str_city!), \(self.str_country!)"
                        
                        SVProgressHUD.dismiss()

                    }
                    else
                    {
                       //AppManager().AlertUser("Message", message: msg, vc: self)
                        
                        self.nodata.isHidden=false
                        self.nodata.text=msg
                        
                        self.col.isHidden = true
                        
                        self.results.text = "No result found"
                        
                        //self.place.text = "\(self.str_city!), \(self.str_country!)"
                        
                        self.place.text = "\(self.auto_txt.text!)"
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
        
        
    }
    func loaddata_GUEST() {
        
       // let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        //address=kolkata&city=kolkata&state=wb&country=india&postal_code=700102&service_id=7
        
        let headers: HTTPHeaders = [
            "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIyIiwidXNlcl9pZCI6IjIzIiwiZmlyc3RfbmFtZSI6Ikd1ZXN0IiwibGFzdF9uYW1lIjoidXNlciIsImVtYWlsIjoiZ3Vlc3RAZ21haWwuY29tIiwicGhvbmVfbnVtYmVyIjoiNzg5NDU2OTg1NiIsImRhdGVfb2ZfYmlydGgiOiIxOTcwLTAxLTAxIiwiYWRkcmVzcyI6Ik5ldyBZb3JrLCBOWSwgVVNBIiwiY2l0eSI6Ik5ldyBZb3JrIiwic3RhdGUiOiJOZXcgWW9yayIsImNvdW50cnkiOiIxOTMiLCJwcm9maWxlX2ltYWdlIjpudWxsLCJ1c2VyX3ByaW1hcnlfaWQiOiIyMyIsInByb2ZpbGVfaWQiOiIyIiwidXNlcm5hbWUiOiJndWVzdEBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjgyN2NjYjBlZWE4YTcwNmM0YzM0YTE2ODkxZjg0ZTdiIiwidXNlcl90eXBlIjoiVXNlcnMiLCJhY3RpdmUiOiIxIn0.tsoc6IpEHJ_Lj5BMyviucAXyyy4MReSwl1Y84Vf3lI8",
            
            ]
        
        
        //        let params: Parameters = [Parameter.address: auto_txt.text!,
        //                                  Parameter.city: str_city!,
        //                                  Parameter.state: str_state!,
        //                                  Parameter.country: str_country!,
        //                                  Parameter.postal_code: str_zip!,
        //                                  Parameter.service_id: ser_id!
        //        ]
        
        let params: Parameters = [Parameter.latitude: lat1!,
                                  Parameter.longitude: long1!,
                                  Parameter.service_id: ser_id!,
                                  "min_rate":min_rate!,
                                  "max_rate":max_rate!,
                                  "filter_price":filter_price
            
            
            
        ]
        
        print("--gggg-\(params)-jjj---\(Webservice.provider_list_by_service_location)")
        Alamofire.request(Webservice.provider_list_by_service_location, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        //                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
                        //                        self.navigationController?.pushViewController(obj, animated: true)
                        
                        self.ary = dict["data"] as! NSArray
                        
                        self.col.dataSource=self
                        
                        self.col.isHidden = false
                        
                        self.col.reloadData()
                        
                        self.nodata.isHidden=true
                        
                        self.results.text = "\(String(self.ary.count)) result(s) found"
                        
                        self.results.textAlignment = .center
                        
                        //   self.place.text = "\(self.str_city!), \(self.str_country!)"
                        
                        SVProgressHUD.dismiss()
                        
                    }
                    else
                    {
                        //AppManager().AlertUser("Message", message: msg, vc: self)
                        
                        self.nodata.isHidden=false
                        self.nodata.text=msg
                        
                        self.col.isHidden = true
                        
                        self.results.text = "No result found"
                        
                        //self.place.text = "\(self.str_city!), \(self.str_country!)"
                        
                        self.place.text = "\(self.auto_txt.text!)"
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.lbl_count.isHidden = true
      
        
//noti_count()
        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        des_obj.round_corner(my_view: lower_view,value: 6)
        des_obj.view_round(my_view: bell_view)
        des_obj.round_corner(my_view: auto_view,value: 6)
        
        col.dataSource=nil
//
//        SVProgressHUD.show()
//        loaddata()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

       
        
        min_rate="0.00"
        max_rate="5.00"
        
        heading.text = ser_name
        
        nodata.isHidden=true
        
        self.results.text = ""
        
        self.place.text = ""
        
        CreateRangeSlider()
        
        picker(sorting)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        
        
    }
    
    
    @IBOutlet var btn_msg: UIButton!
    @IBOutlet var btn_profile: UIButton!
    func check_tab()
        
    {
        
        
        
        
        
        
        
      
                
                
                
                
                
                
                if  self.flag_guest == "1"
                {
                    
                    
                    
//                    SVProgressHUD.show()
//                    self.loaddata()
                    
                    self.btn_msg.isHidden = false
                 
                    self.btn_profile.isHidden = false
                      self.btn_n.isHidden = false
                 
                    
                    
                    print("ok")
                    
                }
                    
                    
                else
                    
                {
                    self.btn_msg.isHidden = true
                    self.btn_n.isHidden = true

                    self.btn_profile.isHidden = true
                    //SVProgressHUD.show()
                    
                    //loaddata_GUEST()
                    
                    print("holo nah")
                    
                    
                }
                
                
                
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ary.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tabcell = collectionView.dequeueReusableCell(withReuseIdentifier: "c1", for: indexPath) as! cell
        
        let dict = ary[indexPath.row] as! NSDictionary
        
        tabcell.name.text = dict["name"] as? String
       // tabcell.add.text = dict["address"] as? String
        
      //  tabcell.add.text = dict["address"] as? String
 tabcell.add.text = "\( dict["city"]!)\( dict["state"]!)"
        tabcell.rating.text = "\(dict["rating"]!)"
        tabcell.users.text =  "\(dict["usercount"]!) Reviews"
        
        
        let price1 = "\(dict["min_price"]!)"
        
        
        let price_value = Float(price1)
        
        let amt = price_value! * 20 / 100
        
        let amt1   = Float(amt)
        
        
        let total = price_value! + amt1
        
        
        print("total-----\(total)")
        
          let   mmmm = String (format: "%.2f", total)
        
        tabcell.price.text="$\(mmmm)"
        
        
        let favorite_status = "\(dict["favorite_status"]!)"
        
        if favorite_status=="1" {
            tabcell.like_img.image=UIImage (named: "like (1).png")
        }
        else
        {
            tabcell.like_img.image=UIImage (named: "like (2).png")
        }
        
        
        
        
        let str_img1 = dict["feature_image"] as! String

        if str_img1=="" {

            tabcell.imgvw.image = UIImage (named: "def.jpg")

        }
        else
        {

            let url = URL(string: str_img1)
            tabcell.imgvw.kf.setImage(with: url)

        }
        
        tabcell.like.tag=indexPath.row
        tabcell.like.addTarget(self, action: #selector(likeunlike(sender:)), for: .touchUpInside)
        
        
        if  self.flag_guest == "1"
        {
            
            tabcell.like_img.isHidden = false
            
        }
        
        else
        
        {
            tabcell.like_img.isHidden = true
            
            

            
        }
        
        return tabcell
        
    }
    
    
    @IBOutlet weak var lbl_count: UILabel!
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
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
      //  let token1 = FIRInstanceID.instanceID().token()
//        let avl = token1 as! String
//        if  avl != nil
//        {
//            
//            print("-----------------------------------\(token1)")
//            //   let params: Parameters  [Parameter.device_token: token1!
//            //   ]
            
            
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
                            
                            // self.lbl_count.text = notification_count1
                            self.bell_view.isHidden = false
                            
                            
                            UserDefaults.standard.set("1", forKey: "noti")
                            SVProgressHUD.dismiss()
                            
                        }
                        else
                        {
                            self.bell_view.isHidden = true
                            
                            
                            
                            
                            SVProgressHUD.dismiss()
                            
                        }
                        
                        self.lbl_count.isHidden = true
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
                        
                        break
                        
                    case .failure(_):
                        print("Network Error")
                        SVProgressHUD.dismiss()
                        break
                        
                    }
            }
            
       // }
            
        }
        
        //SVProgressHUD.dismiss()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict = ary[indexPath.row] as! NSDictionary
        let str_id = "\(dict["lanscaper_id"]!)"
        let favorite_status = "\(dict["favorite_status"]!)"
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "sd") as! ServiceDetails
        obj.str_landscaperid=str_id
        obj.str_ser_id=ser_id
        obj.flag_guest = self.flag_guest
        
        //obj.like_status=favorite_status
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    @IBAction func likeunlike(sender:UIButton)
    {
        let dict = ary[sender.tag] as! NSDictionary
        let favorite_status = "\(dict["favorite_status"]!)"
        let landscaper_id = "\(dict["lanscaper_id"]!)"
        if favorite_status=="1" {
            loadunllike(landscaper_id: landscaper_id)
        }
        else
        {
            loadlike(landscaper_id: landscaper_id)
        }
    }
    
    func loadlike(landscaper_id:String)
    {
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        //address=kolkata&city=kolkata&state=wb&country=india&postal_code=700102&service_id=7
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.landscaper_id: landscaper_id,
                                  Parameter.status: "1"
        ]
        
        
        Alamofire.request(Webservice.add_favorite, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        self.loaddata()
                        
                    }
                    else
                    {
                        AppManager().AlertUser("Message", message: msg, vc: self)
                        
                    }
                    
                    
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
        
        //SVProgressHUD.dismiss()
        
    }
    
    func loadunllike(landscaper_id:String)
    {
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        //address=kolkata&city=kolkata&state=wb&country=india&postal_code=700102&service_id=7
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.landscaper_id: landscaper_id,
                                  Parameter.status: "0"
        ]
        
        
        Alamofire.request(Webservice.remove_favorite, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        self.loaddata()
                        
                    }
                    else
                    {
                        AppManager().AlertUser("Message", message: msg, vc: self)
                        
                    }
                    
                    
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
        
        //SVProgressHUD.dismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         let DB_BASE = FIRDatabase.database().reference()
        
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
                  
                    
                    
                    print("ok")
                    
                }
                    
                    
                else
                    
                {
                    
                    self.flag_guest = "0"
                    
                
                    print("holo nah")
                    
                    
                }
                
                
                
                
                
            }
            
        })
        
        
        
        
        
        
        noti_count()
        self.navigationController?.isNavigationBarHidden = true
        //col.dataSource=nil
       check_tab()
       
        
//        SVProgressHUD.show()
//        loaddata()
        //nodata.isHidden=true
        
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
                // AppManager().AlertUser("", message: a, vc: self)
                
                red_msg.isHidden = false
            }
        }
            
        else
        {
            
            red_msg.isHidden = true
            
            
        }
        
        
       
        
        

        
        
        
        
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
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
            self.navigationController?.pushViewController(obj, animated: false)
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
        }
        
        
        
        
    }
    
    //MARK: RangeSlider
    
    
    func CreateRangeSlider()  {
        rangeSlider = RangeSlider(frame: CGRect(x: fakeview.frame.origin.x, y: fakeview.frame.origin.y, width: fakeview.frame.size.width, height: fakeview.frame.size.height))
        view1.addSubview(rangeSlider)
        //rangeSlider.trackTintColor=UIColor.white
        rangeSlider.trackHighlightTintColor=UIColor(red: 19.00/256, green: 192.00/256, blue: 155.00/256, alpha: 1.00)
        rangeSlider.thumbTintColor=UIColor.white
        rangeSlider.thumbBorderColor=UIColor(red: 19.00/256, green: 192.00/256, blue: 155.00/256, alpha: 1.00)
        rangeSlider.thumbBorderWidth=4
        
        rangeSlider.minimumValue=0.0
        rangeSlider.maximumValue=5.0
        
        rangeSlider.lowerValue=0.0
        rangeSlider.upperValue=5.0
        
        
        
        
        rangeSlider.addTarget(self, action: #selector(self.rangeSliderValueChanged(_:)),
                              for: .valueChanged)
        
        
    }
    
    
    
    @IBAction func rangeSliderValueChanged(_ sender: Any) {
        
        
        
        let  rating_from1 = String (format: "%.2f", rangeSlider.lowerValue)
        max_rate = String (format: "%.2f", rangeSlider.upperValue)
        
        min_rate =  rating_from1
        
        
        print("Range slider lower value: \(min_rate)")
        print("Range slider upper value: \(max_rate)")
        
        
        
    }
    
    
    // MARK:  Gps MAP
    var locationstart = CLLocation()
    
    //MARK: lat long convert to address
    
    func getPlacemark111(forLocation location: CLLocation, completionHandler: @escaping (CLPlacemark?, String?) -> ()) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location, completionHandler: {
            placemarks, error in
            
            if let err = error {
                completionHandler(nil, err.localizedDescription)
            } else if let placemarkArray = placemarks {
                if let placemark = placemarkArray.first {
                    completionHandler(placemark, nil)
                } else {
                    completionHandler(nil, "Placemark was nil")
                }
            } else {
                completionHandler(nil, "Unknown error")
            }
        })
    }


    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        let latestLocation: CLLocation = locations[locations.count - 1]
        
      
        
        lat1 = String(format: "%.4f",
                       latestLocation.coordinate.latitude)
        long1 = String(format: "%.4f",
                        latestLocation.coordinate.longitude)
        
        locationManager.stopUpdatingLocation()
        let location = locations.last
        lat = (location?.coordinate.latitude)!
        long = (location?.coordinate.longitude)!
        
        //print("tnay-----lat-------\(str1)------lon---\(str2)")
        locationstart = CLLocation (latitude: lat, longitude: long)

        locationstart_curent_location = CLLocation (latitude: lat, longitude: long)

        if self.flag_guest == "1"
        {
        
        SVProgressHUD.show()
        loaddata()
        }
        
        else
        
        {
            
            SVProgressHUD.show()
           loaddata_GUEST()
            
        }
        currentaddress(locationstart: locationstart)

    }
    
    
func currentaddress(locationstart:CLLocation)
{
    // let  kkk  = CLLocationCoordinate2DMake(Double(lat1), Double(long1))
    
    getPlacemark111(forLocation:locationstart ) {
        (locationstart, error) in
        if let err = error {
            print(err)
        } else if let placemark = locationstart {
            // Do something with the placemark
            
            let str = placemark.addressDictionary?["Name"] as? String
            
            let city = placemark.addressDictionary?["City"] as? String
            
            self.auto_txt.text = str! + city!
            SVProgressHUD.show()
            self.loaddata()
        }
        
      
    }
}
    
     @IBAction func currentlocation(_ sender: Any) {
        
        
        
        
        current_Location()
    }
    
    func current_Location()
    {
        //        locationstart_curent_location = CLLocation (latitude: lat,
        
        currentaddress(locationstart: locationstart_curent_location)
    
       
        
        
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
        
        
    }

}
