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
class BookingHistoryDetails3: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {

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
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var ordr_no: UILabel!
    
    @IBOutlet weak var lw_size: UILabel!
    @IBOutlet weak var lw_size_value: UILabel!
    
    @IBOutlet weak var grass_ln: UILabel!
    @IBOutlet weak var grass_ln_value: UILabel!
    
    @IBOutlet weak var trd_ln: UILabel!
    @IBOutlet weak var trd_ln_value: UILabel!
    
    @IBOutlet weak var fd_ln: UILabel!
    @IBOutlet weak var fd_ln_value: UILabel!
    
    
    
    
    
    

    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var ser_name: UILabel!

    @IBOutlet weak var imgvw: UIImageView!

    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var total: UILabel!

    //@IBOutlet weak var txtvw: UITextView!

    //@IBOutlet weak var pro_view: UIView!

    //@IBOutlet weak var slider_view: UIView!

    @IBOutlet weak var scroll: UIScrollView!

    //@IBOutlet var ratingSegmentedControl: UISegmentedControl!
    //@IBOutlet var floatRatingView: FloatRatingView!
    
    @IBOutlet weak var freqncy: UILabel!
    
    @IBOutlet weak var rqst_dt: UILabel!
    
    @IBOutlet weak var cmplt_dt: UILabel!
    
    @IBOutlet weak var des: UILabel!
    
    @IBOutlet weak var add: UILabel!
    
    @IBOutlet weak var phn: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    //@IBOutlet weak var last_view: UIView!
    
    @IBOutlet weak var single: UILabel!
    
    @IBOutlet weak var sngl_prc: UILabel!
    
    @IBOutlet weak var tax: UILabel!
    
    @IBOutlet weak var grand_total: UILabel!
    
    @IBOutlet weak var slideshow2: ImageSlideshow!
    
    @IBOutlet weak var land_name2: UILabel!
    
    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var col: UICollectionView!
    
    

    var order_id:String!

    var str_rating:String!
    
    var rating_ary :NSArray!
    
    var landscaper_id:String!
    
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

        //let des_obj = Design()
        //des_obj.button_round(my_view: pro_view)

        //des_obj.green_gradient(my_view: pro_view)

//        txtvw.layer.borderWidth=1
//        txtvw.layer.borderColor=UIColor.lightGray.cgColor
//        txtvw.layer.cornerRadius=3
        
        rating_ary = []
        
        tbl.dataSource=nil

        scroll.isHidden=true

        SVProgressHUD.show()
        loaddata()

        col.dataSource=nil
        col.delegate=nil

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
                        
                        print("order details-----\(ordrdet)")
                            self.freqncy.text =   "\(ordrdet["service_frequency"]!)"
                        self.ordr_no.text="\(ordrdet["order_no"]!)"
                        self.ser_name.text="\(ordrdet["service_name"]!)"
                        self.name.text="\(ordrdet["landscaper_business_name"]!)"
                        self.land_name2.text="\(ordrdet["landscaper_business_name"]!)"
                       // self.total.text="Paid $\(ordrdet["service_price"]!)"
                        self.total.text="Grand Total $\(ordrdet["service_price"]!)"

                        self.landscaper_id="\(ordrdet["landscaper_id"]!)"
                        
                        
                        if  self.ser_name.text == "Snow Removal"
                            
                        {
                            
                            self.fd_ln.isHidden = true
                            self.fd_ln_value.isHidden = true
                            
                            
                            self.lw_size.text = "Driveway Type"
                            self.lw_size_value.text = "\(ordrdet["driveway_type"]!)"
                            
                            self.grass_ln.text = "No of cars"
                            self.grass_ln_value.text = "\(ordrdet["no_of_cars"]!)"
                            
                            self.trd_ln.text = "Service Type"
                            self.trd_ln_value.text = "\(ordrdet["service_type"]!)"
                            
                        }
                            
                        else     if  self.ser_name.text == "Lawn Treatment"  ||  self.ser_name.text == "Sprinkler Winterizing" ||  self.ser_name.text == "Aeration"
                            
