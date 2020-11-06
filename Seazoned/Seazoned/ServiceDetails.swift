//
//  ServiceDetails.swift
//  Seazoned
//
//  Created by Apple on 27/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import ImageSlideshow
import Firebase
class ServiceDetails: UIViewController,UITableViewDataSource,UITableViewDelegate {
      var flag_guest:String!
    
    @IBOutlet weak var linearProgressBar1: LinearProgressBar!
    @IBOutlet weak var linearProgressBar2: LinearProgressBar!
    @IBOutlet weak var linearProgressBar3: LinearProgressBar!
    @IBOutlet weak var linearProgressBar4: LinearProgressBar!
    @IBOutlet weak var linearProgressBar5: LinearProgressBar!
    
    var str_flag: String = ""
    
    @IBOutlet weak var scroll: UIScrollView!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var imgvw: UIImageView!
   
    @IBOutlet weak var banner: UIImageView!
    
    @IBOutlet weak var trans_view: UIView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var add: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var users: UILabel!
    
    @IBOutlet weak var book_view: UIView!
    
    @IBOutlet weak var rating_view: UIView!
    
    @IBOutlet weak var like_img: UIImageView!
    
    @IBOutlet weak var des: UILabel!
    
    @IBOutlet weak var tbl: UITableView!
    
    
    @IBOutlet weak var servicetable : UITableView!
    
    
    var str_landscaperid:String!
    
    var str_ser_id:String!
    
    var hrs_ary:NSArray!
    
    var like_status:String!
    
    @IBOutlet weak var last_view: UIView!
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet var btn_msg: UIButton!
    @IBOutlet var btn_profile: UIButton!
    
    @IBOutlet weak var  star5 : UILabel!
    @IBOutlet weak var  star4 : UILabel!
    @IBOutlet weak var  star3 : UILabel!
    @IBOutlet weak var  star2 : UILabel!
    @IBOutlet weak var  star1 : UILabel!
    @IBOutlet weak var overall : UILabel!
    
