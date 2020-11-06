//
//  BookingHistoryDetails1.swift
//  Seazoned
//
//  Created by Apple on 21/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import ImageSlideshow
import Firebase

class BookingHistoryDetails1: UIViewController,FloatRatingViewDelegate,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aryserviceimage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sercl", for: indexPath) as! ServiceimageCell
        let dict = aryserviceimage[indexPath.row] as! NSDictionary
        let str_img = "\(dict["service_image"]!)"
        
        let url = URL(string: str_img)
        cell.imgvw.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict = aryserviceimage[indexPath.row] as! NSDictionary
        let str_img = "\(dict["service_image"]!)"
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "si") as! ShowImage
        
        popOverVC.str_img=str_img
        
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    @IBOutlet weak var like_img : UIImageView!
    
    var     str_landscaperid  : String = ""
    var like_status : String = ""
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var ordr_no: UILabel!
    

    
    
    
    
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var ser_name: UILabel!
    
    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var txtvw: UITextView!
    
    @IBOutlet weak var pro_view: UIView!
    
    @IBOutlet weak var slider_view: UIView!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet var ratingSegmentedControl: UISegmentedControl!
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet weak var col: UICollectionView!
    
    var order_id:String!
    
    var str_rating:String!
    
    var landscaper_id:String!
    
    var status:String!
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
        txtvw.text==" "
        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        des_obj.button_round(my_view: pro_view)
        
        des_obj.green_gradient(my_view: pro_view)
        
        txtvw.layer.borderWidth=1
        txtvw.layer.borderColor=UIColor.lightGray.cgColor
        txtvw.layer.cornerRadius=3
        
        scroll.isHidden=true
        
        txtvw.delegate=self
        
        col.dataSource=nil
        col.delegate=nil
        
        SVProgressHUD.show()
        loaddata()
        
        floatRatingView.backgroundColor = UIColor.clear
        
        /** Note: With the exception of contentMode, type and delegate,
         all properties can be set directly in Interface Builder **/
        floatRatingView.delegate = self
        floatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        floatRatingView.type = .wholeRatings
        
        // Segmented control init
        //ratingSegmentedControl.selectedSegmentIndex = 1
        
        // Labels init
        //liveLabel.text = String(format: "%.2f", self.floatRatingView.rating)
        //updatedLabel.text = String(format: "%.2f", self.floatRatingView.rating)
        
        str_rating = ""
        
    }

    func loaddata() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.order_id: order_id]
        
        
        Alamofire.request(Webservice.booking_history_details, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        let ordrdet = dict1["order_details"] as! NSDictionary
                        self.ordr_no.text="\(ordrdet["order_no"]!)"
                        self.ser_name.text="\(ordrdet["service_name"]!)"
                        self.name.text="\(ordrdet["landscaper_business_name"]!)"
                        
                       // lanscaper_name
                      //  landscaper_business_name
                        self.total.text="Grand Total $\(ordrdet["service_price"]!)"
                        
                        self.landscaper_id="\(ordrdet["landscaper_id"]!)"
                        
                        let str_img="\(ordrdet["profile_image"]!)"
                        
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
                        
                        self.like_status = "\(dict1["favourite_status"]!)"
                      //  print("89899999----\(self.like_status)")
                        
                        if  self.like_status=="1" {
                            self.like_img.image=UIImage (named: "like (1).png")
                        }
                        else
                        {
                            self.like_img.image=UIImage (named: "like (2).png")
                        }
                        
                        let ary_img = dict1["service_images"] as! NSArray
                        
                        self.coldatafetch(img_ary: ary_img)
                        
                        //self.slideshow(img_ary: ary_img)
                        
                        self.scroll.isHidden=false
                        
                        let str_fav="\(dict1["favourite_status"]!)"
                        
                        if str_fav=="0"
                        {
                            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "adfvpop") as! AddFavoritePopup
                            
                            popOverVC.landscaper_id=self.landscaper_id
                            
                            self.addChildViewController(popOverVC)
                            popOverVC.view.frame = self.view.frame
                            self.view.addSubview(popOverVC.view)
                            popOverVC.didMove(toParentViewController: self)
                            
                        }
                        else
                        {
                            
                        }
                        
                        SVProgressHUD.dismiss()
                        
                        
                    }
                    else
                    {
                        //AppManager().AlertUser("Message", message: msg, vc: self)
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
    
    var aryserviceimage:NSArray!
    
    func coldatafetch(img_ary:NSArray)  {
        
        if img_ary.count==0 {
            aryserviceimage=[["service_image":Webservice.static_image] as NSDictionary]
        }
        else
        {
            aryserviceimage=img_ary
        }
        
        self.col.dataSource=self
        self.col.delegate=self
        col.reloadData()
        
        scroll.contentSize = CGSize (width: 0, height: col.contentSize.height)

        
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
    
    @IBAction func likeunlike(_ sender: Any) {
        
        if like_status=="1" {
            loadunllike(landscaper_id:  self.landscaper_id)
        }
        else
        {
            loadlike(landscaper_id: self.landscaper_id)
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if txtvw.text=="Write a review" {
            txtvw.text=""
        }
        else
        {
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtvw.text=="" {
            txtvw.text="Write a review"
        }
        else
        {
            
        }
    }
    
//    @IBAction func ratingTypeChanged(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            floatRatingView.type = .wholeRatings
//        case 1:
//            floatRatingView.type = .halfRatings
//        case 2:
//            floatRatingView.type = .floatRatings
//        default:
//            floatRatingView.type = .wholeRatings
//        }
//    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pay(_ sender: Any) {
        
        if str_rating=="" {
            AppManager().AlertUser("Warning", message: "Please Rate The Service", vc: self)
        }
       if txtvw.text=="Write a review" {
            AppManager().AlertUser("Warning", message: "Please Review The Service", vc: self)
        }
            
        else
        {
            SVProgressHUD.show(withStatus: "Submitting Your Review...")
            loadaddratingreview()
        }
    }
    
    func loadaddratingreview() {
        
        let currentDateTime = Date()
        
        print(currentDateTime)
        
        let format1 = DateFormatter()
        format1.dateFormat="yyyy-MM-dd HH:mm:ss z"
        let date1 = format1.date(from: "\(currentDateTime)")
        let format2 = DateFormatter()
        format2.dateFormat="yyyy-MM-dd HH:mm:ss"
        let str_result = format2.string(from: date1!)
        
        print(str_result)
        var str_review:String!
        
        if txtvw.text=="Write a review" {
            str_review=""
        }
        else
        {
            str_review=txtvw.text!
        }
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,

            ]
        
        
        let params: Parameters = [Parameter.landscaper_id: landscaper_id!,
                                  Parameter.rating: str_rating!,
                                  Parameter.review: str_review!,
                                  "rating_time":str_result,"order_id":order_id]
        
        
        Alamofire.request(Webservice.give_rate_review, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
//                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd2") as! BookingHistoryDetails2
//                        obj.order_id=self.order_id
//                     self.navigationController?.pushViewController(obj, animated: true)
                        
                        
                        
                        self.navigationController?.popViewController(animated: true)

                        //SVProgressHUD.dismiss()
                        
                        
                    }
                    else
                    {
                        AppManager().AlertUser("Message", message: msg, vc: self)
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



//extension BookingHistoryDetails1: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        //liveLabel.text = String(format: "%.2f", self.floatRatingView.rating)
        
        print("---\(self.floatRatingView.rating)")
        str_rating = "\(self.floatRatingView.rating)"
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        //updatedLabel.text = String(format: "%.2f", self.floatRatingView.rating)
        
        print("--\(self.floatRatingView.rating)")
    //}
    
}
}
