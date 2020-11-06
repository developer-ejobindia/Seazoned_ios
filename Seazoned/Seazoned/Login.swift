//
//  Login.swift
//  Seazoned
//
//  Created by Student on 01/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import CoreData
import GoogleSignIn
import GGLCore
import Alamofire
import SwiftyJSON
import SVProgressHUD
import Firebase


class Login: UIViewController,UITextFieldDelegate,GIDSignInDelegate, GIDSignInUIDelegate {
    
    
     @IBOutlet var lbl_sign: UILabel!
    @IBOutlet var logo_view: UIView!
    
    @IBOutlet var login_view: UIView!
    
    
    @IBOutlet var email: UITextField!
    
    
    @IBOutlet var pass: UITextField!
    
    @IBOutlet var signin_view: UIView!
    
    @IBOutlet var facebook_view: UIView!
    
    
    @IBOutlet var googleplus_view: UIView!
    
    @IBOutlet var eye_img: UIImageView!
    
    @IBOutlet var signin_lbl: UIButton!
    
    var fb_email:String!
    var fb_id:String!
    var fb_fname:String!
    var fb_lname:String!
    var fb_picurl:String!
    
    var secure_flag = 0
     @IBAction func continue_as_guest(_ sender: Any) {
        let DB_BASE = FIRDatabase.database().reference()
        
        let value1 = ["check_flag": "0"]
        
        DB_BASE.child("check_user_login").setValue(value1)
        
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
        self.navigationController?.pushViewController(obj, animated: true)
    }
    @IBAction func eye(_ sender: Any) {
        if secure_flag==0 {
            pass.isSecureTextEntry=false
            eye_img.image=UIImage (named: "view.png")
            secure_flag=1
        }
            
        else
        {
            pass.isSecureTextEntry=true
            eye_img.image=UIImage (named: "hide.png")
            secure_flag=0
        }
    }
    
