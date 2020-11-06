//
//  EditProfile.swift
//  Seazoned
//
//  Created by Student on 01/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import Firebase

class EditProfile: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet var scroll: UIScrollView!
    
    @IBOutlet var f_name: UITextField!
    
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet var l_name: UITextField!
    
    
    @IBOutlet var phn: UITextField!
    
    
    @IBOutlet var dob: UITextField!
    
    @IBOutlet var street: UITextField!
    
    @IBOutlet weak var label_c_p: UILabel!
    @IBOutlet var city: UITextField!
    
    @IBOutlet var state: UITextField!
    
    @IBOutlet var country: UITextField!
    
    @IBOutlet var view_save: UIView!
    
    
    @IBOutlet var pass: UITextField!
    
    @IBOutlet var view_change: UIView!
    
    var alldata:NSDictionary!
    
    var datePicker :UIDatePicker!
    
    var dob_str:String!
    
    @IBOutlet weak var btn_change: UIButton!
    
    
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(EditProfile.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(EditProfile.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
      //  dateFormatter1.dateFormat="dd MMM yyyy"
        
        dateFormatter1.dateFormat="MMM-d-yyyy"

        dob.text = dateFormatter1.string(from: datePicker.date)
        dob_str = AppManager().reversedateformatter(str_date: dob.text!)
        dob.resignFirstResponder()
    }
    @objc func cancelClick() {
        dob.resignFirstResponder()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        doneToolbar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(EditProfile.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        phn.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        phn.resignFirstResponder()
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
    
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func change(_ sender: Any) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func save(_ sender: Any) {
        
        if f_name.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter First Name", vc: self)
            //print("enter email")
        }
            
        else if l_name.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Last Name", vc: self)
            //print("enter email")
        }
            
        else if phn.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Phone Number", vc: self)
            //print("enter email")
        }
            
        else
        {
            
            
            print("Save")
            
            //            SVProgressHUD.show()
            //
            //
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            //                self.logindata()
            //            }
            
            
            SVProgressHUD.show(withStatus: "Updating Profile...")
            loaddata()
        
        }
        
    }
    
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.first_name: f_name.text!,
                                  Parameter.last_name: l_name.text!,
                                  Parameter.dob: dob_str!,
                                  Parameter.tel: phn.text!]
        
        
        Alamofire.request(Webservice.userinfo_edit, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
                        self.navigationController?.pushViewController(obj, animated: true)
                        
                    }
                    else
                    {
                        
                    }
                    
                    AppManager().AlertUser("Message", message: msg, vc: self)
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
        
        SVProgressHUD.dismiss()
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        scroll.contentSize=CGSize (width: 0, height: view_save.frame.origin.y+view_save.frame.size.height+50)
        
        let des_obj = Design()
        des_obj.button_round(my_view: view_save)
        
        des_obj.green_gradient(my_view: view_save)
        
        des_obj.round_corner(my_view: view_change, value: 5)
        
        let str_logintype = UserDefaults.standard.value(forKey: "logintype") as! String

        if str_logintype=="normal"
        {
            view_change.isHidden=false
            btn_change.isHidden=false
        }
        else
        {
            view_change.isHidden=true
            btn_change.isHidden=true
        }
        
        pickUpDate(dob)
        addDoneButtonOnKeyboard()
        
        f_name.text = self.alldata["first_name"] as? String
        
        l_name.text = self.alldata["last_name"] as? String
        
        phn.text = AppManager().nullToNil(value: self.alldata["phone_number"] as? String as AnyObject)
        
        let str_dob = AppManager().nullToNil(value: self.alldata["date_of_birth"] as? String as AnyObject)
        
        if str_dob==""
        {
    
            dob.text = ""
            
            dob_str = ""
            
        }
        else
        {
            dob.text = AppManager().dateformatter(str_date: str_dob)
            
            dob_str = AppManager().reversedateformatter(str_date: dob.text!)
            
        }
        
        pass.text = "********"
        
        pass.isEnabled=false
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scroll.contentSize=CGSize (width: 0, height: view_save.frame.origin.y+view_save.frame.size.height+300)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scroll.contentSize=CGSize (width: 0, height: view_save.frame.origin.y+view_save.frame.size.height+10)
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
            
        }
            //Profile
        else
        {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
            self.navigationController?.pushViewController(obj, animated: false)
        }
        
        
        
        
    }
    
}
