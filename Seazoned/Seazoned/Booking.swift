//
//  ViewController.swift
//  seazoned page
//
//  Created by apple on 19/03/18.
//  Copyright © 2018 TANAY. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Firebase
class Booking: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UploadImagedelegate,ImageCropViewControllerDelegate {
   
    
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var view5: UIView!
    
    @IBOutlet weak var day5: UILabel!
    
    @IBOutlet weak var price5: UILabel!
    
    var just_flag=0
    
    func sendata() {
        
        let alert = UIAlertController(title: "!!!Congratulations!!!",message: "Your service request has been submitted to the Seazoned provider that you chose.\nYou will be notified shortly that the provider has accepted the request.\nStay Seazoned",preferredStyle:.alert)
        
        alert.addAction(UIAlertAction (title:"Done", style: .cancel, handler: {
            
            alert in self.gotoServiceHistory()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"!!!Congratulations!!!" message:@"Your service request has been submitted to the Seazoned provider that you chose.You will be notified shortly that the provider has accepted the request.Stay Seazoned" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil, nil];
//        [alert show];
        
      
        
        
        
    }
    
    
    
    func gotoServiceHistory()
    {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "sh") as! ServiceHistory
        //            obj.ser_id=str_ser_id
        //            obj.added_ser_id=str_landscaperid
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    
    
//imageView
    
     @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txt_description: UITextField!
    @IBOutlet weak var preferd_time: UITextField!
    @IBOutlet weak var select_service_date: UITextField!
    @IBOutlet weak var p_s1: UILabel!
    @IBOutlet weak var r_s1: UILabel!
    
    @IBOutlet weak var p_s2: UILabel!
    @IBOutlet weak var r_s2: UILabel!
    
    @IBOutlet weak var p_s3: UILabel!
    @IBOutlet weak var r_s3: UILabel!
    
    var landscraper_id:String!
    var flag_recurring : Int = 0
    
    var price : Float!
    
    @IBOutlet weak var p_s4: UILabel!
    @IBOutlet weak var r_s4: UILabel!
    
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var price4: UILabel!
    @IBOutlet weak var day4: UILabel!
    @IBOutlet weak var price3: UILabel!
    @IBOutlet weak var day3: UILabel!
    @IBOutlet weak var day2: UILabel!
    @IBOutlet weak var price2: UILabel!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var day1: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var last_view: UIView!
    
    @IBOutlet weak var con_view: UIView!
    
    @IBOutlet weak var PRICE_VIEW: UIView!
    
    @IBOutlet weak var single: UILabel!
 
    @IBOutlet weak var single_price: UILabel!
    
    @IBOutlet weak var tax: UILabel!
    
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var add_view: UIView!
    
    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var reccc_view: UIView!
    
    var datePicker: UIDatePicker!
    var datePicker2: UIDatePicker!
    
    var ser_id:String!
    
    
    var a : String!
    var b : String!
    var c : String!
    var d : String!
    
    var servicepriceid : String!
    var totalprice : Float!
    
    var address_id:String!
    
    
    var ary : NSArray!
    
    @IBAction func add_address(_ sender: Any) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "addedit") as! AddAddress
        
        obj.edit_flag="0"
        obj.all_data=[:]
        
        self.navigationController?.pushViewController(obj, animated: true)
    }
    @IBAction func `continue`(_ sender: Any) {
        
        if select_service_date.text=="" {
            AppManager().AlertUser("", message: "Please Select a Date", vc: self)
        }
        else if preferd_time.text==""
        {
            AppManager().AlertUser("", message: "Please Select a Time", vc: self)
        }
        else if address_id==""
        {
            AppManager().AlertUser("", message: "Please Choose an Address", vc: self)
        }
        else
        {
    
            if just_flag==0
            {
                AppManager().AlertUser("", message: "Please Select one service frequency.", vc: self)
            }
                
                
            else
            {
                
                print(landscraper_id!)
                print(address_id!)
                print("price list---------\(servicepriceid!)")
                
                
                print(select_service_date.text!)
                print(preferd_time.text!)
                print(price!)
                
                SVProgressHUD.show(withStatus: "Booking Your Request...")
                loadconfirm()
            }
            
        }
        
    }
    
    
    func loadconfirm() {
        
        
        
        
        let currentDateTime = Date()
        
        print(currentDateTime)
        
        let format1 = DateFormatter()
        format1.dateFormat="yyyy-MM-dd HH:mm:ss z"
        let date1 = format1.date(from: "\(currentDateTime)")
        let format2 = DateFormatter()
        format2.dateFormat="yyyy-MM-dd HH:mm:ss"
        let str_result = format2.string(from: date1!)
        
        print(str_result)
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        var  params: Parameters = [:]
        
        let mydate = Time().revdateformat(str_date: select_service_date.text!)
        let mytime = Time().revtimeformat(str_date: preferd_time.text!)
        if ser_id=="1" {
            
            params = [Parameter.landscaper_id: landscraper_id!,
                                  Parameter.address_book_id: address_id!,
                                  Parameter.service_price: price!,
                                  Parameter.service_date: mydate,
                                  Parameter.service_time: mytime,
                                  Parameter.service_price_id: servicepriceid!,
                                  Parameter.additional_note: txt_description.text!,
                                  
                                  
                                  
                                  
                                  Parameter.lawn_area: a!,
                                  Parameter.grass_length:b!,
                                  "booking_time":str_result]
        }
       else if ser_id=="2" {
            
            params = [Parameter.landscaper_id: landscraper_id!,
                      Parameter.address_book_id: address_id!,
                      Parameter.service_price: price!,
                      Parameter.service_date: mydate,
                      Parameter.service_time: mytime,
                      Parameter.service_price_id: servicepriceid!,
                      Parameter.additional_note: txt_description.text!,
                      
                      
                      
                      
                      Parameter.lawn_area: a!,
                      Parameter.leaf_accumulation:b!,"booking_time":str_result]
        }
        
        else if ser_id=="3" {
            
            params = [Parameter.landscaper_id: landscraper_id!,
                      Parameter.address_book_id: address_id!,
                      Parameter.service_price: price!,
                      Parameter.service_date: mydate,
                      Parameter.service_time: mytime,
                      Parameter.service_price_id: servicepriceid!,
                      Parameter.additional_note: txt_description.text!,
                      
                      
                      
                      
                      Parameter.lawn_area: a!,"booking_time":str_result]
        }
        else if ser_id=="4" {
            
            params = [Parameter.landscaper_id: landscraper_id!,
                      Parameter.address_book_id: address_id!,
                      Parameter.service_price: price!,
                      Parameter.service_date: mydate,
                      Parameter.service_time: mytime,
                      Parameter.service_price_id: servicepriceid!,
                      Parameter.additional_note: txt_description.text!,
                      
                      
                      
                      
                      Parameter.lawn_area: a!,"booking_time":str_result]
        }
        else if ser_id=="5" {
            
            params = [Parameter.landscaper_id: landscraper_id!,
                      Parameter.address_book_id: address_id!,
                      Parameter.service_price: price!,
                      Parameter.service_date: mydate,
                      Parameter.service_time: mytime,
                      Parameter.service_price_id: servicepriceid!,
                      Parameter.additional_note: txt_description.text!,
                      
                      
                      
                      
                      Parameter.lawn_area: a!,
                      Parameter.no_of_zones:b!,"booking_time":str_result]
        }
        else if ser_id=="6" {
            
            params = [Parameter.landscaper_id: landscraper_id!,
                      Parameter.address_book_id: address_id!,
                      Parameter.service_price: price!,
                      Parameter.service_date: mydate,
                      Parameter.service_time: mytime,
                      Parameter.service_price_id: servicepriceid!,
                      Parameter.additional_note: txt_description.text!,
                      
                      "booking_time":str_result,
                      
                      
                      Parameter.water_type: a!,
                      Parameter.include_spa:b!, Parameter.pool_type: c!,
                      Parameter.pool_state:d!]
        }
        else if ser_id=="7" {
            
            params = [Parameter.landscaper_id: landscraper_id!,
                      Parameter.address_book_id: address_id!,
                      Parameter.service_price: price!,
                      Parameter.service_date: mydate,
                      Parameter.service_time: mytime,
                      Parameter.service_price_id: servicepriceid!,
                      Parameter.additional_note: txt_description.text!,
                      
                      "booking_time":str_result,
                      
                      
                      Parameter.no_of_cars: a!,
                      Parameter.driveway_type:b!, Parameter.service_type: c!]
        }
        
        
        
        
        
        
        
        
        
        
        Alamofire.request(Webservice.confirm_booking, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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

//                       let alert = UIAlertController(title: "",message: msg,preferredStyle:.alert)
//                       alert.addAction(UIAlertAction (title:"OK", style: .cancel, handler: {
//                            alert in self.pushback()
//                      }))
//
//                        self.present(alert, animated: true, completion: nil)
                        
                        
                        let dict1 = dict["data"] as! NSDictionary
                        
                        let str_bookserid = "\(dict1["bookServiceId"]!)"
                        
                        let uploadby = "\(dict1["upload_by"]!)"
                        
                        
                        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "up1") as! UploadImage
                        
                        popOverVC.bookserid=str_bookserid
                        
                        popOverVC.uploadby=uploadby
                        
                        popOverVC.img=self.image
                        
                        popOverVC.msg=msg
                        popOverVC.delegate=self

                        self.addChildViewController(popOverVC)
                        popOverVC.view.frame = self.view.frame
                        self.view.addSubview(popOverVC.view)
                        popOverVC.didMove(toParentViewController: self)
                        
                        
                        
                        SVProgressHUD.dismiss()
                        
                        
                    }
                    else
                    {
                        AppManager().AlertUser("Message", message: msg, vc: self)
                        SVProgressHUD.dismiss()
                    }
                    
                    
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
        }
        
        //SVProgressHUD.dismiss()
        
    }
    
    func pushback()
    {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
        self.navigationController?.pushViewController(obj, animated: false)
        //self.navigationController?.popViewController(animated: true)
    }
    
    var image : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        image = #imageLiteral(resourceName: "def.jpg")
        txt_description.delegate = self
        let des_obj = Design()
        des_obj.button_round(my_view: con_view)
        
        des_obj.green_gradient(my_view: con_view)
        
        
        
        
