//
//  Snowremoval.swift
//  Seazoned
//
//  Created by Apple on 19/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Firebase
class Snowremoval: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var size1: UITextField!
    @IBOutlet var view_save: UIView!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet var img1: UIImageView!
    @IBOutlet var img2: UIImageView!
    @IBOutlet var img3: UIImageView!
    @IBOutlet var img4: UIImageView!
    @IBOutlet var img5: UIImageView!
    @IBOutlet var img6: UIImageView!
    
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!
    @IBOutlet var lbl4: UILabel!
    @IBOutlet var lbl5: UILabel!
    @IBOutlet var lbl6: UILabel!
    @IBOutlet var pricetotal: UILabel!
    var ser_id:String!
    var added_ser_id:String!
    var x:Float!
    var value1:Float!
    var value2:Float!
    var value3:Float!
    var value4:Float!
    var value5:Float!
    var ary2 : NSArray!
    var ary : NSArray!
    var ary3 : NSArray!
    var pick : UIPickerView!
    var drivway : String!
     var servicetype : String!
    var placeholderServiceTypeString = "" //Placeholder String
    var global_dict:NSDictionary!
    
    var mybool1 = true
    var mybool2 = false
    var mybool3 = false
    
    @IBAction func `continue`(_ sender: Any) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "book") as! Booking
        //obj.ser_id=str_ser_id
        obj.landscraper_id=added_ser_id
        obj.totalprice = x
        obj.ser_id=ser_id
        obj.a = size1.text
        obj.b = drivway
        obj.c = servicetype
        obj.d = ""
        self.navigationController?.pushViewController(obj, animated: true)
        
        
    }
    
    @IBAction func btn(_ sender: UIButton)
    {
        
        
    
        if sender.tag==0 {
            
            img1.alpha=1
            img2.alpha=0.5
            img3.alpha=0.5
            
            lbl1.textColor=UIColor (red: 82.0/255.0, green: 209.0/255.0, blue: 160.0/255.0, alpha: 1.0)
            lbl2.textColor=UIColor.lightGray
            lbl3.textColor=UIColor.lightGray
            
            let dict1 = global_dict["data"] as! NSDictionary
            self.ary2 = dict1["snow_driveway_type"] as! NSArray
            let dict22 = self.ary2[0] as! NSDictionary
            let strvalue2 = "\(dict22["service_field_price"]!)"
            self.value2=Float(strvalue2)
            drivway = "Straight"
            
            
        }
            
        else if sender.tag==1 {
            img1.alpha=0.5
            img2.alpha=1
            img3.alpha=0.5
            
            lbl2.textColor=UIColor (red: 82.0/255.0, green: 209.0/255.0, blue: 160.0/255.0, alpha: 1.0)
            lbl1.textColor=UIColor.lightGray
            lbl3.textColor=UIColor.lightGray
            
            let dict1 = global_dict["data"] as! NSDictionary
            self.ary2 = dict1["snow_driveway_type"] as! NSArray
            let dict22 = self.ary2[1] as! NSDictionary
            let strvalue2 = "\(dict22["service_field_price"]!)"
            self.value2=Float(strvalue2)
            drivway = "Circular"
        }
            
        else if sender.tag==2 {
            img1.alpha=0.5
            img2.alpha=0.5
            img3.alpha=1
            
            lbl3.textColor=UIColor (red: 82.0/255.0, green: 209.0/255.0, blue: 160.0/255.0, alpha: 1.0)
            lbl2.textColor=UIColor.lightGray
            lbl1.textColor=UIColor.lightGray
            
            let dict1 = global_dict["data"] as! NSDictionary
            self.ary2 = dict1["snow_driveway_type"] as! NSArray
            let dict22 = self.ary2[2] as! NSDictionary
            let strvalue2 = "\(dict22["service_field_price"]!)"
            self.value2=Float(strvalue2)
            drivway = "Incline"
        }
            
        else if sender.tag==3 {
            
            if mybool1==true
            {
                img4.alpha=0.5
                lbl4.textColor=UIColor.lightGray
                self.value3=0.00
                servicetype  = ""

                if placeholderServiceTypeString.contains(", Front Door Walkway") {
                    placeholderServiceTypeString = placeholderServiceTypeString.replacingOccurrences(of: ", Front Door Walkway", with: "")
                } else if placeholderServiceTypeString.contains("Front Door Walkway, ") {
                    placeholderServiceTypeString = placeholderServiceTypeString.replacingOccurrences(of: "Front Door Walkway, ", with: "")
                } else if placeholderServiceTypeString.contains("Front Door Walkway") {
                    placeholderServiceTypeString = placeholderServiceTypeString.replacingOccurrences(of: "Front Door Walkway", with: "")
                } 
                
                servicetype = placeholderServiceTypeString
                print(servicetype)
                
                mybool1=false
            }
            else
            {
                img4.alpha=1
                //img5.alpha=0.5
                //img6.alpha=0.5

                lbl4.textColor=UIColor (red: 82.0/255.0, green: 209.0/255.0, blue: 160.0/255.0, alpha: 1.0)
                //lbl5.textColor=UIColor.lightGray
                //lbl6.textColor=UIColor.lightGray

                let dict1 = global_dict["data"] as! NSDictionary
                self.ary3 = dict1["snow_service_type"] as! NSArray
                let dict33 = self.ary3[0] as! NSDictionary
                let strvalue3 = "\(dict33["service_field_price"]!)"
                self.value3=Float(strvalue3)
                servicetype = "Front Door Walkway"
                
                if placeholderServiceTypeString.isEmpty {
                    placeholderServiceTypeString.append("Front Door Walkway")
                } else {
                    placeholderServiceTypeString.append(", Front Door Walkway")
                }

                mybool1=true
            }
            
            servicetype = placeholderServiceTypeString
            print(servicetype)

//            img4.alpha=1
//            img5.alpha=0.5
//            img6.alpha=0.5
//
//            lbl4.textColor=UIColor (red: 82.0/255.0, green: 209.0/255.0, blue: 160.0/255.0, alpha: 1.0)
//            lbl5.textColor=UIColor.lightGray
//            lbl6.textColor=UIColor.lightGray
//
//            let dict1 = global_dict["data"] as! NSDictionary
//            self.ary3 = dict1["snow_service_type"] as! NSArray
//            let dict33 = self.ary3[0] as! NSDictionary
//            let strvalue3 = "\(dict33["service_field_price"]!)"
//            self.value3=Float(strvalue3)
//            servicetype = "Front Door Walkway"
        }
            
        else if sender.tag==4 {
            
            if mybool2==true
            {
                img5.alpha=0.5
                lbl5.textColor=UIColor.lightGray
                self.value4=0.00
                
                servicetype  = ""
                
                if placeholderServiceTypeString.contains(", Stairs & Front Landing") {
                    placeholderServiceTypeString = placeholderServiceTypeString.replacingOccurrences(of: ", Stairs & Front Landing", with: "")
                } else if placeholderServiceTypeString.contains("Stairs & Front Landing, ") {
                    placeholderServiceTypeString = placeholderServiceTypeString.replacingOccurrences(of: "Stairs & Front Landing, ", with: "")
                } else if placeholderServiceTypeString.contains("Stairs & Front Landing") {
                    placeholderServiceTypeString = placeholderServiceTypeString.replacingOccurrences(of: "Stairs & Front Landing", with: "")
                }
                
                servicetype = placeholderServiceTypeString
                print(servicetype)
                
                mybool2=false
            }
            else
            {
                //img4.alpha=0.5
                img5.alpha=1
                //img6.alpha=0.5

                lbl5.textColor=UIColor (red: 82.0/255.0, green: 209.0/255.0, blue: 160.0/255.0, alpha: 1.0)
                //lbl4.textColor=UIColor.lightGray
                //lbl6.textColor=UIColor.lightGray

                let dict1 = global_dict["data"] as! NSDictionary
                self.ary3 = dict1["snow_service_type"] as! NSArray
                let dict33 = self.ary3[1] as! NSDictionary
                let strvalue3 = "\(dict33["service_field_price"]!)"
                self.value4=Float(strvalue3)
                
               
                
                servicetype = "Stairs & Front Landing"
                
                if placeholderServiceTypeString.isEmpty {
                    placeholderServiceTypeString.append("Stairs & Front Landing")
                } else {
                    placeholderServiceTypeString.append(", Stairs & Front Landing")
                }
               
                servicetype = placeholderServiceTypeString
                print(servicetype)

                mybool2=true

            }
            
//            img4.alpha=0.5
//            img5.alpha=1
//            img6.alpha=0.5
//
//            lbl5.textColor=UIColor (red: 82.0/255.0, green: 209.0/255.0, blue: 160.0/255.0, alpha: 1.0)
//            lbl4.textColor=UIColor.lightGray
//            lbl6.textColor=UIColor.lightGray
//
//            let dict1 = global_dict["data"] as! NSDictionary
//            self.ary3 = dict1["snow_service_type"] as! NSArray
//            let dict33 = self.ary3[1] as! NSDictionary
//            let strvalue3 = "\(dict33["service_field_price"]!)"
//            self.value3=Float(strvalue3)
//            servicetype = "Stairs & Front Landing"
        }
            
        else if sender.tag==5 {
            
            if mybool3==true
            {
                img6.alpha=0.5
                lbl6.textColor=UIColor.lightGray
                self.value5=0.00
                servicetype  = ""
                
                if placeholderServiceTypeString.contains(", Side Door Walkway") {
                    placeholderServiceTypeString = placeholderServiceTypeString.replacingOccurrences(of: ", Side Door Walkway", with: "")
                } else if placeholderServiceTypeString.contains("Side Door Walkway, ") {
                    placeholderServiceTypeString = placeholderServiceTypeString.replacingOccurrences(of: "Side Door Walkway, ", with: "")
                } else if placeholderServiceTypeString.contains("Side Door Walkway") {
                    placeholderServiceTypeString = placeholderServiceTypeString.replacingOccurrences(of: "Side Door Walkway", with: "")
                }

                servicetype = placeholderServiceTypeString
                print(servicetype)
                
                mybool3=false
            }
            else
            {
                //img4.alpha=0.5
                //img5.alpha=0.5
                img6.alpha=1

                lbl6.textColor=UIColor (red: 82.0/255.0, green: 209.0/255.0, blue: 160.0/255.0, alpha: 1.0)
                //lbl4.textColor=UIColor.lightGray
                //lbl5.textColor=UIColor.lightGray

                let dict1 = global_dict["data"] as! NSDictionary
                self.ary3 = dict1["snow_service_type"] as! NSArray
                let dict33 = self.ary3[2] as! NSDictionary
                let strvalue3 = "\(dict33["service_field_price"]!)"
                self.value5=Float(strvalue3)
              
                        
                         servicetype = "Side Door Walkway"
                        
                if placeholderServiceTypeString.isEmpty {
                    placeholderServiceTypeString.append("Side Door Walkway")
                } else {
                    placeholderServiceTypeString.append(", Side Door Walkway")
                }
                
                servicetype = placeholderServiceTypeString
                print(servicetype)
                mybool3=true

            }
            // MARK: PARTHIB
            
//            img4.alpha=0.5
//            img5.alpha=0.5
//            img6.alpha=1
//
//            lbl6.textColor=UIColor (red: 82.0/255.0, green: 209.0/255.0, blue: 160.0/255.0, alpha: 1.0)
//            lbl4.textColor=UIColor.lightGray
//            lbl5.textColor=UIColor.lightGray
//
//            let dict1 = global_dict["data"] as! NSDictionary
//            self.ary3 = dict1["snow_service_type"] as! NSArray
//            let dict33 = self.ary3[2] as! NSDictionary
//            let strvalue3 = "\(dict33["service_field_price"]!)"
//            self.value3=Float(strvalue3)
//            servicetype = "Side Door Walkway"
        }
            
        else
        {
            
        }
        
       
        var result=Float(self.value1+self.value2)
        result = result + self.value3 //+ self.value4 + self.value5
        
        result = result + self.value3 + self.value4 + self.value5

   //     self.pricetotal.text="$\(result)"
        
      //  var kkk = NSAttributedString()
       // kkk = self.servicetype
       // let myAttrString = NSAttributedString(string: servicetype, attributes: nil)
      // kkk = myAttrString
        
      //  print(kkk)
        
        
      
            self.pricetotal.text="$\(result)0"
        
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
                        
                        self.calculationformowingleafsprinkler(dict: dict)
                        
                        
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
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        //if pickerView == pick {
        let dict = ary[row] as! NSDictionary
        let str = "\(dict["service_field_value"]!)"
        return str
        //        }
        //
        //        else if pickerView == pick2
        //        {
        //            let dict = ary2[row] as! NSDictionary
        //            let str = "\(dict["service_field_value"]!)"
        //            return str
        //        }
        //        else if pickerView == pick3
        //        {
        //            let dict = ary3[row] as! NSDictionary
        //            let str = "\(dict["service_field_value"]!)"
        //            return str
        //        }
        //        else if pickerView == pick4
        //        {
        //            let dict = ary4[row] as! NSDictionary
        //            let str = "\(dict["service_field_value"]!)"
        //            return str
        //        }
        //        else{
        //    return ""
        // }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        
        return 1
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        //if pickerView == pick {
        return ary.count
        
        //        }
        //        else if pickerView == pick2
        //        {
        //            return ary2.count
        //
        //        }
        //        else if pickerView == pick3
        //        {
        //            return ary3.count
        //
        //        }
        //        else if pickerView == pick4
        //        {
        //            return ary4.count
        //
        //        }
        //        else
        //        {
        //            return 0
        //        }
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //        if pickerView == pick
        //        {
        let dict = ary[row] as! NSDictionary
        let str = "\(dict["service_field_value"]!)"
        size1.text = str
        
        let strvalue1 = "\(dict["service_field_price"]!)"
        
        self.value1=Float(strvalue1)
        
        //        }
        //        else if pickerView == pick2
        //        {
        //            let dict = ary2[row] as! NSDictionary
        //            let str = "\(dict["service_field_value"]!)"
        //            size2.text = str
        //
        //            let strvalue2 = "\(dict["service_field_price"]!)"
        //
        //            self.value2=Float(strvalue2)
        //
        //        }
        //
        //        else if pickerView == pick3
        //        {
        //            let dict = ary3[row] as! NSDictionary
        //            let str = "\(dict["service_field_value"]!)"
        //            size3.text = str
        //
        //            let strvalue3 = "\(dict["service_field_price"]!)"
        //
        //            self.value3=Float(strvalue3)
        //
        //        }
        //        else if pickerView == pick4
        //        {
        //            let dict = ary4[row] as! NSDictionary
        //            let str = "\(dict["service_field_value"]!)"
        //            size4.text = str
        //
        //            let strvalue4 = "\(dict["service_field_price"]!)"
        //
        //            self.value4=Float(strvalue4)
        //
        //        }
        
        
        
        
        //        var result=Float(self.value1+self.value2)
        //        let result2=Float(self.value3+self.value4)
        //        result = result + result2
        //
        //        self.pricetotal.text="$\(result)"
        
        
        self.value1=Float(strvalue1)
        var result=Float(self.value1+self.value2)
        result = result + self.value3
        self.pricetotal.text="$\(result)"
        x = Float(result)
    }
    
    
    
    
    
    func calculationformowingleafsprinkler(dict:NSDictionary)  {
        
        global_dict=dict
        
        img1.alpha=1
        img2.alpha=0.5
        img3.alpha=0.5
        
        lbl1.textColor=UIColor (red: 82.0/255.0, green: 209.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        lbl2.textColor=UIColor.lightGray
        lbl3.textColor=UIColor.lightGray
        
        img4.alpha=1
        img5.alpha=0.5
        img6.alpha=0.5
        
        lbl4.textColor=UIColor (red: 82.0/255.0, green: 209.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        lbl5.textColor=UIColor.lightGray
        lbl6.textColor=UIColor.lightGray
        
        var str_param1 : String!
        var str_param2 : String!
        var str_param3 : String!
        let dict1 = dict["data"] as! NSDictionary
        
        
        str_param1="snow_car"
        str_param2="snow_driveway_type"
        str_param3="snow_service_type"
        
        self.ary = dict1[str_param1] as! NSArray
        
        self.ary2 = dict1[str_param2] as! NSArray
        self.ary3 = dict1[str_param3] as! NSArray
        
        self.picker(self.size1)
        
        if ary.count==0 {
            self.pricetotal.text="$0.00"
            x=0.00
            self.value1=0.00
        }
        else
        {
            
            let dict11 = self.ary[0] as! NSDictionary
            let str1 = "\(dict11["service_field_value"]!)"
            self.self.size1.text = str1
            let dict22 = self.ary2[0] as! NSDictionary
            let dict33 = self.ary3[0] as! NSDictionary
            //        let str2 = "\(dict22["service_field_value"]!)"
            
            let strvalue1 = "\(dict11["service_field_price"]!)"
            let strvalue2 = "\(dict22["service_field_price"]!)"
            let strvalue3 = "\(dict33["service_field_price"]!)"
            self.value1=Float(strvalue1)
            self.value2=Float(strvalue2)
            self.value3=Float(strvalue3)
            var result=Float(self.value1+self.value2)
            result = result + self.value3
            x = Float(result)
            if result == Float(Int(result))
            {
                self.pricetotal.text="$\(result)0"
            }
            else
            {
                self.pricetotal.text="$\(result)"
            }
            
        }
        drivway = "Straight"
        servicetype = "Front Door Walkway"

        self.value4=0.00
        self.value5=0.00
    }
    
    
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
    
    func doneClick1() {
        
        size1.resignFirstResponder()
        
        
        
    }
    
    func cancelClick1() {
        size1.resignFirstResponder()
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
        super.viewDidLoad()
        SVProgressHUD.show()
        loaddata()
        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        des_obj.button_round(my_view: view_save)
        
        des_obj.green_gradient(my_view: view_save)
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
