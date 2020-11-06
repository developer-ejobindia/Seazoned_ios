//
//  Register.swift
//  Seazoned
//
//  Created by Student on 01/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol TermsAndConditionsDelegate {
    func updateCheckProperty()
}


class Register: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,trasfardata,TermsAndConditionsDelegate {
    
    var isChecked: Bool = false

    func updateCheckProperty() {
          self.isChecked = termsAndConditionsView.isChecked
    }
    
    func fetchlatlong(lat: String, long: String) {
        
    }
    
     @IBOutlet weak var termsAndConditionsView: TermsAndConditionsView!
    @IBOutlet var logo_view: UIView!
    
    @IBOutlet var scroll: UIScrollView!
    
    @IBOutlet var f_name: UITextField!
    
    @IBOutlet var l_name: UITextField!
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var phone: UITextField!
    
    @IBOutlet var dob: UITextField!
    
    @IBOutlet var street: UITextField!
    
    @IBOutlet var city: UITextField!
    
    @IBOutlet var state: UITextField!
    
    @IBOutlet var coutry: UITextField!
    
    @IBOutlet var eye_img: UIImageView!

    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var con_pass: UITextField!
    
    @IBOutlet var signup_view: UIView!
    
    var pick: UIPickerView!
    
    var con_ary:NSArray!
    
    var con_id:Int!
    
    var str_dob:String!
    
