//
//  AddressBook.swift
//  Seazoned
//
//  Created by Apple on 17/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Kingfisher
import Firebase
class AddressBook: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nodata: UILabel!
    
     @IBOutlet weak var red_msg: UIImageView!
    
    @IBOutlet weak var tbl: UITableView!
    
    var ary : NSArray!
    var str_img:String!
    var str_name:String!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addcll") as! BookCell
        let dict = ary[indexPath.row] as! NSDictionary
        cell.ser_name.text = "\(dict["name"]!)"
        cell.book_id.text = "\(dict["address"]!)"
        cell.named.text = "Phone : \(AppManager().nullToNil(value: dict["contact_number"]! as AnyObject))"
        cell.payment.text = "E-Mail : \(dict["email_address"]!)"
        let des_obj = Design()
        des_obj.round_corner(my_view: cell.edit_view, value: 6)
        cell.btn_edit.tag = indexPath.row
        cell.btn_edit.addTarget(self, action: #selector(self.edit(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    @IBAction func edit(sender:UIButton)
    {
        let dict = ary[sender.tag] as! NSDictionary
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "addedit") as! AddAddress
        
        obj.edit_flag="1"
        obj.all_data=dict
        
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    
    @IBAction func add(_ sender: Any) {
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "addedit") as! AddAddress
    
        obj.edit_flag="0"
        obj.all_data=[:]
        
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imgvw.clipsToBounds=true
        imgvw.layer.borderWidth=1
        imgvw.layer.borderColor = UIColor.lightGray.cgColor
        imgvw.layer.cornerRadius=imgvw.frame.size.width/2
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        name.text = str_name
        
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
        
        tbl.dataSource=nil
        tbl.isHidden=true
        nodata.isHidden=true
        
        SVProgressHUD.show()
        loaddata()
        
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

    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        Alamofire.request(Webservice.address_book_list,method: .get, headers: headers)
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
                        self.ary = dict1["addresses"] as! NSArray
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