    var rating_ary:NSArray!
    
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
                      self.like_img.isHidden = false
                    self.btn_profile.isHidden = false
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
                    SVProgressHUD.show()
                    self.loaddata()
                    
                    
                    print("ok")
                    
                }
                    
                    
                else
                    
                {
                    self.btn_msg.isHidden = true
                    self.like_img.isHidden = true
                    

                    self.btn_profile.isHidden = true
                    SVProgressHUD.show()

                    self.loaddata_GUEST()
                    
                    print("holo nah")
                    
                    
                }
                
                
                
                
                
            }
            
        })
        
    }
    
    
    func check_BOOK()
        
    {
        
        
        
        
        
        
        
//        DB_BASE.child("check_user_login").observe(FIRDataEventType.value, with: { (snapshot) in
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
//                let status = value?.value(forKey: "check_flag") as! String
//
//
//
//
//                print("fggfgf\(value!)")
//
//
//
//
        
                
                
                
                if  self.flag_guest == "1"
                {
                    
                    if self.str_ser_id=="7" {
                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "snowprice") as! Snowremoval
                        obj.ser_id=self.str_ser_id
                        obj.added_ser_id=self.str_landscaperid
                        self.navigationController?.pushViewController(obj, animated: true)
                    }
                    else
                    {
                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "prcpg") as! PricePage
                        obj.ser_id=self.str_ser_id
                        obj.added_ser_id=self.str_landscaperid
                        self.navigationController?.pushViewController(obj, animated: true)
                    }
                    
                }
                    
                    
                else
                    
                {
                  
                    
                  //  let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
                    let obj = self.storyboard?.instantiateViewController(withIdentifier: "reg") as! Register

                    self.navigationController?.pushViewController(obj, animated: false)
                }
                
                
                
                
                
            }
            
       // })
        
   // }
    
    
    
    
    @IBAction func book(_ sender: Any) {
        
//        if str_ser_id=="7" {
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "snowprice") as! Snowremoval
//            obj.ser_id=str_ser_id
//            obj.added_ser_id=str_landscaperid
//            self.navigationController?.pushViewController(obj, animated: true)
//        }
//        else
//        {
//        let obj = self.storyboard?.instantiateViewController(withIdentifier: "prcpg") as! PricePage
//        obj.ser_id=str_ser_id
//        obj.added_ser_id=str_landscaperid
//        self.navigationController?.pushViewController(obj, animated: true)
//        }
        
        check_BOOK()
        
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
                        
                        self.loaddata()
                        //                        self.like_img.image=UIImage (named: "like (2).png")
                        //                        self.like_status="0"
                        
                        
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
    
    
    @IBAction func likeunlike(_ sender: Any) {

        if like_status=="1" {
            loadunllike(landscaper_id: str_landscaperid)
        }
        else
        {
            loadlike(landscaper_id: str_landscaperid)
        }
    }
    
    func loadlike(landscaper_id:String)
    {
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        //address=kolkata&city=kolkata&state=wb&country=india&postal_code=700102&service_id=7
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.landscaper_id: landscaper_id,
                                  Parameter.status: "1"
        ]
        
        
        Alamofire.request(Webservice.add_favorite, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                          self.loaddata()
//                        self.like_img.image=UIImage (named: "like (1).png")
//                        self.like_status="1"
                        
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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        des_obj.round_corner(my_view: rating_view,value: 3)
        des_obj.round_corner(my_view: book_view,value: 3)
        imgvw.layer.cornerRadius=imgvw.frame.size.width/2
        
        gradient(my_view: banner)
        
//        self.tbl.dataSource=nil
//        SVProgressHUD.show()
//        loaddata()
        
        if str_flag == "1"
        {
            self.book_view.isHidden = true
        }
        else
        {
             self.book_view.isHidden = false
        }
    }
    
   
    
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
        
      
        
        self.navigationController?.isNavigationBarHidden = true

        rating_ary=[]
        hrs_ary=[]
        self.tbl.dataSource=nil
        self.servicetable.dataSource=nil
        self.servicetable.tag = 1
        self.tbl.tag = 0
        
        check_tab()
