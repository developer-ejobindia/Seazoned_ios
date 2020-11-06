//
//  ForgotPassword.swift
//  Seazoned
//
//  Created by Apple on 22/06/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ForgotPassword: UIViewController,UITextFieldDelegate {

    
    @IBOutlet var logo_view: UIView!
    @IBOutlet var email: UITextField!
    @IBOutlet var signin_view: UIView!
    @IBOutlet var login_view: UIView!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet var cancel_view: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        
        des_obj.button_round(my_view: signin_view)
        des_obj.round_corner(my_view: logo_view,value: 12)
        des_obj.red_gradient(my_view: signin_view)
        des_obj.dropShadow(myview: logo_view)
        
        des_obj.button_round(my_view: cancel_view)
        
        des_obj.round_corner(my_view: login_view,value: 6)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func submit(_:Any)
    {
        if email.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Email", vc: self)
            //print("enter email")
        }
        else if !AppManager().isValidEmail(testStr: email.text!) {
            
            AppManager().AlertUser("ERROR", message: "Please Enter Valid Email Id", vc: self)
            
        }
        else
        {
            SVProgressHUD.show(withStatus: "Verifying...")
            loaddata()
        }
        
    }
    
    @IBAction func back(_:Any)
    {
        //self.navigationController?.popViewController(animated: true)
        for controller in self.navigationController!.viewControllers as Array {
            
            if controller.isKind(of: Login.self) {
                
                self.navigationController!.popToViewController(controller, animated: true)
                
                break
                
            }
            
        }
    }

    func loaddata() {
        
        //let token = UserDefaults.standard.object(forKey: "token1")
        
        // print(token)
        
//        let headers: HTTPHeaders = [
//            "token": token as! String,
//
//            ]
        
        //"paypal_account_email"
        let params: Parameters = ["email":email.text!,"profile_id":"2"]
        
        
        
        
        
        print("param ------ \(params)")
        
        
        Alamofire.request(Webservice.emailCheck, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            
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
                        
                        
                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "otpverfy") as! OtpVerify
                        
                        obj.str_email=self.email.text!
                        
                        self.navigationController?.pushViewController(obj, animated: false)
                        
                        SVProgressHUD.dismiss()
                        
                        
                    }
                    else
                    {
                        AppManager().AlertUser("Message", message: msg, vc: self)
//                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "otpverfy") as! OtpVerify
//
//                        obj.str_email=self.email.text!
//
//                        self.navigationController?.pushViewController(obj, animated: false)
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
