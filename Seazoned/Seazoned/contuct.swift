//
//  Chatlist.swift
//  Seazoned
//
//  Created by Apple on 02/05/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Firebase

class contuct: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet weak var lower_view: UIView!
    @IBOutlet var btn_msg: UIButton!
    @IBOutlet var btn_profile: UIButton!
//    @IBOutlet weak var red_msg: UIImageView!
    
    @IBOutlet weak var nodata: UILabel!
    
    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var bell_view: UIView!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var eMailid: UITextField!
    
    @IBOutlet weak var messege: UITextView!
    
    @IBOutlet weak var submit_view: UIView!
    func check_tab()
        
    {
        
        
        
        
        
        
        
        DB_BASE.child("check_user_login").observe(FIRDataEventType.value, with: { (snapshot) in
            //   print(snapshot)
            //if the reference have some values
            // let status = snapshot.childrenCount  + 1
            
            
            
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                
                let value = snapshot.value as? NSDictionary
                //  let value1 = value?.object(forKey: "date")
                
                let status = value?.value(forKey: "check_flag") as! String
                
                
                
                
                print("fggfgf\(value!)")
                
                
                
                
                
                
                
                
                if  status == "1"
                {
                    
                    self.btn_msg.isHidden = false
                    
                    self.btn_profile.isHidden = false
                    print("ok")
                    
                }
                    
                    
                else
                    
                {
                    self.btn_msg.isHidden = true
                    
                    self.btn_profile.isHidden = true
                    
                    print("holo nah")
                    
                    
                }
                
                
                
                
                
            }
            
        })
        
    }
    
    @IBAction func submit(_ sender: UIButton) {
        
        if (firstName.text?.isEmpty)!
        {
            AppManager().AlertUser("WARNING", message: "Please Enter First Name", vc: self)
            
        }
        else if (lastName.text?.isEmpty)!
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Last Name", vc: self)
        }
        
        else if eMailid.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Email", vc: self)
           
        }
        else if !AppManager().isValidEmail(testStr: eMailid.text!) {
            
            AppManager().AlertUser("ERROR", message: "Please Enter Valid Email", vc: self)
            
        }
        else if messege.text == ""
        {
            AppManager().AlertUser("WARNING", message: "Please Enter Message", vc: self)
            
        }
            
        else{
            
            
            SVProgressHUD.show()
             loaddata()
             SVProgressHUD.dismiss()
          //  Messages Send Successfully
            //AppManager().AlertUser("Message", message: "Message Send Successfully", vc: self)
//            let alert = UIAlertController(title: title,
//                                          message: "Messages Send Successfully",
//                                          preferredStyle: UIAlertControllerStyle.alert)
//
//            let cancelAction = UIAlertAction(title: "OK",
//                                             style: .cancel, handler:
//           a in(
//
//             let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
//            self.navigationController?.pushViewController(obj, animated: true))
//
//            alert.addAction(cancelAction)
//            //vc will be the view controller on which you will present your alert as you cannot use self because this method is static.
//            vc.present(alert, animated: true, completion: nil)
            
           
            
        }
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        
        firstName.delegate = self
        lastName.delegate = self
        eMailid.delegate = self
        messege.delegate = self
        check_tab()
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        des_obj.round_corner(my_view: lower_view,value: 6)
        des_obj.view_round(my_view: bell_view)
        des_obj.round_corner(my_view: messege, value: 6)
        des_obj.add_border(my_view: messege, width: 1)
        des_obj.add_borderwithcolor(my_view: messege, width: 1, color: .black)
        
    }

    var ary : NSArray!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "bkcll") as! BookCell
        let cell = Bundle.main.loadNibNamed("ChatCell", owner: self, options: nil)?.first as! ChatCell
        let dict = ary[indexPath.row] as! NSDictionary
        //cell.named.text="\(dict["lanscaper_name"]!)"
        cell.ser_name.text="\(dict["service_name"]!)"
        cell.book_id.text="\(dict["customer_first_name"]!) \(dict["customer_last_name"]!)"