                        {
                            
                            self.fd_ln.isHidden = true
                            self.fd_ln_value.isHidden = true
                            self.trd_ln.isHidden = true
                            self.trd_ln_value.isHidden = true
                            self.grass_ln.isHidden = true
                            self.grass_ln_value.isHidden = true
                            // self.lw_size.text = "Driveway Type"
                            self.lw_size_value.text = "\(ordrdet["lawn_area"]!)"
                            
                            
                            
                        }
                            
                            
                            
                            
                        else  if  self.ser_name.text == "Pool Cleaning & Upkeep"
                            
                        {
                            
                            self.fd_ln.isHidden = false
                            self.fd_ln_value.isHidden = false
                            self.lw_size.text = "Pool Water Type"
                            self.lw_size_value.text = "\(ordrdet["water_type"]!)"
                            
                            self.grass_ln.text = "Include Spa/Hot Tub"
                            self.grass_ln_value.text = "\(ordrdet["include_spa"]!)"
                            
                            self.trd_ln.text = "Pool Type"
                            self.trd_ln_value.text = "\(ordrdet["pool_type"]!)"
                            
                            self.fd_ln.text = "Pool State"
                            self.fd_ln_value.text = "\(ordrdet["pool_state"]!)"
                            
                            
                            
                            
                        }
                        else  if  self.ser_name.text == "Leaf Removal"
                            
                        {
                            
                            
                            self.lw_size_value.text = "\(ordrdet["lawn_area"]!)"
                            
                            self.grass_ln.text = "Leaf Accumulation"
                            
                            self.grass_ln_value.text = "\(ordrdet["leaf_accumulation"]!)"
                            
                            self.fd_ln.isHidden = true
                            self.fd_ln_value.isHidden = true
                            self.trd_ln.isHidden = true
                            self.trd_ln_value.isHidden = true
                            
                            
                            
                        }
                            
                        else
                            