//        self.scroll.contentSize = CGSize (width: scroll.frame.size.width, height: scroll.frame.size.height + 1000)
        
        pickUpDate(select_service_date)
        pickUpDate2(preferd_time)
        
        firsttime()
        
   //     tax.text="0.00"
        
        address_id = ""
        
        UserDefaults.standard.setValue("0", forKey: "back_flag")
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func firsttime()
    {
        let ser_priceary=UserDefaults.standard.value(forKey: "serviceprice") as! NSArray
        
        
        
        
        
        if ser_priceary.count==0 {
            reccc_view.isHidden=false
            
//            self.view5.backgroundColor = UIColor.init(red: 201.0/255, green: 37.0/255, blue: 18.0/255, alpha: 1.0)
//
//            self.day5.textColor = UIColor.white
//            self.price5.textColor = UIColor.white
            
            
            self.view5.backgroundColor = UIColor.init(red: 201.0/255, green: 37.0/255, blue: 18.0/255, alpha: 1.0)
            
            self.day5.textColor = UIColor.white
            self.price5.textColor = UIColor.white
            
      //      self.view5.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
            
            
          //  self.day5.textColor = UIColor.black
           // self.price5.textColor = UIColor.red
            
            price1.text="$0.00"
        }
        else
        {
            
            if ser_id=="1" || ser_id=="6" {
                reccc_view.isHidden=true
                
            
                
                self.view4.backgroundColor = UIColor.init(red: 201.0/255, green: 37.0/255, blue: 18.0/255, alpha: 1.0)
                
                self.day4.textColor = UIColor.white
                self.price4.textColor = UIColor.white
                
                self.r_s4.textColor = UIColor.white
                self.p_s4.textColor = UIColor.white
                
                
                
                
                
                
                self.view1.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                self.day1.textColor = UIColor.black
                self.price1.textColor = UIColor.red
                
                self.r_s1.textColor = UIColor.lightGray
                self.p_s1.textColor = UIColor.lightGray
                
                
                
                self.view2.backgroundColor =  UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                self.day2.textColor = UIColor.black
                self.price2.textColor = UIColor.red
                
                self.r_s2.textColor = UIColor.lightGray
                self.p_s2.textColor = UIColor.lightGray
                
                
                
                self.view3.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                
                self.day3.textColor = UIColor.black
                self.price3.textColor = UIColor.red
                
                self.r_s3.textColor = UIColor.lightGray
                self.p_s3.textColor = UIColor.lightGray
                
                
                
               
                
                just_flag=1
                
                
              
                
                
            }
            else
            {
                reccc_view.isHidden=false
                
                self.view5.backgroundColor = UIColor.init(red: 201.0/255, green: 37.0/255, blue: 18.0/255, alpha: 1.0)
                
                self.day5.textColor = UIColor.white
                self.price5.textColor = UIColor.white
                
//                self.view5.backgroundColor = UIColor.init(red: 201.0/255, green: 37.0/255, blue: 18.0/255, alpha: 1.0)
//
//                self.day5.textColor = UIColor.white
//                self.price5.textColor = UIColor.white
                
              //  self.view5.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                
              //  self.day5.textColor = UIColor.black
               // self.price5.textColor = UIColor.red
                let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
                
                let  rate_value =  Float(rate)
                
                
                print("float value-------\(rate_value!)")
                
                
                
                let val4 = totalprice * rate_value!/100
                let per4 = val4 + totalprice
               // let f100 = String(format: "%.2f", per4)
                price5.text="$\(String(format: "%.2f", per4))"
                
            }
            //reccc_view.isHidden=true
            
//            self.view4.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
//
//            self.day4.textColor = UIColor.black
//            self.price4.textColor = UIColor.red
//
//            self.r_s4.textColor = UIColor.lightGray
//            self.p_s4.textColor = UIColor.lightGray
//
//            self.view1.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
//
//            self.day1.textColor = UIColor.black
//            self.price1.textColor = UIColor.red
//
//            self.r_s1.textColor = UIColor.lightGray
//            self.p_s1.textColor = UIColor.lightGray
//
//
//
//            self.view2.backgroundColor =  UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
//
//            self.day2.textColor = UIColor.black
//            self.price2.textColor = UIColor.red
//
//            self.r_s2.textColor = UIColor.lightGray
//            self.p_s2.textColor = UIColor.lightGray
//
//
//
//            self.view3.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
//
//
//            self.day3.textColor = UIColor.black
//            self.price3.textColor = UIColor.red
//
//            self.r_s3.textColor = UIColor.lightGray
//            self.p_s3.textColor = UIColor.lightGray
            
            
            
            let dict1 = ser_priceary[0] as! NSDictionary
            let dict2 = ser_priceary[1] as! NSDictionary
            let dict3 = ser_priceary[2] as! NSDictionary
            let dict4 = ser_priceary[3] as! NSDictionary
            
            day1.text="\(dict1["service_frequency"]!)"
            day2.text="\(dict2["service_frequency"]!)"
            day3.text="\(dict3["service_frequency"]!)"
            day4.text="\(dict4["service_frequency"]!)"
            
            
            var y : Float!
            var z = "\(dict1["discount_price"]!)"
            y = Float(totalprice - Float(z)!)
           // var f = String(format: "%.2f", y)
            
            
            
            let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
            
            let  rate_value =  Float(rate)
            
            
            print("float value-------\(rate_value!)")
            let val = y * rate_value!/100
            let per = val + y
             var f = String(format: "%.2f", per)
            
            price1.text="$\(f)"
            
            if z=="0.00"
            {
                view1.alpha=0.5
                view1.isUserInteractionEnabled=false
            }
            else
            {
                
            }
            
            z = "\(dict2["discount_price"]!)"
            y = Float(totalprice - Float(z)!)
            // var f = String(format: "%.2f", y)
          //  let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
            
        //    let  rate_value =  Float(rate)
            
            
            print("float value-------\(rate_value!)")
            let val1 = y * rate_value!/100
            let per1 = val1 + y
            f = String(format: "%.2f", per1)
            price2.text="$\(f)"
            
            if z=="0.00"
            {
                view2.alpha=0.5
                view2.isUserInteractionEnabled=false
            }
            else
            {
                
            }
            
            z = "\(dict3["discount_price"]!)"
            y = Float(totalprice - Float(z)!)
            // var f = String(format: "%.2f", y)
            
            
          //  let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
            
          //  let  rate_value =  Float(rate)
            
            
            print("float value-------\(rate_value!)")
            let val2 = y * rate_value!/100
            let per2 = val2 + y
          f = String(format: "%.2f", per2)
            price3.text="$\(f)"
            
            if z=="0.00"
            {
                view3.alpha=0.5
                view3.isUserInteractionEnabled=false
            }
            else
            {
                
            }
            
            z = "\(dict4["discount_price"]!)"
            y = Float(totalprice - Float(z)!)
            // var f = String(format: "%.2f", y)
            
            
        //    let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
            
          //  let  rate_value =  Float(rate)
            
            
            print("float value-------\(rate_value!)")
            let val3 = y * rate_value!/100
            let per3 = val3 + y
             f = String(format: "%.2f", per3)
            price4.text="$\(f)"
            
          //  let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
            
          //  let  rate_value =  Float(rate)
            
            
            print("float value-------\(rate_value!)")
            let tax222 = y * rate_value!/100
            
            
            let tax1 = String(format: "%.2f", tax222)
              let alltotal =  y + tax222
            self.tax.text = "$\(tax1)"
            
            
            
            single_price.text = "$\(String(format: "%.2f", totalprice!))"
            total.text = "$\(String(format: "%.2f", alltotal))"
            
            print("hhhhh=======\(self.tax.text!)--------\(tax1)")
            
            
            if z=="0.00"
            {
//                view4.alpha=0.5
//                view4.isUserInteractionEnabled=false
            }
            else
            {
                
            }
            
            price = y!
            
            servicepriceid = "\(dict4["id"]!)"
            flag_recurring = 0
            
        }
        
        
        
        
        
        
       
            
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
 
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true

            tbl.dataSource=nil
            tbl.isHidden=true
            tbl.delegate=self
            //nodata.isHidden=true
            
            SVProgressHUD.show()
            loaddata()
     
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
    
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        Alamofire.request(Webservice.address_book_list,method: .get, headers: headers)
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
                        
                        let dict1 = dict["data"] as! NSDictionary
                        self.ary = dict1["addresses"] as! NSArray
                        self.tbl.dataSource=self
                        self.tbl.isHidden=false
                        //self.nodata.isHidden=true
                        self.tbl.reloadData()
                        self.tbl.tableFooterView=UIView()
                        SVProgressHUD.dismiss()
                        self.createtable()
                    }
                    else
                    {
                        self.tbl.dataSource=nil
                        self.tbl.isHidden=true
                        //self.nodata.isHidden=false
                        //self.nodata.text=msg
                        self.ary = []
                        self.createtable()
                        SVProgressHUD.dismiss()
                    }
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
        }
        
        
        
        //SVProgressHUD.dismiss()
        
    }
    
    @IBAction func addphoto(_ sender: Any) {
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary.count
    }
    
    
    
    //Select one service frequency.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addcll") as! BookCell
        let dict = ary[indexPath.row] as! NSDictionary
        cell.ser_name.text = "\(dict["name"]!)"
        cell.book_id.text = "\(dict["address"]!)"
        cell.named.text = "Phone : \(AppManager().nullToNil(value: dict["contact_number"]! as AnyObject))"
        cell.payment.text = "E-Mail : \(dict["email_address"]!)"
        let des_obj = Design()
        des_obj.round_corner(my_view: cell.edit_view, value: 6)
        cell.btn_edit.tag = indexPath.row
        cell.btn_edit.addTarget(self, action: #selector(self.edit(sender:)), for: .touchUpInside)
        return cell
    }
    
    @IBAction func edit(sender:UIButton)
    {
        let dict = ary[sender.tag] as! NSDictionary
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "addedit") as! AddAddress
        
        obj.edit_flag="1"
        obj.all_data=dict
        
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = ary[indexPath.row] as! NSDictionary
        address_id = "\(dict["id"]!)"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func createtable()
    {
        tbl.frame=CGRect (x: tbl.frame.origin.x, y: tbl.frame.origin.y, width: tbl.frame.size.width, height: CGFloat(ary.count)*100)
        PRICE_VIEW.frame=CGRect (x: PRICE_VIEW.frame.origin.x, y: tbl.frame.origin.y+tbl.frame.size.height, width: PRICE_VIEW.frame.size.width, height: PRICE_VIEW.frame.size.height)
        last_view.frame=CGRect (x: last_view.frame.origin.x, y: PRICE_VIEW.frame.origin.y+PRICE_VIEW.frame.size.height, width: last_view.frame.size.width, height: last_view.frame.size.height)
        scroll.contentSize=CGSize (width: 0, height: last_view.frame.origin.y+last_view.frame.size.height)
    }
    
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker
        
