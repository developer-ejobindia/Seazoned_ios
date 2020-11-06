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

class Chatlist: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var array_id = NSMutableArray()
    
    @IBOutlet weak var lower_view: UIView!
    
    @IBOutlet weak var nodata: UILabel!
    
    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var bell_view: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        des_obj.round_corner(my_view: lower_view,value: 6)
        des_obj.view_round(my_view: bell_view)
        
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
     //   cell.book_id.text="\(dict["landscaper_user_first_name"]!) \(dict["landscaper_user_last_name"]!)"
        
        
        
        
        cell.book_id.text="\(dict["landscapers_business_name"]!)"

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
        
       // let str_serid = "\(dict["service_id"]!)"
      //  imageadding(ser_id: str_serid, cellimg: cell.imgvw)
        
        
        let str_img="\(dict["landscaper_profile_image"]!)"
        
        
     //    cell.imgvw.setImageFromURl(stringImageUrl: str_img)
        let  order_no="\(dict["order_no"]!)"

        
       if UserDefaults.standard.object(forKey: "ar_value") != nil
       {
     //   cell.backgroundColor = UIColor.red
        
        
        var ary = NSArray()
        
        
        ary = UserDefaults.standard.array(forKey: "ar_value")  as! NSArray
        
                //    let o_id  = UserDefaults.standard.object(forKey: "orderNo") as! String
        
           // array_id.add(o_id)
        
        
        
        
        
                    if  ary.contains(order_no)
                    {
                      //  cell.ser_name.textColor = UIColor.red

                        cell.re_img.isHidden = false
                    }

                    else

                    {

                       // cell.ser_name.textColor = UIColor.blue
                        cell.re_img.isHidden = true


                    }
        }
        else
       {
          cell.re_img.isHidden = true
        // cell.backgroundColor = UIColor.blue
        }
        
    
        
        cell.work_view.backgroundColor = UIColor.white
        
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
        
        
      //  let des_obj = Design()
       // des_obj.red_gradient(my_view: cell.work_view)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = ary[indexPath.row] as! NSDictionary
       // landscaper_profile_image
        let order_no="\(dict["order_no"]!)"
        let service_name="\(dict["service_name"]!)"
        let sender_id="\(dict["customer_id"]!)"
        let reciver_id="\(dict["landscaper_id"]!)"
        let landscaper_user_id="\(dict["landscaper_user_id"]!)"

       // landscaper_user_id
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "cvc") as! ChatViewController
        
        
         obj.str_land =  "\(dict["landscaper_profile_image"]!)"
        
        obj.firebase_token_IOS =  "\(dict["iphone_firebase_token"]!)"
 obj.firebase_token_AND =  "\(dict["android_firebase_token"]!)"
        obj.ordr_id=order_no
        obj.str_sername=service_name
        obj.sender_id=sender_id
        obj.reciver_id=reciver_id
        
          obj.landscaper_user_id=landscaper_user_id
        obj.name1="\(dict["landscaper_user_first_name"]!) \(dict["landscaper_user_last_name"]!)"
        self.navigationController?.pushViewController(obj, animated: true)
       
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
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
    
    
    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
//
//        tbl.dataSource=nil
//        tbl.isHidden=true
//        nodata.isHidden=true
//
//        SVProgressHUD.show()
//        loaddata()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

        tbl.dataSource=nil
        tbl.isHidden=true
        nodata.isHidden=true

        SVProgressHUD.show()
        loaddata()
        
    }
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        Alamofire.request(Webservice.user_chat_list,method: .get, headers: headers)
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
                       // [5]    (null)    "landscaper_profile_image" : ""    
                        let dict1 = dict["data"] as! NSDictionary
                        self.ary = dict1["message"] as! NSArray
                        
                        
                        
                      
                        
                        
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
                        
                        
                        self.tbl.dataSource=self
                        self.tbl.isHidden=false
                        self.nodata.isHidden=true
                        self.tbl.reloadData()
                        self.tbl.tableFooterView=UIView()
                        
                        SVProgressHUD.dismiss()
                        
                        
                        
                        
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