    @IBAction func signin(_ sender: Any) {
        
        if email.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Email", vc: self)
            //print("enter email")
        }
        else if !AppManager().isValidEmail(testStr: email.text!) {
            
            AppManager().AlertUser("ERROR", message: "Please Enter Valid Email Id", vc: self)
            
        }
        else if pass.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Password", vc: self)
            //print("enter email")
        }
        else
        {
            
            
            print("Log")
            
            //            SVProgressHUD.show()
            //
            //
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            //                self.logindata()
            //            }
            
            
            
            login_data()
            
            
            
            
            
            
            
            //    let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
            //  self.navigationController?.pushViewController(obj, animated: true)
            
            
        }
        
        
        
    }
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ChatViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        //  addViewOnTop()
        view.endEditing(true)
        
       
    }
    
    func login_data()  {
        
        let strEmail = self.email.text
        
        let strPassword = self.pass.text
        
        //     if !(strEmail?.isEmpty)! && isEmailValid(strEmail!) && !(strPassword?.isEmpty)! {
        
        let parameters: Parameters = [Parameter.username: strEmail!,
                                      Parameter.password: strPassword!,
                                       Parameter.profile_id:"2"]
        
        
        Service.request(url: Webservice.login, method: .post, parameters: parameters, displayLoader: true, loaderMessage: "Logging In...", resposneType: .login) { (login) in
            
            let response = login as! Login_data
            
            
            
            print(response)
            
          // let data1 = response.as! NSDictionary
           //let u_id = data1.value(forKey: "user_id")
            UserDefaults.standard.set(response.token, forKey: "token")
            
            print("token------\(response.token)")
            
            UserDefaults.standard.set(response.data1?.user_id, forKey: "u_id")

            
            
            
            
            //                let alert = UIAlertController(title: nil, message: response.msg, preferredStyle: .alert)
            //                alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: nil))
            //                self.present(alert, animated: true, completion: nil)
            
            
            if response.success == 1 {
                
                //UserDefaults.standard.set(response.data1?.user_id, forKey: "id")
                
                UserDefaults.standard.set("normal", forKey: "logintype")
                UserDefaults.standard.set("1", forKey: "session")
                
                
                
                
                
                
                let DB_BASE = FIRDatabase.database().reference()
                
                let value1 = ["check_flag": "1"]
                
                DB_BASE.child("check_user_login").setValue(value1)
                
                
                
                
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
                self.navigationController?.pushViewController(obj, animated: true)
                
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
    
    
    func checkfbgmail()
    {
        
        
        let DB_BASE = FIRDatabase.database().reference()
        
        
       // let u_id  = UserDefaults.standard.value(forKey: "user_id")
        
        
        
        
        DB_BASE.child("notification_125470").observe(FIRDataEventType.value, with: { (snapshot) in
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
                    
                    // self.red_msg.isHidden = false
                    print("ok")
                    
                    self.googleplus_view.isHidden = false
                    
                    self.facebook_view.isHidden = false
                    self.lbl_sign.isHidden = false
                    
                }
                    
                    
                else
                    
                {
                    // self.red_msg.isHidden = true
                    self.googleplus_view.isHidden = true
                    self.facebook_view.isHidden = true
                    self.lbl_sign.isHidden = true
                    
                    
                    
                    print("holo nah")
                    
                    
                }
                
                
                
                
                
            }
            
        })
        
    }
    
    
    
    
    @IBAction func fb(_ sender: Any) {
        let fbLoginManger : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManger.loginBehavior = FBSDKLoginBehavior.web
        
        fbLoginManger.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error == nil {
                
                
                
                let fbLoginResult : FBSDKLoginManagerLoginResult = result!
                
                
                
                if (result?.isCancelled)! {
                    
                    return
                    
                }
                
                if fbLoginResult.grantedPermissions.contains("email"){
                    
                    self.getFBUserDate()
                    
                }
                
            }
            
        }
    }
    
    func getFBUserDate() {
        
        
        
        print(" facebook Token id is:  \(FBSDKAccessToken.current().tokenString)")
        
        
        
        self.view.isUserInteractionEnabled = false
        
        
        
        if FBSDKAccessToken.current() != nil {
            
            
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large),email"]).start(completionHandler: { (connection, result, error) in
                
                
                
                if error == nil {
                    
                    print(result!)
                    
                    
                    
                    
                    
                    let returnResult : [String: Any] = result as! [String : Any]
                    
                    print(returnResult["email"] as! String)
                    
                    
                    
                    User.email          =   returnResult["email"] as! String
                    
                    User.socialToken    =   FBSDKAccessToken.current().tokenString
                    
                    print("Facebook authentication Tocken \(FBSDKAccessToken.current().tokenString)")
                    
                    User.regThrough     =   RegThrough.facebook
                    
                    
                    self.fb_email = returnResult["email"] as! String
                    
                    self.fb_fname = returnResult["first_name"] as! String
                    
                    self.fb_lname = returnResult["last_name"] as! String
                    
                    self.fb_id = returnResult["id"] as! String
                    
                    let dic1 = returnResult["picture"] as! NSDictionary
                    
                    let dic2 = dic1["data"] as! NSDictionary
                    
                    self.fb_picurl = dic2["url"] as! String
                    
                    
//                    SVProgressHUD.show(withStatus: "Logging In")
                      self.fblogin_data()
                    
                   
                }
                
            })
            
        }
        
    }
    
    func fblogin_data()  {
        
//        let strEmail = self.email.text
//
//        let strPassword = self.pass.text
        
        //     if !(strEmail?.isEmpty)! && isEmailValid(strEmail!) && !(strPassword?.isEmpty)! {
        
        let parameters: Parameters = [Parameter.email: self.fb_email!,
                                      Parameter.first_name: self.fb_fname!,
                                      Parameter.last_name: self.fb_lname!,
                                      Parameter.profile_image: self.fb_picurl!,
                                      Parameter.dob: "",
            Parameter.facebook_id: self.fb_id!]
        
        
        Service.request(url: Webservice.user_fb_login, method: .post, parameters: parameters, displayLoader: true, loaderMessage: "Logging In...", resposneType: .login) { (login) in
            
            let response = login as! Login_data
            
            
            UserDefaults.standard.set(response.token, forKey: "token")
            
            
            
            //                let alert = UIAlertController(title: nil, message: response.msg, preferredStyle: .alert)
            //                alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: nil))
            //                self.present(alert, animated: true, completion: nil)
            
            
            if response.success == 1 {
                
                //UserDefaults.standard.set(response.data1?.user_id, forKey: "id")
                
                UserDefaults.standard.set("fb", forKey: "logintype")
                UserDefaults.standard.set("1", forKey: "session")
                
                let DB_BASE = FIRDatabase.database().reference()
                
                let value1 = ["check_flag": "1"]
                
                DB_BASE.child("check_user_login").setValue(value1)
                
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
                self.navigationController?.pushViewController(obj, animated: true)
                
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
        
        //SVProgressHUD.dismiss()
        
        
    }
    
    @IBAction func googleplus(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        
        
        if error == nil {
            
            
            
            // ***
            
            User.firstName      =   user.profile.givenName
            
            User.lastName       =   user.profile.familyName
            
            User.email          =   user.profile.email
            
            User.socialId       =   user.userID
            
            User.password    =   user.authentication.idToken
            
            print(" access token is : \(user.authentication.idToken)")
            
            User.regThrough     = RegThrough.gmail
            
            // var idToken  = GIDGoogleUser.getauto
            
            print("Acess token is:  \(user.authentication.accessToken)")
            
            print(" User Id:  \(user.userID)")
            
            print("--------------------------------------\(User.firstName)--\(User.lastName)--\(User.email)")
            
            // performLogin(email: User.email, password: User.password, regThrough: User.regThrough)
            
            //let str = User.firstName + " " + User.lastName
            
            
            //SVProgressHUD.show()
            
            //googlelogin(user_id: user.userID!, name: str, email: User.email)
            googlelogin_data(user_id: user.userID, f_name: User.firstName, l_name: User.lastName, email_id: User.email)
            
            
            
            
        } else{
            
            print(error.localizedDescription)
            
        }
        
    }
    func googlelogin_data(user_id:String,f_name:String,l_name:String,email_id:String)  {
        
//        let strEmail = self.email.text
//
//        let strPassword = self.pass.text
        
        //     if !(strEmail?.isEmpty)! && isEmailValid(strEmail!) && !(strPassword?.isEmpty)! {
        
        let parameters: Parameters = [Parameter.first_name: f_name,
                                      Parameter.last_name: l_name,
                                      Parameter.email: email_id,
                                      Parameter.google_id: user_id]
        
        
        Service.request(url: Webservice.user_google_login, method: .post, parameters: parameters, displayLoader: true, loaderMessage: "Logging In...", resposneType: .login) { (login) in
            
            let response = login as! Login_data
            
            
            UserDefaults.standard.set(response.token, forKey: "token")
            
            
            
            //                let alert = UIAlertController(title: nil, message: response.msg, preferredStyle: .alert)
            //                alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: nil))
            //                self.present(alert, animated: true, completion: nil)
            
            
            if response.success == 1 {
                
                //UserDefaults.standard.set(response.data1?.user_id, forKey: "id")
                
                UserDefaults.standard.set("google", forKey: "logintype")
                UserDefaults.standard.set("1", forKey: "session")
                
                let DB_BASE = FIRDatabase.database().reference()
                
                let value1 = ["check_flag": "1"]
                
                DB_BASE.child("check_user_login").setValue(value1)
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
                self.navigationController?.pushViewController(obj, animated: true)
                
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
    @IBAction func reg(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
      // email.text = "manasdas.mlindia@gmail.com"
     //  pass.text = "123"
        
    email.text = ""
pass.text = ""
        
//        let str = UserDefaults.standard.value(forKey: "tanay")
//        print("hola baccha\(str!)")
        
        //AppManager().AlertUser("hola baccha\(str!)", message: "", vc: self)
 
       
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        self.googleplus_view.isHidden = true
        self.facebook_view.isHidden = true
        self.lbl_sign.isHidden = true
        checkfbgmail()
        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        
        des_obj.button_round(my_view: signin_view)
        des_obj.button_round(my_view: facebook_view)
        des_obj.button_round(my_view: googleplus_view)
        
        des_obj.round_corner(my_view: logo_view,value: 12)
        des_obj.round_corner(my_view: login_view,value: 6)
        
        des_obj.red_gradient(my_view: signin_view)
        
        //        signin_lbl.frame=CGRect (x: signin_lbl.frame.origin.x, y: signin_lbl.frame.origin.y, width: signin_lbl.frame.size.width, height: signin_lbl.frame.size.height)
        //
        //        signin_view.addSubview(signin_lbl)
        
        
        
        des_obj.dropShadow(myview: logo_view)
        
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
      //  animateTextField1(textview: textField, up: true)
        
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
       // animateTextField1(textview: textField, up: false)
        
        
    }
    
    
    func animateTextField1(textview:UITextField,up:Bool)
    {
        let movementDistance = -100 // tweak as needed
        let movementDuration = 0.3 // tweak as needed
        
        let movement = (up ? movementDistance : -movementDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: CGFloat(movement))
        UIView.commitAnimations()
        
        
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