//        var components = DateComponents()
//        components.year = 0
//        let maxDate = Calendar.current.date(byAdding: components, to: Date())
        
        self.datePicker.minimumDate = Date()
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Booking.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Booking.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="YYYY-MM-dd"
        let dd = dateFormatter1.string(from: datePicker.date)
        select_service_date.text = "\(Time().dateformat(str_date: dd))"
        select_service_date.resignFirstResponder()
        //pickUpDate2(preferd_time)
    }
    @objc func cancelClick() {
        select_service_date.resignFirstResponder()
    }
    
    func pickUpDate2(_ textField : UITextField){
        
        // DatePicker
        self.datePicker2 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker2.backgroundColor = UIColor.white
        self.datePicker2.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker2
        
//        if datePicker.date==Date() {
//            self.datePicker2.minimumDate=Date()
//        }
//        else
//        {
//
//        }
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Booking.doneClick2))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Booking.cancelClick2))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClick2() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat="h:mm a"
        preferd_time.text = dateFormatter1.string(from: datePicker2.date)
        preferd_time.resignFirstResponder()
    }
    @objc func cancelClick2() {
        preferd_time.resignFirstResponder()
    }
    
    @IBAction func btn_click(_ sender: UIButton) {
   //     201/37/18
        
        
        let ser_priceary=UserDefaults.standard.value(forKey: "serviceprice") as! NSArray
        
        let dict1 = ser_priceary[0] as! NSDictionary
        let dict2 = ser_priceary[1] as! NSDictionary
        let dict3 = ser_priceary[2] as! NSDictionary
        let dict4 = ser_priceary[3] as! NSDictionary
        //servicepriceid = "\(dict4["service_id"]!)"
        
        if sender.tag == 0
        {
            print("vfvff")
            
            if flag_recurring == 0
            
            {
                self.view1.backgroundColor = UIColor.init(red: 201.0/255, green: 37.0/255, blue: 18.0/255, alpha: 1.0)
                
                self.day1.textColor = UIColor.white
                self.price1.textColor = UIColor.white
                
                self.r_s1.textColor = UIColor.white
                self.p_s1.textColor = UIColor.white
                
                
                self.view2.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                
                self.day2.textColor = UIColor.black
                self.price2.textColor = UIColor.red
                
                self.r_s2.textColor = UIColor.lightGray
                self.p_s2.textColor = UIColor.lightGray
                
                
                self.view3.backgroundColor =  UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                self.day3.textColor = UIColor.black
                self.price3.textColor = UIColor.red
                
                self.r_s3.textColor = UIColor.lightGray
                self.p_s3.textColor = UIColor.lightGray
                
                
                
                self.view4.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                
                self.day4.textColor = UIColor.black
                self.price4.textColor = UIColor.red
                
                self.r_s4.textColor = UIColor.lightGray
                self.p_s4.textColor = UIColor.lightGray
              
                flag_recurring = 0
                
                single.text="Recurring"
                
                servicepriceid = "\(dict1["id"]!)"
                
                
               
                let z = "\(dict1["discount_price"]!)"
                let y = Float(totalprice - Float(z)!)
                price = y
                
                single_price.text = price1.text
                total.text = price1.text
            }
            
            else
            
            {
                
                
                
            }
            
         
        }
    else    if sender.tag == 1
        {
            print("vfvff")
            if flag_recurring == 0
                
            {
            self.view2.backgroundColor = UIColor.init(red: 201.0/255, green: 37.0/255, blue: 18.0/255, alpha: 1.0)
            
            self.day2.textColor = UIColor.white
            self.price2.textColor = UIColor.white
            
            self.r_s2.textColor = UIColor.white
            self.p_s2.textColor = UIColor.white
                
                //  flag_recurring = 1
                
                
                
                
                
                self.view1.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                self.day1.textColor = UIColor.black
                self.price1.textColor = UIColor.red
                
                self.r_s1.textColor = UIColor.lightGray
                self.p_s1.textColor = UIColor.lightGray
                
                
                
                self.view3.backgroundColor =  UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                self.day3.textColor = UIColor.black
                self.price3.textColor = UIColor.red
                
                self.r_s3.textColor = UIColor.lightGray
                self.p_s3.textColor = UIColor.lightGray
                
                
                
                self.view4.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                
                self.day4.textColor = UIColor.black
                self.price4.textColor = UIColor.red
                
                self.r_s4.textColor = UIColor.lightGray
                self.p_s4.textColor = UIColor.lightGray
                
                single_price.text = price2.text
                total.text = price2.text
                single.text="Recurring"
                servicepriceid = "\(dict2["id"]!)"
                
                
                
                let z = "\(dict2["discount_price"]!)"
                let y = Float(totalprice - Float(z)!)
                price = y
            }
            
            
        }
            
            
        else    if sender.tag == 2
        {
            print("vfvff")
            if flag_recurring == 0
                
            {
            self.view3.backgroundColor = UIColor.init(red: 201.0/255, green: 37.0/255, blue: 18.0/255, alpha: 1.0)
            
            self.day3.textColor = UIColor.white
            self.price3.textColor = UIColor.white
            
            self.r_s3.textColor = UIColor.white
            self.p_s3.textColor = UIColor.white
                
                
                
                self.view1.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                self.day1.textColor = UIColor.black
                self.price1.textColor = UIColor.red
                
                self.r_s1.textColor = UIColor.lightGray
                self.p_s1.textColor = UIColor.lightGray
                
                
                
                self.view2.backgroundColor =  UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                self.day2.textColor = UIColor.black
                self.price2.textColor = UIColor.red
                
                self.r_s2.textColor = UIColor.lightGray
                self.p_s2.textColor = UIColor.lightGray
                
                
                
                self.view4.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                
                self.day4.textColor = UIColor.black
                self.price4.textColor = UIColor.red
                
                self.r_s4.textColor = UIColor.lightGray
                self.p_s4.textColor = UIColor.lightGray
                
                
                
                
                single.text="Recurring"
                
                
                servicepriceid = "\(dict3["id"]!)"
                
                single_price.text = price3.text
                total.text = price3.text
                  flag_recurring = 0
                
                let z = "\(dict3["discount_price"]!)"
                let y = Float(totalprice - Float(z)!)
                price = y
            }
        }
            
            
        else    if sender.tag == 3
        {
            print("vfvff")
            if flag_recurring == 0
                
            {
            self.view4.backgroundColor = UIColor.init(red: 201.0/255, green: 37.0/255, blue: 18.0/255, alpha: 1.0)
            
            self.day4.textColor = UIColor.white
            self.price4.textColor = UIColor.white
            
            self.r_s4.textColor = UIColor.white
            self.p_s4.textColor = UIColor.white
                
                
                
                
                
                
                self.view1.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                self.day1.textColor = UIColor.black
                self.price1.textColor = UIColor.red
                
                self.r_s1.textColor = UIColor.lightGray
                self.p_s1.textColor = UIColor.lightGray
                
                
                
                self.view2.backgroundColor =  UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                self.day2.textColor = UIColor.black
                self.price2.textColor = UIColor.red
                
                self.r_s2.textColor = UIColor.lightGray
                self.p_s2.textColor = UIColor.lightGray
                
                
                
                self.view3.backgroundColor = UIColor.init(red: 246.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1.0)
                
                
                self.day3.textColor = UIColor.black
                self.price3.textColor = UIColor.red
                
                self.r_s3.textColor = UIColor.lightGray
                self.p_s3.textColor = UIColor.lightGray
                
                
                
                single.text="Single"
                servicepriceid = "\(dict4["id"]!)"
                single_price.text = price4.text
                total.text = price4.text
                  flag_recurring = 0
                
                let z = "\(dict4["discount_price"]!)"
                let y = Float(totalprice - Float(z)!)
                price =  y
            }
            
            
            
            
            
            
            
        }
        else
        {
            
            //print("must")
//            self.view5.backgroundColor = UIColor.init(red: 201.0/255, green: 37.0/255, blue: 18.0/255, alpha: 1.0)
//
//            self.day5.textColor = UIColor.white
//            self.price5.textColor = UIColor.white
            
            
            
        }
        
        just_flag=1
        
        
        let value = String(format: "%.2f", price)
        
        
        single_price.text = "$\(value)"
        
        let base_price = Float(value)
        
        
        
        if let value_price = base_price
        {
          //  let vvv = String(format: "%.2f", value_price)
            
          //  self.sngl_prc.text = "$\(vvv)"
            
            let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
            
            let  rate_value =  Float(rate)
            
            
            print("float value-------\(rate_value!)")
            
            
            
            let tax = value_price * rate_value!/100
            
            
            let tax1 = String(format: "%.2f", tax)
            
            self.tax.text = "$\(tax1)"
            
            
            let tx_value = Float(tax)
            
            
            
            let total1 =  value_price + tx_value
            
            
            let total_value = String(format: "%.2f", total1)
            
           total.text  = "$\(total_value)"
        }
            
        else
        {
            
            
        }
        
        
        
    }
    
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        
        textField.resignFirstResponder()
        return true
        
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
    
    @IBAction func takePicture() {
        
        // Show options for the source picker only if the camera is available.
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            
            presentPhotoPicker(sourceType: .photoLibrary)
            
            return
            
        }
        
        
        
        let photoSourcePicker = UIAlertController()
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { [unowned self] _ in
            
            self.presentPhotoPicker(sourceType: .camera)
            
        }
        
        let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default) { [unowned self] _ in
            
            self.presentPhotoPicker(sourceType: .photoLibrary)
            
        }
        
        
        
        photoSourcePicker.addAction(takePhoto)
        
        photoSourcePicker.addAction(choosePhoto)
        
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        
        present(photoSourcePicker, animated: true)
        
    }
    
    
    
    func presentPhotoPicker(sourceType: UIImagePickerControllerSourceType) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        picker.sourceType = sourceType
        
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        
        picker.dismiss(animated: true)
        
        
        
        // We always expect `imagePickerController(:didFinishPickingMediaWithInfo:)` to supply the original image.
        
        image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
       imageView.contentMode = UIViewContentMode.center
        
        
