//
//  Favorites.swift
//  Seazoned
//
//  Created by Apple on 23/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Firebase
class Favorites: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var col: UICollectionView!
    
    @IBOutlet weak var nodata: UILabel!
     @IBOutlet weak var red_msg: UIImageView!
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
        
        col.dataSource=nil
        nodata.isHidden=true
        
        SVProgressHUD.show()
        loaddata()
        
    }
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        //address=kolkata&city=kolkata&state=wb&country=india&postal_code=700102&service_id=7
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
//        let params: Parameters = [Parameter.address: auto_txt.text!,
//                                  Parameter.city: str_city!,
//                                  Parameter.state: str_state!,
//                                  Parameter.country: str_country!,
//                                  Parameter.postal_code: str_zip!,
//                                  Parameter.service_id: ser_id!
//        ]
        
        
        Alamofire.request(Webservice.view_favorite_list, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        //                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
                        //                        self.navigationController?.pushViewController(obj, animated: true)
                        
                        self.ary = dict["data"] as! NSArray
                        
                        self.col.dataSource=self
                        
                        self.col.isHidden = false
                        
                        self.col.reloadData()
                        
                        self.nodata.isHidden=true
                        
                        
                        
                    }
                    else
                    {
                        //AppManager().AlertUser("Message", message: msg, vc: self)
                        
                        self.nodata.isHidden=false
                        self.nodata.text=msg
                        
                        self.col.isHidden = true
                        
                        
                        
                    }
                    
                    
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    break
                    
                }
        }
        
        SVProgressHUD.dismiss()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ary.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tabcell = collectionView.dequeueReusableCell(withReuseIdentifier: "c2", for: indexPath) as! cell
        
        let dict = ary[indexPath.row] as! NSDictionary
        
        tabcell.name.text = dict["name"] as? String
        tabcell.add.text = dict["address"] as? String
       // tabcell.rating.text = dict["rating"] as? String
      //  tabcell.users.text = dict["usercount"] as? String
        tabcell.rating.text = "\(dict["rating"]!)"
        tabcell.users.text =  "\(dict["usercount"]!)"
        tabcell.like.clipsToBounds=true
        tabcell.like.layer.cornerRadius=3
        
        let str_img1 = dict["feature_image"] as! String
        
        if str_img1=="" {
            
            tabcell.imgvw.image = UIImage (named: "def.jpg")
            
        }
        else
        {
            
            let url = URL(string: str_img1)
            tabcell.imgvw.kf.setImage(with: url)
            
        }
        
        tabcell.like.tag=indexPath.row
        tabcell.like.addTarget(self, action: #selector(likeunlike(sender:)), for: .touchUpInside)
        
        return tabcell
        
    }
    
    @IBAction func likeunlike(sender:UIButton)
    {
        let dict = ary[sender.tag] as! NSDictionary
        //let favorite_status = "\(dict["favorite_status"]!)"
        let landscaper_id = "\(dict["lanscaper_id"]!)"
        //if favorite_status=="1" {
            loadunllike(landscaper_id: landscaper_id)
//        }
//        else
//        {
//            loadlike(landscaper_id: landscaper_id)
//        }
    }
    
    func loadunllike(landscaper_id:String)
    {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        //address=kolkata&city=kolkata&state=wb&country=india&postal_code=700102&service_id=7
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.landscaper_id: landscaper_id,
                                  Parameter.status: "0"
        ]
        
        
        Alamofire.request(Webservice.remove_favorite, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        SVProgressHUD.show()
                        self.loaddata()
                        
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
        
        //SVProgressHUD.dismiss()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict = ary[indexPath.row] as! NSDictionary
        let str_id = "\(dict["lanscaper_id"]!)"
        let favorite_status = "\(dict["favorite_status"]!)"
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "sd") as! ServiceDetails
        obj.str_landscaperid=str_id
        obj.str_flag = "1"
       // obj.str_ser_id=ser_id
        //obj.like_status=favorite_status
        self.navigationController?.pushViewController(obj, animated: true)
    }
    @IBAction func back(_ sender: Any) {
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
