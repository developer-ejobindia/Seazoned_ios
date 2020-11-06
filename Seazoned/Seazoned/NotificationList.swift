//
//  NotificationList.swift
//  Seazoned
//
//  Created by Apple on 03/04/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Firebase
class NotificationList: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tbl: UITableView!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var nodata: UILabel!
    
    var ary:NSArray!
    override func viewWillAppear(_ animated: Bool) {
        
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tbl.dataSource=nil
        self.tbl.isHidden=true
        self.nodata.isHidden=true
        
        SVProgressHUD.show()
        loaddata()
        
    }
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        Alamofire.request(Webservice.notification_list_user,method: .get, headers: headers)
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
                        
                        let dict1 = dict["data"] as! NSDictionary
                        self.ary = dict1["notification_list_user"] as! NSArray
                        self.tbl.dataSource=self
                        self.tbl.isHidden=false
                        self.nodata.isHidden=true
                        self.tbl.reloadData()
                        self.tbl.tableFooterView=UIView()
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
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

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "bkcll") as! BookCell
        let cell = Bundle.main.loadNibNamed("Notcell", owner: self, options: nil)?.first as! Notcell
        
        
     //   cell.lbl_date.isHidden = true
        
        let dict = ary[indexPath.row] as! NSDictionary
        
        let DT_TIME = "\(dict["timestamp"]!)"
        
        if DT_TIME == "0000-00-00 00:00:00"
        {
              cell.lbl_date.text = " "
        }
        else
        {
        
        cell.lbl_date.text = AppManager().date_noti(str_date: DT_TIME)
        }
        
        let landscaper_name="\(dict["landscaper_name"]!)"
        
        let name="\(dict["name"]!)"
        
        let status="\(dict["status"]!)"
        
        var status1:String!
        
        if status=="Payment Pending" || status=="Payment Done" {
            
            status1=" completed your \(name)"
            
        }
        else if status=="Work In Progress"
        {
            
            status1=" accepted your request for \(name)"
            
        }
        else if status=="Service Request Sent"
        {
            
            status1=" received your request for \(name)"
            
        }
        else if status=="We are sorry to inform you that the provider is unable to fulfill your request at this time. Please search for another provider"
        {
            
            status1=" declined your request for \(name)"
            
        }
            
        else if status=="Service Request has been Accepted"
        {
            
            status1=" Service Request has been Accepted \(name)"
            
        }
            
            //Service Request has been Accepted
        else
        {
            status1="\(name)"

        }
        
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : UIColor.lightGray]
        
        let attributedString1 = NSMutableAttributedString(string:landscaper_name, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:status1, attributes:attrs2)
        
        attributedString1.append(attributedString2)
        cell.message.attributedText = attributedString1
        
        
 
        let str_img="\(dict["profile_image"]!)"
        if str_img==""
        {
            //let url = URL(string: str_img)
            cell.imgvw.image=UIImage (named: "user (1).png")
        }
        else
        {
            let url = URL(string: str_img)
            cell.imgvw.kf.setImage(with: url)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
  //  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let dict = ary[indexPath.row] as! NSDictionary
//
//        let status="\(dict["status"]!)"
//        //let status_name="\(dict["status_name"]!)"
//
//        if status=="3" {
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd3") as! BookingHistoryDetails3
//            obj.order_id="\(dict["order_id"]!)"
//
//            self.navigationController?.pushViewController(obj, animated: true)
//        }
//        else if status=="0" || status=="1" || status=="2"
//        {
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd1") as! BookingHistoryDetails1
//            obj.order_id="\(dict["order_id"]!)"
//            obj.status=status
//            self.navigationController?.pushViewController(obj, animated: true)
//        }
//        else
//        {
//            //            let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd3") as! BookingHistoryDetails3
//            //            obj.order_id="\(dict["order_id"]!)"
//            //
//            //            self.navigationController?.pushViewController(obj, animated: true)
//        }
        
      //  tableView.deselectRow(at: indexPath, animated: true)
        
        
        //        let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd1") as! BookingHistoryDetails1
        //        obj.order_id="\(dict["order_id"]!)"
        //        self.navigationController?.pushViewController(obj, animated: true)
    //}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = ary[indexPath.row] as! NSDictionary
        
        let status="\(dict["service_status"]!)"
        //let status_name="\(dict["status_name"]!)"
        
        if status=="3" {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd3") as! BookingHistoryDetails3
            obj.order_id="\(dict["order_id"]!)"
            
            self.navigationController?.pushViewController(obj, animated: true)
        }
        else if status=="0" || status=="1" || status=="2"
        {
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd1") as! BookingHistoryDetails1
//            obj.order_id="\(dict["order_id"]!)"
//            obj.status=status
//            self.navigationController?.pushViewController(obj, animated: true)
            
            
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd2") as! BookingHistoryDetails2
            obj.order_id="\(dict["order_id"]!)"
            //   obj.status=status
            
            self.navigationController?.pushViewController(obj, animated: true)
            
            
            
            
            
            
        }
        else
        {
            //            let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd3") as! BookingHistoryDetails3
            //            obj.order_id="\(dict["order_id"]!)"
            //
            //            self.navigationController?.pushViewController(obj, animated: true)
        }
        
        
        
        
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //        let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd1") as! BookingHistoryDetails1
        //        obj.order_id="\(dict["order_id"]!)"
        //        self.navigationController?.pushViewController(obj, animated: true)
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