    @IBOutlet var btn_click: UIButton!
    
    
    var datePicker :UIDatePicker!
    
    
    
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
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Register.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Register.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }

    
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
     //   dateFormatter1.dateFormat="MMM d, yyyy"
        
        dateFormatter1.dateFormat="MMM-d-yyyy"

        //dob.text = dateFormatter1.string(from: datePicker.date)
        
        str_dob = dateFormatter1.string(from: datePicker.date)
        
        dob.text = str_dob
        
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
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(Register.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        phone.inputAccessoryView = doneToolbar
       }
    
    @objc func doneButtonAction() {
        phone.resignFirstResponder()
    }
    
    
    @IBAction func sign_up(_ sender: Any) {
        
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
        else if email.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Email", vc: self)
            //print("enter email")
        }
        else if !AppManager().isValidEmail(testStr: email.text!) {
            
            AppManager().AlertUser("ERROR", message: "Please Enter Valid Email Id", vc: self)
            
        }
        else if phone.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Phone Number", vc: self)
            //print("enter email")
        }
        else if street.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Street/Location", vc: self)
            //print("enter email")
        }
        else if city.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter City", vc: self)
            //print("enter email")
        }
        else if state.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter State", vc: self)
            //print("enter email")
        }
            
        else if coutry.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Country", vc: self)
            //print("enter email")
        }
        else if password.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Password", vc: self)
            //print("enter email")
        }
        else if !(password.text == con_pass.text)
        {
            AppManager().AlertUser("WARNING", message: "Password Not Matched", vc: self)
        }
            
      else  if self.termsAndConditionsView.isChecked {
            print("Yay")
            
            
            print("Reg")
            
            
            login_data()
        }
            
        else
        {
            
          AppManager().AlertUser("WARNING", message: "Please click checkbox", vc: self)
            
            
            
        }
        
    }
    
    func login_data()  {
        
        let strEmail = self.email.text
        
        let strPassword = self.password.text
        
        let first_name = self.f_name.text
        let last_name = self.l_name.text
        let tel = self.phone.text
        
        if dob.text == ""
        {
            
            str_dob =  "12-25-1991"
            
        }
        else
        {
        str_dob = Time().revdateformat(str_date: str_dob)
        }
        let street = self.street.text
        
        let city = self.city.text
        let state = self.state.text
        //let country = String(con_id)
        //let street = self.pass.text
        
        
        
        //     if !(strEmail?.isEmpty)! && isEmailValid(strEmail!) && !(strPassword?.isEmpty)! {
        
        let parameters: Parameters = [Parameter.email: strEmail!,
                                      Parameter.password: strPassword!,
                                      Parameter.first_name: first_name!,
                                      Parameter.last_name: last_name!,
                                      Parameter.tel: tel!,
                                      Parameter.dob: str_dob!,
                                      Parameter.street: street!,
                                      Parameter.city: city!,
                                      Parameter.state: state!,
                                      Parameter.country: "193"]
        
        
        Service.request(url: Webservice.register, method: .post, parameters: parameters, displayLoader: true, loaderMessage: "Signing Up...", resposneType: .register) { (login) in
            
            let response = login as! Reg_data
            
            
            
            
            
            
            //                let alert = UIAlertController(title: nil, message: response.msg, preferredStyle: .alert)
            //                alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: nil))
            //                self.present(alert, animated: true, completion: nil)
            
            
            if response.success == 1 {
                
                
                
                
                                let alert = UIAlertController(title: nil, message: response.msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: {alert in
                    
                    self.back()
                  
                }))
                    
                    
                                self.present(alert, animated: true, completion: nil)
                
                
               // let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
              //  self.navigationController?.pushViewController(obj, animated: true)
                
            } else {
                
                //                    let strSessionKey = response.details?.sessionKey
                //                    let strProfilePicture = response.details?.profilePicture
                //
                //                    setBoolean(true, forKey: Default.sessionKeyAvailable)
                //                    setString(strSessionKey!, forKey: Default.sessionKey)
                //                    setString(strProfilePicture!, forKey: Default.profilePicture)
                //
                //                    if response.details?.varified == "yes" {
                //
                //                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                //                        appDelegate.displayHomeScreen()
                
                let alert = UIAlertController(title: nil, message: response.msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scroll.contentSize=CGSize (width: 0, height: btn_click.frame.origin.y+btn_click.frame.size.height+300)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scroll.contentSize=CGSize (width: 0, height: btn_click.frame.origin.y+btn_click.frame.size.height+10)
    }
    func back()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func login(_ sender: Any) {
        
       // self.navigationController?.popViewController(animated: true)
         let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
     //   let obj = self.storyboard?.instantiateViewController(withIdentifier: "reg") as! Register
        
        self.navigationController?.pushViewController(obj, animated: false)
 
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        self.termsAndConditionsView.superViewContorller = self

        
        let des_obj = Design()
        
        des_obj.button_round(my_view: signup_view)
        des_obj.red_gradient(my_view: signup_view)
        des_obj.round_corner(my_view: logo_view,value: 12)
        
        
        scroll.layer.cornerRadius=6
        
        scroll.contentSize=CGSize (width: 0, height: btn_click.frame.origin.y+btn_click.frame.size.height+10)
        
        pickUpDate(dob)  //dob ar jonno
        addDoneButtonOnKeyboard()
        
        des_obj.dropShadow(myview: logo_view)
        
        loadcountries()
        
        picker(coutry)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func btn(_ sender: Any) {
        
        let s = UIStoryboard.init(name: "Main", bundle: nil)
        
        let obj = s.instantiateViewController(withIdentifier: "ga") as! google_auto
        //self.present(obj, animated: true, completion: nil)
        obj.delegate=self
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    var secure_flag = 0
    
    @IBAction func eye(_ sender: Any) {
        if secure_flag==0 {
            password.isSecureTextEntry=false
            con_pass.isSecureTextEntry=false
            eye_img.image=UIImage (named: "view.png")
            secure_flag=1
        }
            
        else
        {
            password.isSecureTextEntry=true
            con_pass.isSecureTextEntry=true
            eye_img.image=UIImage (named: "hide.png")
            secure_flag=0
        }
    }
    func addresssend(add: String, city: String, country: String, zipcode: String, state: String) {
        street.text=add
        self.city.text=city
        coutry.text=country
        //str_zip=zipcode
        self.state.text=state
        
//        SVProgressHUD.show()
//        loaddata()
        
    }
    
    func loadcountries()
    {
    
        let str = "\(Urls.get_countries)"
        
        let urlwithPercentEscapes = str.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        if let url = NSURL(string:urlwithPercentEscapes!){
            
            
            
            if let data = try? Data(contentsOf:url as URL ){
                do{
                    let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    
                    
                    print("----------\(dict)")
                    
                    con_ary = dict["data"] as! NSArray
                    
                    
                }
                catch let error as NSError{
                    print("detail of json parsing error\n\(error)")
                }
            }
            
        }
        
        
    }
    
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        return 1

    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return con_ary.count

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        
        let dict = con_ary[row] as! NSDictionary
        
        let str_name = dict["country_name"] as! String
        
        return str_name
        
        
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        let dict = con_ary[row] as! NSDictionary
        
        let str_name = dict["country_name"] as! String
        
       // con_id = dict["id"] as! Int
        
        let con_str = "\(dict["id"]!)"
        
        con_id   =  (con_str as  NSString).integerValue
        
        coutry.text = str_name
    }
    func picker(_ textField : UITextField){
        
        // DatePicker
        self.pick = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.pick.backgroundColor = UIColor.white
        textField.inputView = self.pick
        
        pick.dataSource = self
        pick.delegate = self
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Register.doneClick1))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Register.cancelClick1))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
         }
    
    @objc func doneClick1() {
        
        coutry.resignFirstResponder()
        
        print(con_id)
        
    }
    
    @objc func cancelClick1() {
        coutry.resignFirstResponder()
    }
    
}