//        SVProgressHUD.show()
//        loaddata()
    }
    
    func gradient(my_view:UIImageView)
    {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        //gradientLayer.colors = [UIColor (red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0).cgColor, UIColor .clear.cgColor]
        
        gradientLayer.colors = [UIColor .clear.cgColor, UIColor.black.cgColor]
        
        my_view.layer.addSublayer(gradientLayer)
        
//        gradientLayer.startPoint = CGPoint (x: 0.0, y: 0.5)
//        gradientLayer.endPoint = CGPoint (x: 1.0, y: 0.5)
        
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    ////--------------------///
    func loaddata_GUEST() {
        
       // let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        //address=kolkata&city=kolkata&state=wb&country=india&postal_code=700102&service_id=7
        
        let headers: HTTPHeaders = [
            "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjIyIiwidXNlcl9pZCI6IjIzIiwiZmlyc3RfbmFtZSI6Ikd1ZXN0IiwibGFzdF9uYW1lIjoidXNlciIsImVtYWlsIjoiZ3Vlc3RAZ21haWwuY29tIiwicGhvbmVfbnVtYmVyIjoiNzg5NDU2OTg1NiIsImRhdGVfb2ZfYmlydGgiOiIxOTcwLTAxLTAxIiwiYWRkcmVzcyI6Ik5ldyBZb3JrLCBOWSwgVVNBIiwiY2l0eSI6Ik5ldyBZb3JrIiwic3RhdGUiOiJOZXcgWW9yayIsImNvdW50cnkiOiIxOTMiLCJwcm9maWxlX2ltYWdlIjpudWxsLCJ1c2VyX3ByaW1hcnlfaWQiOiIyMyIsInByb2ZpbGVfaWQiOiIyIiwidXNlcm5hbWUiOiJndWVzdEBnbWFpbC5jb20iLCJwYXNzd29yZCI6IjgyN2NjYjBlZWE4YTcwNmM0YzM0YTE2ODkxZjg0ZTdiIiwidXNlcl90eXBlIjoiVXNlcnMiLCJhY3RpdmUiOiIxIn0.tsoc6IpEHJ_Lj5BMyviucAXyyy4MReSwl1Y84Vf3lI8",
            
            
            ]
        
        
        let params: Parameters = [Parameter.landscaper_id: "7"
        ]
        print(params)
        
        
        Alamofire.request(Webservice.lanscaper_details, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        let dict1 = dict["data"] as! NSDictionary
                        
                        let landinfo_ary = dict1["landscapper_info"] as! NSArray
                        
                        let ary_serprice = dict1["service_prices"] as! NSArray
                        
                        UserDefaults.standard.set(ary_serprice, forKey: "serviceprice")
                        
                        let info = landinfo_ary[0] as! NSDictionary
                        
                        self.name.text="\(info["name"]!)"
                        self.add.text="\(info["location"]!)"
                        self.des.text="\(info["description"]!)"
                        
                        self.like_status="\(info["favorite_status"]!)"
                        
                        if self.like_status=="1" {
                            self.like_img.image=UIImage (named: "like (1).png")
                        }
                        else
                        {
                            self.like_img.image=UIImage (named: "like (2).png")
                        }
                        
                        let str_img1 = info["feature_image"] as! String
                        
                        if str_img1=="" {
                            
                            self.banner.image = UIImage (named: "def.jpg")
                            
                        }
                        else
                        {
                            
                            let url = URL(string: str_img1)
                            self.banner.kf.setImage(with: url)
                            
                        }
                        
                        let str_img2 = info["profile_image"] as! String
                        
                        if str_img2=="" {
                            
                            self.imgvw.image = UIImage (named: "user (1).png")
                            
                        }
                        else
                        {
                            self.imgvw.contentMode = .scaleAspectFit
                            let url = URL(string: str_img2)
                            self.imgvw.kf.setImage(with: url)
                            
                        }
                        
                        self.hrs_ary = dict1["service_time"] as! NSArray
                        
                        self.tbl.dataSource=self
                        self.tbl.reloadData()
                        //self.createtable()
                        
                        if self.like_status=="1" {
                            self.like_img.image=UIImage (named: "like (1).png")
                        }
                        else
                        {
                            self.like_img.image=UIImage (named: "like (2).png")
                        }
                        
                        let ary_img = dict1["landscaper_service_images"] as! NSArray
                        
                        self.slideshow(img_ary: ary_img)
                        
                        // Mark Surjava
                        let dict2 = dict1["all_rating"] as! NSDictionary
                        
                        self.overall.text = "\(dict1["overall_rating"]!)"
                        
                        
                        let star51 = dict2["5"] as! Int
                        let star41 = dict2["4"] as! Int
                        let star31 = dict2["3"] as! Int
                        let star21 = dict2["2"] as! Int
                        let star11 = dict2["1"] as! Int
                        self.star5.text = "\(star51)"
                        self.star4.text = "\(star41)"
                        self.star3.text = "\(star31)"
                        self.star2.text = "\(star21)"
                        self.star1.text = "\(star11)"
                        
                        
                        
                        let total = star11+star21+star31+star41+star51
                        
                        var x3  = (Float(star31)/Float(total))*100.0
                        var x2  = (Float(star21)/Float(total))*100.0
                        var x  = (Float(star11)/Float(total))*100.0
                        var x4  = (Float(star41)/Float(total))*100.0
                        var x5  = (Float(star51)/Float(total))*100.0
                        
                        
                        self.linearProgressBar5.progressValue=CGFloat(x5)
                        self.linearProgressBar4.progressValue=CGFloat(x4)
                        self.linearProgressBar3.progressValue=CGFloat(x3)
                        self.linearProgressBar2.progressValue=CGFloat(x2)
                        self.linearProgressBar1.progressValue=CGFloat(x)
                        
                        self.rating_ary = dict1["service_rating_details"] as! NSArray
                        
                        self.servicetable.dataSource=self
                        self.servicetable.reloadData()
                        self.createtable()
                        
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        //AppManager().AlertUser("Message", message: msg, vc: self)
                        self.tbl.dataSource=nil
                        self.hrs_ary = []
                        self.createtable()
                        SVProgressHUD.dismiss()
                    }
                    
                    
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
        }
        
        
        
    }
    
    
    
    
    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        //address=kolkata&city=kolkata&state=wb&country=india&postal_code=700102&service_id=7
        
            let headers: HTTPHeaders = [
                    "token": token as! String,
                    
                    
                ]
        
        
        let params: Parameters = [Parameter.landscaper_id: str_landscaperid!
        ]
        print(params)
        
        
        Alamofire.request(Webservice.lanscaper_details, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        let dict1 = dict["data"] as! NSDictionary
                        
                        let landinfo_ary = dict1["landscapper_info"] as! NSArray
                        
                        let ary_serprice = dict1["service_prices"] as! NSArray
                        
                        UserDefaults.standard.set(ary_serprice, forKey: "serviceprice")
                        
                        let info = landinfo_ary[0] as! NSDictionary
                        
                        self.name.text="\(info["name"]!)"
                        self.add.text="\(info["location"]!)"
                        self.des.text="\(info["description"]!)"
                        
                        self.like_status="\(info["favorite_status"]!)"
                        
                        if self.like_status=="1" {
                            self.like_img.image=UIImage (named: "like (1).png")
                        }
                        else
                        {
                            self.like_img.image=UIImage (named: "like (2).png")
                        }
                        
                        let str_img1 = info["feature_image"] as! String
                        
                        if str_img1=="" {
                            
                            self.banner.image = UIImage (named: "def.jpg")
                            
                        }
                        else
                        {
                            
                            let url = URL(string: str_img1)
                            self.banner.kf.setImage(with: url)
                            
                        }
                        
                        let str_img2 = info["profile_image"] as! String
                        
                        if str_img2=="" {
                            
                            self.imgvw.image = UIImage (named: "user (1).png")
                            
                        }
                        else
                        {
                             self.imgvw.contentMode = .scaleAspectFit
                            let url = URL(string: str_img2)
                            self.imgvw.kf.setImage(with: url)
                            
                        }
                        
                        self.hrs_ary = dict1["service_time"] as! NSArray
            
                        self.tbl.dataSource=self
                        self.tbl.reloadData()
                        //self.createtable()
                        
                        if self.like_status=="1" {
                            self.like_img.image=UIImage (named: "like (1).png")
                        }
                        else
                        {
                            self.like_img.image=UIImage (named: "like (2).png")
                        }
                        
                        let ary_img = dict1["landscaper_service_images"] as! NSArray
                        
                        self.slideshow(img_ary: ary_img)
                        
                        // Mark Surjava
                        let dict2 = dict1["all_rating"] as! NSDictionary
                        
                        self.overall.text = "\(dict1["overall_rating"]!)"
                        
                        
                        let star51 = dict2["5"] as! Int
                        let star41 = dict2["4"] as! Int
                        let star31 = dict2["3"] as! Int
                        let star21 = dict2["2"] as! Int
                        let star11 = dict2["1"] as! Int
                        self.star5.text = "\(star51)"
                        self.star4.text = "\(star41)"
                        self.star3.text = "\(star31)"
                        self.star2.text = "\(star21)"
                        self.star1.text = "\(star11)"
                        
                        
                        
                        let total = star11+star21+star31+star41+star51
                        
                        var x3  = (Float(star31)/Float(total))*100.0
                        var x2  = (Float(star21)/Float(total))*100.0
                        var x  = (Float(star11)/Float(total))*100.0
                        var x4  = (Float(star41)/Float(total))*100.0
                        var x5  = (Float(star51)/Float(total))*100.0
                        
                        
                        self.linearProgressBar5.progressValue=CGFloat(x5)
                        self.linearProgressBar4.progressValue=CGFloat(x4)
                        self.linearProgressBar3.progressValue=CGFloat(x3)
                        self.linearProgressBar2.progressValue=CGFloat(x2)
                        self.linearProgressBar1.progressValue=CGFloat(x)
                        
                        self.rating_ary = dict1["service_rating_details"] as! NSArray
                        
                        self.servicetable.dataSource=self
                        self.servicetable.reloadData()
                        self.createtable()
                        
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        //AppManager().AlertUser("Message", message: msg, vc: self)
                        self.tbl.dataSource=nil
                        self.hrs_ary = []
                        self.createtable()
                        SVProgressHUD.dismiss()
                    }
                    
                    
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
        }
        
        
        
    }
    
    //MARK: Slide Show
    
    func slideshow(img_ary:NSArray)
    {
        
        if img_ary.count==0 {
            self.slideshow.slideshowInterval = 2.0
            self.slideshow.pageControlPosition = .insideScrollView
            self.slideshow.contentScaleMode = .scaleAspectFill
            self.slideshow.circular = true
            self.slideshow.preload = .all
            
            self.slideshow.setImageInputs([KingfisherSource (urlString: Webservice.static_image)!])
        }
        else
        {
            
            
            self.slideshow.slideshowInterval = 2.0
            self.slideshow.pageControlPosition = .insideScrollView
            self.slideshow.contentScaleMode = .scaleToFill
            self.slideshow.circular = true
            self.slideshow.preload = .all
            
            for i in 0...img_ary.count-1
            {
                
                let dict = img_ary[i] as! NSDictionary
                let str_img = "\(dict["service_image"]!)"
                
                print(str_img)
                
                self.slideshow.setImageInputs([KingfisherSource (urlString: str_img)!
                    ])
                
            }
        }
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
        else if sender.tag==3 {   let obj = self.storyboard?.instantiateViewController(withIdentifier: "contuct") as! contuct
            self.navigationController?.pushViewController(obj, animated: false)
            
        }
            //Profile
        else
        {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "pr") as! Profile
            self.navigationController?.pushViewController(obj, animated: false)
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0
        {
            return hrs_ary.count
        }
        else
        {
            return rating_ary.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0
        
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "srvchrs") as! BookCell
        let dict=hrs_ary[indexPath.row] as! NSDictionary
        cell.day.text="\(dict["service_day"]!)"
            
            let time1 = "\(dict["start_time"]!)"
            let time2 = "\(dict["end_time"]!)"
            
            cell.time.text = AppManager().timeformatter(str_date: time1) + " - " + AppManager().timeformatter(str_date: time2)
            
        //cell.time.text="\(dict["start_time"]!) - \(dict["end_time"]!)"
            
            
            
            
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "rc") as! RatingCell
            let dict = rating_ary[indexPath.row] as! NSDictionary
            cell.name.text="\(dict["first_name"]!) \(dict["last_name"]!)"
            cell.review.sizeToFit()
            cell.review.text="\(dict["review"]!)"
            cell.rt_date.text=""
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
            cell.floatRatingView.backgroundColor=UIColor.white
            let str_rating = "\(dict["rating_value"]!)"
            cell.floatRatingView.minRating=Int(str_rating)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 0
        {
            return 51
        }
        else
        
        {
            
            return 100
        }
    }
    
    func createtable()
    {
        tbl.frame=CGRect (x: tbl.frame.origin.x, y: tbl.frame.origin.y, width: tbl.frame.size.width, height: CGFloat(hrs_ary.count)*51)
        last_view.frame=CGRect (x: last_view.frame.origin.x, y: tbl.frame.origin.y+tbl.frame.size.height, width: last_view.frame.size.width, height: last_view.frame.size.height)
        servicetable.frame=CGRect (x: last_view.frame.origin.x, y: last_view.frame.origin.y + last_view.frame.size.height, width: servicetable.frame.size.width, height: CGFloat(rating_ary.count)*100)
        scroll.contentSize=CGSize (width: 0, height: servicetable.frame.origin.y+servicetable.frame.size.height+10)
        
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
