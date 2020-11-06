//
//  ViewProfile.swift
//  Seazoned
//
//  Created by Student on 01/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Firebase
class ViewProfile: UIViewController {

    
    @IBOutlet var view_img: UIView!
    
    @IBOutlet var imgvw: UIImageView!
    
    
    @IBOutlet var name: UILabel!
    
    
    @IBOutlet var dob: UILabel!
    
    @IBOutlet var phn: UILabel!
    
    @IBOutlet var mail: UILabel!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet var view_edit: UIView!
    
    
    @IBOutlet weak var scroll: UIScrollView!
    
    
    @IBOutlet var edit_prof: UIButton!
    
    var alldata:NSDictionary!
    
    
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func change(_ sender: Any) {
        
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "up") as! UpdatePhoto
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
       // self.navigationController?.pushViewController(popOverVC, animated: true)
        

        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let des_obj = Design()
        
        
        des_obj.view_round(my_view: view_img)
        
        des_obj.button_round(my_view: view_edit)
        
        des_obj.green_gradient(my_view: view_edit)
        
        scroll.contentSize = CGSize (width: 0, height: view_edit.frame.origin.y+view_edit.frame.size.height+50)
        
        view_img.layer.borderWidth=2
        view_img.layer.borderColor=UIColor (red: 205.0/255.0, green: 205.0/255.0, blue: 205.0/255.0, alpha: 1.0).cgColor
        
//        scroll.contentSize=CGSize (width: 0, height: view_edit.frame.origin.y+view_edit.frame.size.height+30)
        
        name.text = (self.alldata["first_name"] as? String)! + " " + (self.alldata["last_name"] as? String)!
        
        mail.text = self.alldata["email"] as? String
        
        phn.text = AppManager().nullToNil(value: self.alldata["phone_number"] as? String as AnyObject)
        
        //phn.text = self.alldata["phone_number"] as? String
        
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
        
        
        let str_dob = AppManager().nullToNil(value: self.alldata["date_of_birth"] as? String as AnyObject)
        
        if str_dob=="" {
            
            dob.text = ""
            
        }
        else
        {
            
           dob.text = Time().dateformat(str_date: str_dob)
            
        }
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false

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

    @IBAction func edit(_ sender: Any) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "ep") as! EditProfile
        
        obj.alldata=self.alldata
    
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    //MARK: Tabbar
    
    @IBAction func tabbar(_ sender: UIButton) {
        
        //Help
        if sender.tag==0 {  let obj = self.storyboard?.instantiateViewController(withIdentifier: "faq") as! faq
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