//        let str_img="\(dict["profile_image"]!)"
//        if str_img==""
//        {
//            //let url = URL(string: str_img)
//            cell.imgvw.image=UIImage (named: "user (1).png")
//        }
//        else
//        {
//            let url = URL(string: str_img)
//            cell.imgvw.kf.setImage(with: url)
//        }
        //calculate(dict: dict, cell: cell)
        
        let str_serid = "\(dict["service_id"]!)"
        imageadding(ser_id: str_serid, cellimg: cell.imgvw)
        
        let des_obj = Design()
        des_obj.red_gradient(my_view: cell.work_view)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 87
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let dict = ary[indexPath.row] as! NSDictionary
//
//        let order_no="\(dict["order_no"]!)"
//        let service_name="\(dict["service_name"]!)"
//        let reciver_id="\(dict["customer_id"]!)"
//        let sender_id="\(dict["landscaper_id"]!)"
//
//        let obj = self.storyboard?.instantiateViewController(withIdentifier: "cvc") as! ChatViewController
//        obj.ordr_id=order_no
//        obj.str_sername=service_name
//        obj.sender_id=sender_id
//        obj.reciver_id=reciver_id
//        obj.firebase_token_IOS="\(dict["iphone_firebase_token"]!)"
//        obj.firebase_token_AND="\(dict["android_firebase_token"]!)"
//
//        obj.str_img="\(dict["user_profile_image"]!)"
//        obj.name1="\(dict["customer_first_name"]!) \(dict["customer_last_name"]!)"
//        self.navigationController?.pushViewController(obj, animated: true)
//
//        tableView.deselectRow(at: indexPath, animated: true)
//
//    }
//
    func imageadding(ser_id:String,cellimg:UIImageView)
    {
        switch ser_id {
        case "1":
            
            cellimg.image = UIImage (named: "person-mowing-the-grass.png")
            
            break
            
        case "2":
            
            cellimg.image = UIImage (named: "herbal-spa-treatment-leaves.png")
            
            break
            
        case "3":
            
            cellimg.image = UIImage (named: "seeds.png")
            
            break
            
        case "4":
            
            cellimg.image = UIImage (named: "aeration.png")
            
            break
            
        case "5":
            
            cellimg.image = UIImage (named: "sprinkler.png")
            
            break
            
        case "6":
            
            cellimg.image = UIImage (named: "swimming-pool-ladder.png")
            
            break
            
        case "7":
            
            cellimg.image = UIImage (named: "worker-with-shovel.png")
            
            break
            
        default:
            break
        }
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    
    @IBOutlet weak var red_msg: UIImageView!

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
        
        
//        let DB_BASE = FIRDatabase.database().reference()
//
//
//        let u_id  = UserDefaults.standard.value(forKey: "u_id")
//
//        DB_BASE.child("notification_\(u_id!)").observe(FIRDataEventType.value, with: { (snapshot) in
//            //   print(snapshot)
//            //if the reference have some values
//            // let status = snapshot.childrenCount  + 1
//
//
//
//            if snapshot.childrenCount > 0 {
//
//                //clearing the list
//
//                let value = snapshot.value as? NSDictionary
//                //  let value1 = value?.object(forKey: "date")
//
//                let status = value?.value(forKey: "flag") as! String
//
//
//
//
//                print("fggfgf\(value!)")
//
//
//
//
//
//
//
//
//                if  status == "1"
//                {
//
//                    self.red_msg.isHidden = false
//                    print("ok")
//
//                }
//
//
//                else
//
//                {
//                    self.red_msg.isHidden = true
//                    print("holo nah")
//
//
//                }
//
//
//
//
//
//            }
//
//        })
        
       // tbl.dataSource=nil
       // tbl.isHidden=true
        //nodata.isHidden=true
        
       // SVProgressHUD.show()
      //  loaddata()
        
    }
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        let params : Parameters = [
        "name" : "\(firstName.text!) \(lastName.text!)",
        "email" : "\( eMailid.text!)",
        "desc" : "\( messege.text!)"]
        
        
        print(params)
        
        Alamofire.request(Urls.con_us ,method: .post, parameters: params, headers: headers)
            .responseJSON { response in
                //debugPrint(response.data)
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("----------\(dict)")
                    
                    let succ = dict["success"] as! Int
                    
                    let msg = dict["msg"] as! String
                    
                    self.ary = []
                    
                    if succ==1
                    {
                        
                        let dict1 = dict["data"] as! NSDictionary
                      //  self.ary = dict1["message"] as! NSArray
                        
                        //                        for i in 0...ary1.count-1
                        //                        {
                        //                            let dict = ary1[i] as! NSDictionary
                        //                            if "\(dict["status"]!)" == "-1"
                        //                            {
                        //
                        //                            }
                        //                            else
                        //                            {
                        //                                self.ary.add(ary1[i])
                        //                            }
                        //                        }
                        //
                        //                        if self.ary.count==0
                        //                        {
                        //                            self.ary = []
                        //                            self.tbl.dataSource=nil
                        //                            self.tbl.isHidden=true
                        //                            self.nodata.isHidden=false
                        //                            self.nodata.text=msg
                        //                        }
                        //                        else
                        //                        {
                        //                            self.tbl.dataSource=self
                        //                            self.tbl.isHidden=false
                        //                            self.nodata.isHidden=true
                        //                            self.tbl.reloadData()
                        //                            self.tbl.tableFooterView=UIView()
                        //                        }
                        //
                        ////                        self.tbl.dataSource=self
                        ////                        self.tbl.isHidden=false
                        ////                        self.nodata.isHidden=true
                        ////                        self.tbl.reloadData()
                        ////                        self.tbl.tableFooterView=UIView()
                        
                        
                      //  self.tbl.dataSource=self
                      //  self.tbl.isHidden=false
                      //  self.nodata.isHidden=true
                       // self.tbl.reloadData()
                        //self.tbl.tableFooterView=UIView()
                        
                        SVProgressHUD.dismiss()
                        
                        
                        let alert = UIAlertController(title: "",message: msg,preferredStyle:.alert)
                        
                        alert.addAction(UIAlertAction (title:"OK", style: .cancel, handler: {
                            
                            alert in self.pushback()
                            
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else
                    {
                        self.ary = []
                        self.tbl.dataSource=nil
                        self.tbl.isHidden=true
                        self.nodata.isHidden=false
                        self.nodata.text=msg
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
    
    
    func animateTextField1(textview:UITextView,up:Bool)
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
    
    
     public func textViewDidBeginEditing(_ textView: UITextView)
    {
        
        self.animateTextField1(textview: messege, up: true)
    }
    
    
  public func textViewDidEndEditing(_ textView: UITextView)
  {
    self.animateTextField1(textview: messege, up: false)

    
    }
    func pushback()
    {
        //self.navigationController?.popViewController(animated: true)
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
        self.navigationController?.pushViewController(obj, animated: true)
        
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
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "clst") as! Chatlist
//            self.navigationController?.pushViewController(obj, animated: false)
            
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
