//
//  ViewController.swift
//  Seazone page
//
//  Created by Student on 19/03/18.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Firebase
class PricePage : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var size4: UITextField!
    @IBOutlet weak var size3: UITextField!
    @IBOutlet weak var poolview: UIView!
    @IBOutlet var Des_size1: UILabel!
    @IBOutlet var des_size2: UILabel!
    @IBOutlet var servicetype: UILabel!
    @IBOutlet var pricetotal: UILabel!
    @IBOutlet var size1: UITextField!
    @IBOutlet var size2: UITextField!
    var x: Float!
    @IBOutlet var view_save: UIView!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var V2: UIView!
    @IBOutlet weak var img2: UIImageView!
    var ser_id:String!
    var added_ser_id:String!
    
    var value1:Float!
    var value2:Float!
    var value3:Float!
    var value4:Float!
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        if pickerView == pick {
            
            if ser_id == "5"
            {
                if self.ary.count == 0
                {
                    let dict = ary2[row] as! NSDictionary
                    let str = "\(dict["service_field_value"]!)"
                    return str
                }
                else
                {
                    let dict = ary[row] as! NSDictionary
                    let str = "\(dict["service_field_value"]!)"
                    return str
                }
            }
            else
            {
                let dict = ary[row] as! NSDictionary
                let str = "\(dict["service_field_value"]!)"
                return str
            }
            
        }
            
        else if pickerView == pick2
        {
            let dict = ary2[row] as! NSDictionary
            let str = "\(dict["service_field_value"]!)"
            return str
        }
        else if pickerView == pick3
        {
            let dict = ary3[row] as! NSDictionary
            let str = "\(dict["service_field_value"]!)"
            return str
        }
        else if pickerView == pick4
        {
            let dict = ary4[row] as! NSDictionary
            let str = "\(dict["service_field_value"]!)"
            return str
        }
        else{
            return ""
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var ary2 : NSArray!
    var ary : NSArray!
    var ary3 : NSArray!
    var ary4 : NSArray!
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        
        return 1
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pick {
            if ser_id == "5"
            {
                if self.ary.count == 0
                {
                    return ary2.count
                }
                else
                {
                    return ary.count
                }
            }
            else
            {
                return ary.count
            }
        }
        else if pickerView == pick2
        {
            return ary2.count
            
        }
        else if pickerView == pick3
        {
            return ary3.count
            
        }
        else if pickerView == pick4
        {
            return ary4.count
            
        }
        else
        {
            return 0
        }
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == pick
        {
            var dict : NSDictionary!
            if ser_id == "5"
            {
                if self.ary.count == 0
                {
                    dict = self.ary2[row] as! NSDictionary
                    let str = "\(dict["service_field_value"]!)"
                    size1.text = str
                    
                    let strvalue1 = "\(dict["service_field_price"]!)"
                    
                    self.value1=Float(strvalue1)
                }
                else
                {
                    dict = self.ary[row] as! NSDictionary
                    let str = "\(dict["service_field_value"]!)"
                    size1.text = str
                    
                    let strvalue1 = "\(dict["service_field_price"]!)"
                    
                    self.value1=Float(strvalue1)
                }
                
            }
            else
            {
                
                
                dict = ary[row] as! NSDictionary
                let str = "\(dict["service_field_value"]!)"
                size1.text = str
                
                let strvalue1 = "\(dict["service_field_price"]!)"
                
                self.value1=Float(strvalue1)
                
            }
            
        }
        else if pickerView == pick2
        {
            let dict = ary2[row] as! NSDictionary
            let str = "\(dict["service_field_value"]!)"
            size2.text = str
            
            let strvalue2 = "\(dict["service_field_price"]!)"
            
            self.value2=Float(strvalue2)
            
        }
        
        else if pickerView == pick3
        {
            let dict = ary3[row] as! NSDictionary
            let str = "\(dict["service_field_value"]!)"
            size3.text = str
            
            let strvalue3 = "\(dict["service_field_price"]!)"
            
            self.value3=Float(strvalue3)
            
        }
        else if pickerView == pick4
        {
            let dict = ary4[row] as! NSDictionary
            let str = "\(dict["service_field_value"]!)"
            size4.text = str
            
            let strvalue4 = "\(dict["service_field_price"]!)"
            
            self.value4=Float(strvalue4)
            
        }

        var result=Float(self.value1+self.value2)
        
        let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
        
        let  rate_value =  Float(rate)
        
        
        print("float value-------\(rate_value!)")
        
        
        
        let  percentage =  result * rate_value!/100
        let  result1 = result + percentage
        let result2=Float(self.value3+self.value4)
        result = result + result2
        x = Float(result)
        if result == Float(Int(result))
        {
            self.pricetotal.text="$\(result1)0"
        }
        else
        {
            self.pricetotal.text="$\(result1)"
        }
        
    }

    
    
    
    
    var pick : UIPickerView!
    var pick2 : UIPickerView!
    var pick3 : UIPickerView!
    var pick4 : UIPickerView!
    
    func picker(_ textField : UITextField){
        
        // DatePicker
        self.pick = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pick.backgroundColor = UIColor.white
        textField.inputView = self.pick
        
        pick.dataSource = self
        pick.delegate = self
        
        pick.tag=0
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(PricePage.doneClick1))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(PricePage.cancelClick1))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClick1() {
        
        size1.resignFirstResponder()
        
        
        
    }
    
    @objc func cancelClick1() {
        size1.resignFirstResponder()
    }
    
    
    func picker2(_ textField : UITextField){
        
        // DatePicker
        self.pick2 = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pick2.backgroundColor = UIColor.white
        textField.inputView = self.pick2
        
        pick2.dataSource = self
        pick2.delegate = self
        
        pick2.tag=0
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(PricePage.doneClick2))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(PricePage.cancelClick2))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClick2() {
        
        size2.resignFirstResponder()
        
        
        
    }
    
    @objc func cancelClick2() {
        size2.resignFirstResponder()
    }

    func picker3(_ textField : UITextField){
        
        // DatePicker
        self.pick3 = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pick3.backgroundColor = UIColor.white
        textField.inputView = self.pick3
        
        pick3.dataSource = self
        pick3.delegate = self
        
        pick3.tag=0
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(PricePage.doneClick3))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(PricePage.cancelClick3))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
          }
    
    @objc func doneClick3() {
        
        size3.resignFirstResponder()
        
        
        
    }
    
    @objc func cancelClick3() {
        size3.resignFirstResponder()
    }
    
    func picker4(_ textField : UITextField){
        
        // DatePicker
        self.pick4 = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pick4.backgroundColor = UIColor.white
        textField.inputView = self.pick4
        
        pick4.dataSource = self
        pick4.delegate = self
        
        pick4.tag=0
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(PricePage.doneClick4))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(PricePage.cancelClick4))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        }
    
     @objc func doneClick4() {
        
        size4.resignFirstResponder()
        
        
        
       }
    
    @objc func cancelClick4() {
        size4.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        
        
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
    override func viewDidLoad() {
        value2 = 0
        value3 = 0
        value4 = 0
        poolview.isHidden = true
        //ary = ["a", "b"]
        //ary2 = ["a", "b"]
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let des_obj = Design()
        des_obj.button_round(my_view: view_save)
        
        des_obj.green_gradient(my_view: view_save)
        
        fetching()
        
//        SVProgressHUD.show()
//        loadmowing()
    }
    
    func fetching()
    {
        if ser_id=="1" {
            servicetype.text="Lawn Mowing Total"
            des_size2.text="How long is your grass? (Inches)*"

            
        }
        else if ser_id=="2"
        {
            servicetype.text="Leaf Removal Total"
            des_size2.text="What is your leaf accumulation?"

            
        }
        else if ser_id=="3"
        {
            servicetype.text="Lawn Treatment Total"
            size2.isHidden=true
            des_size2.isHidden=true
            V2.isHidden=true
            img2.isHidden=true
            
        }
        else if ser_id=="4"
        {
            servicetype.text="Aeration Total"
            size2.isHidden=true
            des_size2.isHidden=true
            V2.isHidden=true
            img2.isHidden=true
            
        }
        else if ser_id=="5"
        {
            servicetype.text="Sprinkler Winterizing Total"
            des_size2.text="How Many Zones do you Have?"
            size2.isHidden=true
            des_size2.isHidden=true
            V2.isHidden=true
            img2.isHidden=true

        }
        else if ser_id=="6"
        {
            servicetype.text="Pool Cleaning Total"
            Des_size1.text="Pool Water Type? *"
            des_size2.text="Include Spa / Hot Tub? *"
            poolview.isHidden = false
            
        }
        else
        {
            
        }
        SVProgressHUD.show()
        loaddata()
    }
    
    @IBAction func `continue`(_ sender: Any) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "book") as! Booking
        //obj.ser_id=str_ser_id
        obj.landscraper_id=added_ser_id
        obj.totalprice = x
        obj.ser_id=ser_id
        obj.a = size1.text
        obj.b = size2.text
        obj.c = size3.text
        obj.d = size4.text
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
      
        //        let headers: HTTPHeaders = [
        //            "token": token as! String,
        //
        //            ]
        
        let params: Parameters = [Parameter.service_id: ser_id!,
                                  Parameter.added_service_id: added_ser_id!
        ]
        
        
        Alamofire.request(Webservice.view_service, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            
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
                        if self.ser_id=="1" || self.ser_id=="2" || self.ser_id=="5"
                        {
                        self.calculationformowingleafsprinkler(dict: dict)
                        }
                        else if self.ser_id=="3" || self.ser_id=="4"
                        {
                            self.calculationforaerationlawn(dict: dict)
                        }
                        else
                        {
                            self.calculationforpool(dict: dict)
                        }
                        
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
    
    func calculationformowingleafsprinkler(dict:NSDictionary)  {
        
        var str_param1 : String!
        var str_param2 : String!
        
        let dict1 = dict["data"] as! NSDictionary
        
        if ser_id=="1" {
            str_param1="mowing_acre"
            str_param2="mowing_grass"
        }
        else if ser_id=="2"
        {
            str_param1="leaf_acre"
            str_param2="leaf_accumulation"
        }
        else
        {
            str_param1="sprinkler_acre"
            str_param2="sprinkler_zone"
        }
        
        
        if ser_id=="5"
        {
            self.ary = dict1[str_param1] as! NSArray
            
            self.ary2 = dict1[str_param2] as! NSArray
            
            //self.picker(self.size1)
            //self.picker2(self.size2)
            
            des_size2.isHidden=true
            size2.isHidden=true
            
            if ary.count==0 {
                
                
                Des_size1.text = "How Many Zones do you Have?"
                self.picker(self.size1)
                
                //For Zones
                
//                x=0.00
//                self.value1=0.00
//                self.pricetotal.text="$0.00"
                
                
                let dict22 = self.ary2[0] as! NSDictionary
                let str2 = "\(dict22["service_field_value"]!)"
                self.size1.text = str2
                let strvalue2 = "\(dict22["service_field_price"]!)"
                self.value1=Float(strvalue2)
                
                
                let result=Float(self.value1)
                x = Float(result)
                
                let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
                
                let  rate_value =  Float(rate)
                
                
                print("float value-------\(rate_value!)")
                
                let  percentage =  result * rate_value!/100
                let  result1 = result + percentage
                if result == Float(Int(result))
                {
                    self.pricetotal.text="$\(result1)0"
                }
                else
                {
                    self.pricetotal.text="$\(result1)"
                }
                
            }
            else
            {
                //Des_size1.text = ""
                self.picker(self.size1)
                
                let dict11 = self.ary[0] as! NSDictionary
                let str1 = "\(dict11["service_field_value"]!)"
                self.self.size1.text = str1
//                let dict22 = self.ary2[0] as! NSDictionary
//                let str2 = "\(dict22["service_field_value"]!)"
//                self.size2.text = str2
                
                let strvalue1 = "\(dict11["service_field_price"]!)"
                //let strvalue2 = "\(dict22["service_field_price"]!)"
                
                self.value1=Float(strvalue1)
                //self.value2=Float(strvalue2)
                
//                let result=Float(self.value1+self.value2)
//                x = Float(result)
//                if result == Float(Int(result))
//                {
//                    self.pricetotal.text="$\(result)0"
//                }
//                else
//                {
//                    self.pricetotal.text="$\(result)"
//                }
                
                let result=Float(self.value1)
                
                let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
                
                let  rate_value =  Float(rate)
                
                
                print("float value-------\(rate_value!)")
                let  percentage =  result * rate_value!/100
                let  result1 = result + percentage
                x = Float(result)
                if result == Float(Int(result))
                {
                    self.pricetotal.text="$\(result1)0"
                }
                else
                {
                    self.pricetotal.text="$\(result1)"
                }
                
            }
        }
        else
        {
            
            self.ary = dict1[str_param1] as! NSArray
            
            self.ary2 = dict1[str_param2] as! NSArray
            
            self.picker(self.size1)
            self.picker2(self.size2)
            
            if ary.count==0 {
                x=0.00
                self.value1=0.00
                self.pricetotal.text="$0.00"
            }
            else
            {
                
                let dict11 = self.ary[0] as! NSDictionary
                let str1 = "\(dict11["service_field_value"]!)"
                self.self.size1.text = str1
                let dict22 = self.ary2[0] as! NSDictionary
                let str2 = "\(dict22["service_field_value"]!)"
                self.size2.text = str2
                
                let strvalue1 = "\(dict11["service_field_price"]!)"
                let strvalue2 = "\(dict22["service_field_price"]!)"
                
                self.value1=Float(strvalue1)
                self.value2=Float(strvalue2)
                
                let result=Float(self.value1+self.value2)
                
                x = Float(result)
                let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
                
                let  rate_value =  Float(rate)
                
                
                print("float value-------\(rate_value!)")
                let  percentage =  result * rate_value!/100
                let  result1 = result + percentage
                if result == Float(Int(result))
                {
                    self.pricetotal.text="$\(result1)0"
                }
                else
                {
                    self.pricetotal.text="$\(result1)"
                }
                
            }
            
        }
    }

    func calculationforaerationlawn(dict:NSDictionary)  {
        
        var str_param1 : String!
        //var str_param2 : String!
        
        let dict1 = dict["data"] as! NSDictionary
        
        if ser_id=="4" {
            str_param1="aeration_acre"
           // str_param2="mowing_grass"
        }
        else
        {
            str_param1="lawn_acre"
           // str_param2="sprinkler_zone"
        }
        
        self.ary = dict1[str_param1] as! NSArray
        
      //  self.ary2 = dict1[str_param2] as! NSArray
        
        self.picker(self.size1)
     //   self.picker2(self.size2)
        
        if ary.count==0 {
            x=0.00
            self.value1=0.00
            self.pricetotal.text="$0.00"
        }
        else
        {
            
            let dict11 = self.ary[0] as! NSDictionary
            let str1 = "\(dict11["service_field_value"]!)"
            self.self.size1.text = str1
            // let dict22 = self.ary2[0] as! NSDictionary
            // let str2 = "\(dict22["service_field_value"]!)"
            // self.size2.text = str2
            
            let strvalue1 = "\(dict11["service_field_price"]!)"
            // let strvalue2 = "\(dict22["service_field_price"]!)"
            
            self.value1=Float(strvalue1)
            // self.value2=Float(strvalue2)
            
            let result=Float(self.value1)
            let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
            
            let  rate_value =  Float(rate)
            
            
            print("float value-------\(rate_value!)")
            let  percentage =  result * rate_value!/100
            let  result1 = result + percentage
            x = Float(result)
            if result == Float(Int(result))
            {
                self.pricetotal.text="$\(result1)0"
            }
            else
            {
                self.pricetotal.text="$\(result1)"
            }
        }
    }
    
    func calculationforpool(dict:NSDictionary)  {
        
        var str_param1 : String!
        var str_param2 : String!
        var str_param3 : String!
        var str_param4 : String!
        
        
        let dict1 = dict["data"] as! NSDictionary
        
      
            str_param1="pool_water_type"
            str_param2="pool_spa"
        str_param3="pool_type"
        str_param4="pool_state"
        
        
        self.ary = dict1[str_param1] as! NSArray
        
        self.ary2 = dict1[str_param2] as! NSArray
        
        self.ary3 = dict1[str_param3] as! NSArray
        
        self.ary4 = dict1[str_param4] as! NSArray
        
        
        self.picker(self.size1)
        self.picker2(self.size2)
        self.picker3(self.size3)
        self.picker4(self.size4)
        
        let dict11 = self.ary[0] as! NSDictionary
        let str1 = "\(dict11["service_field_value"]!)"
        self.size1.text = str1
        let dict22 = self.ary2[0] as! NSDictionary
        let str2 = "\(dict22["service_field_value"]!)"
        self.size2.text = str2
        
        let dict33 = self.ary3[0] as! NSDictionary
        let str3 = "\(dict33["service_field_value"]!)"
        self.size3.text = str3
        let dict44 = self.ary4[0] as! NSDictionary
        let str4 = "\(dict44["service_field_value"]!)"
        self.size4.text = str4
        
        
        let strvalue1 = "\(dict11["service_field_price"]!)"
        let strvalue2 = "\(dict22["service_field_price"]!)"
        let strvalue3 = "\(dict33["service_field_price"]!)"
        let strvalue4 = "\(dict44["service_field_price"]!)"
        
        self.value1=Float(strvalue1)
        self.value2=Float(strvalue2)
        self.value3=Float(strvalue3)
        self.value4=Float(strvalue4)
        
        var result=Float(self.value1+self.value2)
        let result2=Float(self.value3+self.value4)
        result = result + result2
        
        let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
        
        let  rate_value =  Float(rate)
        
        
        print("float value-------\(rate_value!)")
        let  percentage =  result * rate_value!/100
        let  result1 = result + percentage
        x = Float(result)
        if result == Float(Int(result))
        {
            self.pricetotal.text="$\(result1)0"
        }
        else
        {
        self.pricetotal.text="$\(result1)"
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

