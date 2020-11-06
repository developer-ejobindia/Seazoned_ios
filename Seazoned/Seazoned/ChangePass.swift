//
//  ChangePass.swift
//  Rapirun
//
//  Created by Apple on 07/03/18.
//  Copyright © 2018 Rapirun.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ChangePass: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var OLD_PASS: UITextField!
    
    @IBOutlet weak var new_pass: UITextField!
    
    @IBOutlet weak var con_pass: UITextField!
    
     @IBOutlet weak var red_msg: UIImageView!
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    @IBAction func done(_ sender: Any) {
        
        if OLD_PASS.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Old Password", vc: self)
            //print("enter email")
        }
        else if new_pass.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter New Password", vc: self)
            //print("enter email")
        }
        else if con_pass.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Confirm Password", vc: self)
            //print("enter email")
        }
        else if !(new_pass.text == con_pass.text)
        {
            AppManager().AlertUser("WARNING", message: "Password Not Matched", vc: self)
        }
        else
        {
            SVProgressHUD.show()
            loadupdate()
            
        }
        
    }
    func loadupdate() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.new_pw: new_pass.text!,
                                  
                                  
                                 Parameter.conf_pw: con_pass.text!
            ,
                                  Parameter.old_pw: OLD_PASS.text!
            
        ]
        //
        
        Alamofire.request(Urls.change_password, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
        
        SVProgressHUD.dismiss()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    func pushback()
    {
        self.navigationController?.popViewController(animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