                        {
                            
                            self.lw_size_value.text = "\(ordrdet["lawn_area"]!)"
                            
                            self.grass_ln_value.text = "\(ordrdet["grass_length"]!)"
                            
                            self.fd_ln.isHidden = true
                            self.fd_ln_value.isHidden = true
                            self.trd_ln.isHidden = true
                            self.trd_ln_value.isHidden = true
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        

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


//                        let ary_img = dict1["service_images"] as! NSArray
//
//                        self.slideshow(img_ary: ary_img)
                        
                        let ary_img = dict1["service_images"] as! NSArray
                        
                        self.coldatafetch(img_ary: ary_img)
                        
                        let ary_landimg = dict1["landscaper_service_images"] as! NSArray
                        
                        self.slideshow2(img_ary: ary_landimg)

                        self.scroll.isHidden=false
                        
                        self.rating_ary = dict1["rating_review"] as! NSArray
                        
                        self.tbl.dataSource=self
                        self.tbl.reloadData()
                        self.createtable()
                        
                        //self.scroll.contentSize=CGSize (width: 0, height: self.last_view.frame.origin.y+self.last_view.frame.size.height+10)
                        
                        let dict_address = dict1["service_address"] as! NSDictionary
                        
                        let str_rqdate = "\(ordrdet["service_date"]!)"
                        
                        print("date------\(str_rqdate)")
                        
                        let service_time = "\(ordrdet["service_time"]!)"
                        let additional_note = "\(ordrdet["additional_note"]!)"
                        
                        if additional_note==""
                        {
                            self.des.text="---"
                        }
                        else
                        {
                            self.des.text=additional_note
                        }
                        
                        self.rqst_dt.text="\(AppManager().dateformatternew(str_date: str_rqdate)) \(AppManager().timeformatter(str_date: service_time))"
                        
                        let str_comdate = "\(ordrdet["completion_date"]!)"
                        
                        if str_comdate==""  ||  str_comdate == "<null>"
                        {
                            self.cmplt_dt.text="---"
                        }
                            
                            
                        else
                        {
                         self.cmplt_dt.text="\(AppManager().dateformatterct(str_date: str_comdate))"
                        }
                        
                    
                        
                        self.add.text="\(dict_address["name"]!),\(dict_address["address"]!)"
                        self.phn.text="\(dict_address["contact_number"]!)"
                        self.email.text="\(dict_address["email_address"]!)"
                        
                        let str_price = "\(ordrdet["service_booked_price"]!)"
                        
                        self.sngl_prc.text = "$\(str_price)"
                        
                        let base_price = Float(str_price)
                        
                        
                        
                        if let value_price = base_price
                        {
                            let vvv = String(format: "%.2f", value_price)
                            
                            self.sngl_prc.text = "$\(vvv)"
                            let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
                            
                             let  rate_value =  Float(rate)
                            
                            
                            print("float value-------\(rate_value!)")
                            let tax = value_price * rate_value!/100
                            
                            
                            let tax1 = String(format: "%.2f", tax)
                            
                            self.tax.text = "$\(tax1)"
                            
                            
                            let tx_value = Float(tax)
                            
                            
                            
                            let total =  value_price + tx_value
                            
                            
                            let total_value = String(format: "%.2f", total)
                            
                               self.grand_total.text = "$\(total_value)"
                        }
                        
                        else
                        {

                      
                        }
                        
                        
                     
                        
                       
                        
                        //self.single.text = "\(ordrdet["service_price"]!)"
                        
                        
                        
                        self.des.sizeToFit()
                        self.add.sizeToFit()
                        
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
                        self.tbl.dataSource=nil
                        self.rating_ary = []
                        //AppManager().AlertUser("Message", message: msg, vc: self)
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
        
        //scroll.contentSize = CGSize (width: 0, height: col.contentSize.height)
        
        
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
        self.slideshow.contentScaleMode = .scaleAspectFill
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
    
    func slideshow2(img_ary:NSArray)
    {
        
        if img_ary.count==0 {
            self.slideshow2.slideshowInterval = 2.0
            self.slideshow2.pageControlPosition = .insideScrollView
            self.slideshow2.contentScaleMode = .scaleAspectFill
            self.slideshow2.circular = true
            self.slideshow2.preload = .all
            
            self.slideshow2.setImageInputs([KingfisherSource (urlString: Webservice.static_image)!])
        }
        else
        {
            
            
            self.slideshow2.slideshowInterval = 2.0
            self.slideshow2.pageControlPosition = .insideScrollView
            self.slideshow2.contentScaleMode = .scaleAspectFill
            self.slideshow2.circular = true
            self.slideshow2.preload = .all
            
            for i in 0...img_ary.count-1
            {
                
                let dict = img_ary[i] as! NSDictionary
                let str_img = "\(dict["service_image"]!)"
                
                print(str_img)
                
                self.slideshow2.setImageInputs([KingfisherSource (urlString: str_img)!
                    ])
                
            }
        }
    }
    
    func createtable()
    {
        tbl.frame = CGRect (x: tbl.frame.origin.x, y: tbl.frame.origin.y, width: tbl.frame.size.width, height: CGFloat(rating_ary.count)*100)
        scroll.contentSize=CGSize (width: 0, height: tbl.frame.origin.y+tbl.frame.size.height+10)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rating_ary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rc") as! RatingCell
        let dict = rating_ary[indexPath.row] as! NSDictionary
        cell.name.text="\(dict["name"]!)"
        cell.review.sizeToFit()
        cell.review.text="\(dict["review"]!)"
        cell.rt_date.text="\(dict["date"]!)"
        let str_img="\(dict["profile_picture"]!)"
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
        let str_rating = "\(dict["rating"]!)"
        cell.floatRatingView.minRating=Int(str_rating)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
        else
        {
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "bhd2") as! BookingHistoryDetails2
//            obj.order_id=order_id
//            self.navigationController?.pushViewController(obj, animated: true)
        }
    }

    //MARK: Tabbar

    @IBAction func tabbar(_ sender: UIButton) {

        //Help
        if sender.tag==0 {

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

