//
//  ViewController.swift
//  Addnewcard
//
//  Created by Surjava Ghosh on 09/03/18.
//  Copyright © 2018 Surjava Ghosh. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class Addnewcard : UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
     @IBOutlet weak var red_msg: UIImageView!
    var value: NSDictionary = [:]
    
    var flag : String = ""
    
    @IBOutlet weak var lbl_header: UILabel!
    
    @IBAction func btn(_ sender: Any) {
    }
    
    var ary2 = [String]()
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        
        return 1
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pick {
            return ary.count
            
        }
        else if pickerView == pick2
        {
            return ary2.count
            
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
            date.text = ary[row]
            //x.month = Int(ary[row])!
        }
        else if pickerView == pick2
        {
            year.text = ary2[row]
            //x.year = Int(ary2[row])!
        }
        
    }
    
    @IBAction func checking(_ sender: Any) {
        
    }
    
    @IBAction func add(_ sender: Any) {
        
        if (cardno.text?.count)!<15 || (cardno.text?.count)!>16
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Card Number", vc: self)
            //print("enter email")
        }
        else if date.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Expiry Month", vc: self)
            //print("enter email")
        }
        else if year.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Expiry Year", vc: self)
            //print("enter email")
        }
        else if cardholdername.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Cardholder's Name", vc: self)
            //print("enter email")
        }
            
        else
        {
            if self.flag == "1"
            {
                SVProgressHUD.show(withStatus: "Updating Card...")
                
                
                loadedit()
            }
                
            else
            {

            SVProgressHUD.show(withStatus: "Adding Card...")
            
            
            loadadd()
            }
            
        }
        
    }
    
    @IBOutlet var main: UIView!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var cardno: UITextField!
    @IBOutlet weak var cardholdername: UITextField!
    @IBOutlet weak var cardlabel: UITextField!
    
    var pick : UIPickerView!
    var pick2 : UIPickerView!
    
    var ary = [String]()
    
    func picker1(_ textField : UITextField){
        
        
        
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Addnewcard.doneClick1))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Addnewcard.cancelClick1))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    
    @IBOutlet weak var add_btn: UIButton!
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        print(ary2)
        if pickerView == pick {
            return ary[row]
            
        }
            
        else if pickerView == pick2
        {
            return ary2[row]
            
        }
        else{
            return ""
        }
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Addnewcard.doneClick2))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Addnewcard.cancelClick2))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
        
        
        
    }
    
    @objc func doneClick1() {
        
        date.resignFirstResponder()
        
        
    }
    
    @objc func doneClick2() {
        year.resignFirstResponder()
        
    }
    
    
    @objc func cancelClick1() {
        
        date.resignFirstResponder()
        
    }
    
    @objc func cancelClick2() {
        
        year.resignFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cardno.delegate = self
        // cardholdername.delegate = self
        // cardlabel.delegate = self
        year.delegate = self
        // year.text = "YEAR"
        //date.text = "MM"
        date.delegate = self
//        for i in 1...12
//        {
//            ary.append(String(i))
//        }
        
        
        if self.flag == "1"
        {
            lbl_header.text = "Edit Credit/Debit Card"
            self.add_btn.titleLabel?.text = "Edit"
            
            self.cardno.text = "\(self.value["card_no"]!)"
            self.cardholdername.text = "\(self.value["name"]!)"
            
            self.year.text = "\(self.value["year"]!)"
            
            self.date.text = "\(self.value["month"]!)"

            

            
        }
        
        else
        {
            
            
        }
        
        
        ary  =  ["01","02","03","04","05","06","07","08","09","10","11","12"]
        
        for i in 2018...2022
        {
            ary2.append(String(i))
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        addDoneButtonOnKeyboard()
        
    }
    
    
    public func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        
        if textField == date
        {
            picker1(date)
            
            
        }
        else if textField == year
        {
            picker2(year)
            
            
        }
        else
        {
            
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    func loadedit() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
let cardid = "\(self.value["id"]!)"
        let params: Parameters = ["card_holder_name": cardholdername.text!,
                                  
                                  
                                  "card_no": cardno.text!
            ,
                                  Parameter.month: date.text!
            ,
                                  Parameter.year: year.text!,
            Parameter.card_id: cardid,

            //  Parameter.label: cardlabel.text!
            
            
        ]
        //
        
        Alamofire.request(Urls.edit_card, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
        
        
        
    }
    func loadadd() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        let params: Parameters = ["card_holder_name": cardholdername.text!,
                                  
                                  
                                 "card_no": cardno.text!
            ,
                                  Parameter.month: date.text!
            ,
                                  Parameter.year: year.text!
            
                                //  Parameter.label: cardlabel.text!
            
            
        ]
        //
        
        Alamofire.request(Urls.add_card, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
        
        
        
    }
    
    func pushback()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        textField.resignFirstResponder()
        
        
        
        return true
        
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        doneToolbar.tintColor = UIColor.black
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(Addnewcard.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        cardno.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        cardno.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}

