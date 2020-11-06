//
//  Profile.swift
//  Seazoned
//
//  Created by Student on 01/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Kingfisher
import FBSDKCoreKit
import FBSDKLoginKit
import CoreData
import GoogleSignIn
import GGLCore
import Firebase
class Profile: UIViewController {

    @IBOutlet var bell_view: UIView!
    
    @IBOutlet var imgvw: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var ad_view: UIView!
    
    @IBOutlet var history_view: UIView!
    
    @IBOutlet var fav_view: UIView!
    
    @IBOutlet var pay_view: UIView!
    
    @IBOutlet var logout_view: UIView!
    
    @IBOutlet var lower_view: UIView!
     @IBOutlet weak var red_msg: UIImageView!
    var alldata:NSDictionary!
    
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
        ]
        
        Alamofire.request(Webservice.userinfo,method: .get, headers: headers)
            .responseJSON { response in
                //debugPrint(response.data)
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("----------\(dict)")
                    
                    let succ = dict["success"] as! Int
                    
                    if succ==1 
                    {
                        
                        self.alldata = dict["data"] as! NSDictionary
                       // let str_user_id = self.alldata["user_id"] as! Int
                        
                        let str_user_id1 = "\(self.alldata["user_id"]!)"
                        
                         let str_user_id    =  (str_user_id1 as  NSString).integerValue
                        
                        
                           let str_user_id_1 = String(str_user_id)
                        
                        UserDefaults.standard.set(
                            str_user_id_1, forKey: "id")
                        self.name.text = (self.alldata["first_name"] as? String)! + " " + (self.alldata["last_name"] as? String)!
                        
                        let str_img = self.alldata["profile_image"] as! String
                        
                        if str_img==""
                        {
                            //let url = URL(string: str_img)
                            self.imgvw.image=UIImage (named: "user (1).png")
                        }
                        else
                        {
                            let url = URL(string: str_img)
                            self.imgvw.kf.setImage(with: url)
                        }
                        SVProgressHUD.dismiss()
                    
                    }
                    else
                    {
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
    
    
    
    
    @IBAction func menu(_ sender: Any) {
    }
    
    @IBAction func notification(_ sender: Any) {
    }
    
    
    @IBAction func view_profile(_ sender: Any) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "vp") as! ViewProfile
        
        obj.alldata=self.alldata
        
        self.navigationController?.pushViewController(obj, animated: true)
        
        
    }
    
    
    @IBAction func address(_ sender: Any) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "addbk") as! AddressBook
        
        obj.str_img=self.alldata["profile_image"] as! String
        
        obj.str_name=name.text
        
        self.navigationController?.pushViewController(obj, animated: true)

    }
    
    @IBAction func history(_ sender: Any) {
    }
    
    @IBAction func fav(_ sender: Any) {
    }
    
    @IBAction func pay(_ sender: Any) {
    }
    
    @IBAction func logout(_ sender: Any) {
        
        let str_logintype = UserDefaults.standard.value(forKey: "logintype") as! String
        
        if str_logintype=="fb" {
            
            let loginM = FBSDKLoginManager()
            
            loginM.logOut()
        }
        else if str_logintype=="google" {
            
            GIDSignIn.sharedInstance().signOut()
            
        }
        else
        {
            
        }
        
        UserDefaults.standard.set("0", forKey: "session")
        //self.navigationController?.popToRootViewController(animated: true)
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
        self.navigationController?.pushViewController(obj, animated: false)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 self.lbl_count.isHidden = true
        // Do any additional setup after loading the view.
   // self.noti_count()
        let des_obj = Design()
        des_obj.round_corner(my_view: lower_view,value: 6)
        
        des_obj.view_round(my_view: ad_view)
        des_obj.view_round(my_view: history_view)
        des_obj.view_round(my_view: fav_view)
        des_obj.view_round(my_view: pay_view)
        des_obj.view_round(my_view: logout_view)
        
        des_obj.view_round(my_view: bell_view)
        
        imgvw.layer.cornerRadius=imgvw.frame.size.width/2
        
        SVProgressHUD.show()
        loaddata()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        noti_count()
        self.navigationController?.isNavigationBarHidden = true
//        SVProgressHUD.show()
//        loaddata()
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
    
    @IBOutlet weak var lbl_count: UILabel!
    func noti_count()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        
        let token = UserDefaults.standard.object(forKey: "token")
        //  http://192.168.1.2:8080/dev/ondemandcrapp/public/api/subscribe?
        // firebase_token=khbistr98w-0ghd0tjklhxvgc.....,
        //  &device_type=android
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
    
            
         //   print("-----------------------------------\(token1)")
            //   let params: Parameters  [Parameter.device_token: token1!
            //   ]
            
            
            Alamofire.request(Webservice.notification, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                
                .responseJSON { response in
                    //debugPrint(response.data)
                    
                    switch(response.result){
                    case .success(_):
                        let result = response.result
                        
                        let dict = result.value as! NSDictionary
                        
                        print("-----kkkkkkkk-----\(dict)")
                        
                        let succ = dict["success"] as! Int
                        
                        let msg = dict["msg"] as! String
                        
                        if succ==1
                        {
                            let notification_count1 = "\(dict["notification_count"]!)"
                            
                           // self.lbl_count.text = notification_count1
                            self.bell_view.isHidden = false
                            
                            
                            UserDefaults.standard.set("1", forKey: "noti")
                            SVProgressHUD.dismiss()
                            
                        }
                        else
                        {
                            self.bell_view.isHidden = true
                            
                            
                            
                          
                            SVProgressHUD.dismiss()
                            
                        }
                      
                        self.lbl_count.isHidden = true
                        break
                        
                    case .failure(_):
                        print("Network Error")
                        SVProgressHUD.dismiss()
                        break
                        
                    }
            }
            
       
            
//        else
//        {
//            // SVProgressHUD.dismiss()
//        }
//
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
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
//            self.navigationController?.pushViewController(obj, animated: false)
        }
        
        
        
        
    }
    

}