//        ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage: _image];
//        controller.delegate = self;
//        controller.blurredBackground = YES;
//        // set the cropped area
//        // controller.cropArea = CGRectMake(0, 0, 100, 200);
//        [[self navigationController] pushViewController:controller animated:YES];
        
        
        
        let  comtroller = ImageCropViewController()
        
        
        comtroller.image = image
        
        comtroller.delegate = self
        
        comtroller.blurredBackground = true
        self.navigationController?.pushViewController(comtroller, animated: true)
        
        
        
//        imageView.image = image
        
       
        
    }
    
    func setProfileImage(imageToResize: UIImage, onImageView: UIImageView) -> UIImage
    {
        let width = imageToResize.size.width
        let height = imageToResize.size.height
        
        var scaleFactor: CGFloat
        
        if(width > height)
        {
            scaleFactor = onImageView.frame.size.height / height;
        }
        else
        {
            scaleFactor = onImageView.frame.size.width / width;
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width * scaleFactor, height: height * scaleFactor), false, 0.0)
        imageToResize.draw(in: CGRect(x:0,y:0,width:width * scaleFactor,height:height * scaleFactor))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!;
    }
    
    func imageCropViewControllerSuccess(_ controller: UIViewController!, didFinishCroppingImage croppedImage: UIImage!) {
        
       // imageView.image = croppedImage
        let myimg = rotateImage(image: croppedImage)
        imageView.image = setProfileImage(imageToResize: myimg, onImageView: imageView)
        // imageView.image = myimg
        imageView.contentMode = UIViewContentMode.scaleToFill
        self.navigationController?.popViewController(animated: true)

        
    }
    
    
    func rotateImage(image:UIImage) -> UIImage
    {
        var rotatedImage = UIImage()
        switch image.imageOrientation
        {
        case .right:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .down)
            
        case .down:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .left)
            
        case .left:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .up)
            
        default:
            rotatedImage = UIImage(cgImage: image.cgImage!, scale: 1.0, orientation: .right)
        }
        
        return rotatedImage
    }
    
    
    func imageCropViewControllerDidCancel(_ controller: UIViewController!) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
}



