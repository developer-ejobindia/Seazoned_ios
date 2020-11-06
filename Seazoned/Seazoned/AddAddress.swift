//
//  AddAddress.swift
//  Seazoned
//
//  Created by Apple on 17/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Firebase
class AddAddress: UIViewController,trasfardata {
    func fetchlatlong(lat: String, long: String) {
        
    }
    

    @IBOutlet weak var heading: UILabel!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var address: UITextField!
     @IBOutlet weak var red_msg: UIImageView!
    var edit_flag:String!
    //var str_addid:String!
    var all_data:NSDictionary!
    
    var state1:String!
    var city1:String!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    @IBAction func done(_ sender: Any) {
        if name.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Name", vc: self)
            //print("enter email")
        }
            
        else if phone.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Phone Number", vc: self)
            //print("enter email")
        }
        else if email.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Email", vc: self)
            //print("enter email")
        }
        else if !AppManager().isValidEmail(testStr: email.text!) {
            
            AppManager().AlertUser("ERROR", message: "Please Enter Valid Email Id", vc: self)
            
        }
        else if address.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Address", vc: self)
            //print("enter email")
        }
        else
        {
          
            if edit_flag=="0"
            {
                SVProgressHUD.show()
                loaddata()
            }
            else
            {
                SVProgressHUD.show()
                loadedit()
            }
            
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
        
        address.text=add
        state1=state
        city1=city
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addDoneButtonOnKeyboard()
        
        if edit_flag=="1" {
            heading.text="Edit Address"
            name.text = "\(all_data["name"]!)"
            address.text = "\(all_data["address"]!)"
            phone.text = "\(AppManager().nullToNil(value: all_data["contact_number"]! as AnyObject))"
            email.text = "\(all_data["email_address"]!)"
            state1="\(all_data["state"]!)"
            city1="\(all_data["city"]!)"
        }
        else
        {
            heading.text="Add Address"
        }
        
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
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        doneToolbar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(Register.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        phone.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction() {
        phone.resignFirstResponder()
    }
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.state: state1!,
                                  Parameter.city: city1!,
                                  Parameter.street_address: address.text!,
                                  Parameter.contact_number: phone.text!,
                                  Parameter.email_address: email.text!,
                                  Parameter.contact_name: name.text!]
        
        
        Alamofire.request(Webservice.add_address_book, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        let alert = UIAlertController(title: "",message: msg,preferredStyle:.alert)
                        
                        alert.addAction(UIAlertAction (title:"OK", style: .cancel, handler: {
                            
                            alert in self.pushback()
                            
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
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
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadedit() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        let str_addid = "\(all_data["id"]!)"
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.state: state1!,
                                  Parameter.city: city1!,
                                  Parameter.street_address: address.text!,
                                  Parameter.contact_number: phone.text!,
                                  Parameter.email_address: email.text!,
                                  Parameter.contact_name: name.text!,
                                  Parameter.address_id: str_addid]
        
        
        Alamofire.request(Webservice.edit_address_book, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        let alert = UIAlertController(title: "",message: msg,preferredStyle:.alert)
                        
                        alert.addAction(UIAlertAction (title:"OK", style: .cancel, handler: {
                            
                            alert in self.pushback()
                            
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
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
