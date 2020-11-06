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
import Firebase
class BookingHistoryDetails2: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var ordr_no: UILabel!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var ser_name: UILabel!
    
    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var total: UILabel!
    
    //@IBOutlet weak var txtvw: UITextView!
    
    @IBOutlet weak var pro_view: UIView!
    
    @IBOutlet weak var slider_view: UIView!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var last_view: UIView!
    
    @IBOutlet weak var pay_lbl: UILabel!
    
    @IBOutlet weak var single: UILabel!
    
    @IBOutlet weak var sngl_prc: UILabel!
    
    @IBOutlet weak var tax: UILabel!
    
    @IBOutlet weak var grand_total: UILabel!
    
    @IBOutlet weak var pay_lbl2: UILabel!
    
    
    
    
    
    var order_id:String!
    
    var card_no:String!
    var ccExpiryMonth:String!
    var ccExpiryYear:String!
    var cvvNumber:String!
    var total_amount:String!
    var name_oncard:String!
    
    var admin_email:String!
    var percentage:String!
    var landscaper_email:String!
    
    var landscaper_id:String!
    
    var order_no:String!
    
    @IBOutlet weak var paynormal: UIButton!
    
    @IBAction func paypaypal(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Fetching Paypal Accounts...")
        loadadminacc()
    }
    @IBAction func pay(_ sender: Any) {
        
        if cvvNumber=="" {
            AppManager().AlertUser("Warning", message: "Please Select A Card", vc: self)
        }
        else
        {
            SVProgressHUD.show(withStatus: "Payment Processing...")
            loaddpay()
        }
        
    }
    @IBAction func addcard(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        des_obj.button_round(my_view: pro_view)
        
        des_obj.green_gradient(my_view: pro_view)
        
        /*txtvw.layer.borderWidth=1
        txtvw.layer.borderColor=UIColor.lightGray.cgColor
        txtvw.layer.cornerRadius=3*/
        
        pay_lbl.clipsToBounds=true
        pay_lbl.layer.cornerRadius=pay_lbl.frame.size.height/2
        
        scroll.isHidden=true
        
        tbl.dataSource=nil
        tbl.delegate=self
        
        SVProgressHUD.show()
        loaddata()
        
//        SVProgressHUD.show()
//        loadcard()
        
        cvvNumber = ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show()
        loadcard()
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
                        self.order_no="\(ordrdet["order_no"]!)"
                        self.ser_name.text="\(ordrdet["service_name"]!)"
                        self.name.text="\(ordrdet["landscaper_business_name"]!)"
                        self.landscaper_id="\(ordrdet["landscaper_id"]!)"
                        self.total.text="Grand Total $\(ordrdet["service_price"]!)"
                        
                     //   let str_price = "\(ordrdet["service_price"]!)"
                        
                     
                        
                        let str_price = "\(ordrdet["service_booked_price"]!)"
                        
                        
                     
                        
                        let base_price = Float(str_price)
                        
                        
                        
                        
                        
                        if let value_price = base_price
                        {
                            
                            
                            let rate = UserDefaults.standard.object(forKey: "rate")  as!  String
                            
                           let  rate_value =  Float(rate)
                            
                            
                             let vvv = String(format: "%.2f", value_price)
                            
                               self.sngl_prc.text = "$\(vvv)"
                            
                            let tax = value_price * rate_value!/100
                            
                            
                            let tax1 = String(format: "%.2f", tax)
                            
                            self.tax.text = "$\(tax1)"
                            
                            
                            let tx_value = Float(tax)
                            
                            
                            
                            let total =  value_price + tx_value
                            
                            
                            let total_value = String(format: "%.2f", total)

                            
                           
                            
                            self.grand_total.text = "$\(total_value)"
                            
                            
                            self.total_amount = "\(total_value)"
                            
                            
                            self.pay_lbl.text = "PAY $\(total_value) WITH PAYPAL"
                            
                            self.pay_lbl2.text = "PAY $\(total_value) NOW"
                            
                            
                        }
                            
                        else
                        {
                            
                            
                        }
                        
                        //self.single.text = "\(ordrdet["service_price"]!)"
                        
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
                        
                        self.scroll.isHidden=false
                        
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
    
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    
    
    var ary:NSArray!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 78
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tabcell = tableView.dequeueReusableCell(withIdentifier: "crdcl") as! BookCell
        
        let dict = ary[indexPath.row] as! NSDictionary
        
        //tabcell.bankname.text = dict["name"] as? String
        tabcell.payment.text = "Expiration Date : \(dict["month"]!)" + "/" + "\(dict["year"]!)"
        //  tabcell.cardno.text = dict["card_number"] as? String
        
        
        let card_number = "\(dict["card_no"]!)"
        
        let card_type = "\(dict["card_brand"]!)"
        
        tabcell.ser_name.text=card_type.uppercased()
        
//        if card_type=="Visa"  {
//            tabcell.cardtype.image=UIImage (named: "visa.png")
//        }
//        else if card_type=="MasterCard"  {
//            tabcell.cardtype.image=UIImage (named: "mastercard.png")
//        }
//        else if card_type=="American Express"  {
//            tabcell.cardtype.image=UIImage (named: "american-express.png")
//        }
//        else
//        {
//            tabcell.cardtype.image=UIImage (named: "")
//        }
        
        let des_obj = Design()
        des_obj.round_corner(my_view: tabcell.edit_view, value: 6)
        
        if card_number != "" {
            tabcell.book_id.text = cardnumber(card_number: card_number)
        }
        else
        {
            tabcell.book_id.text = "XXXX - XXXX - XXXX - XXXX"
        }
        
        tabcell.btn_edit.tag = indexPath.row
        tabcell.btn_edit.addTarget(self, action: #selector(self.deletecard(sender:)), for: .touchUpInside)
        
        return tabcell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = ary[indexPath.row] as! NSDictionary
        card_no = "\(dict["card_no"]!)"
        ccExpiryMonth = "\(dict["month"]!)"
        ccExpiryYear = "\(dict["year"]!)"
        name_oncard = "\(dict["name"]!)"
        
        let alertController = UIAlertController(title: "", message: "Add cvv number", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            // do something with textField
            
            textField.placeholder = "CVV"
            
            self.cvvNumber = textField.text!
            
            
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            //textField.placeholder = "Search"
            textField.placeholder = "CVV"
            
            //self.cvvNumber = textField.text!
            
            print("---\(self.cvvNumber!)")
        })
        self.present(alertController, animated: true, completion: nil)
        
        print(card_no,
              ccExpiryMonth,
              ccExpiryYear,
              cvvNumber)
        
    }
    
    func createtable()
    {
        
        tbl.frame=CGRect (x: tbl.frame.origin.x, y: tbl.frame.origin.y, width: tbl.frame.size.width, height: CGFloat(ary.count)*78)
       
        last_view.frame=CGRect (x: last_view.frame.origin.x, y: tbl.frame.origin.y+tbl.frame.size.height, width: last_view.frame.size.width, height: last_view.frame.size.height)
        scroll.contentSize=CGSize (width: 0, height: last_view.frame.origin.y+last_view.frame.size.height)
    }
    
    //MARK: CARDNUMBER
    
    func cardnumber(card_number:String)->String
    {
        //        let index1 = card_number.index(card_number.startIndex, offsetBy: 2)
        //        print(String(card_number.prefix(upTo: index1)))
        //
        //        let index2 = card_number.index(card_number.startIndex, offsetBy: 12)
        //        print(String(card_number.suffix(from: index2)))
        
        var str:String!
        
        if card_number.count==16 {
            let index1 = card_number.index(card_number.startIndex, offsetBy: 2)
            print(String(card_number.prefix(upTo: index1)))
            
            let index2 = card_number.index(card_number.startIndex, offsetBy: 12)
            print(String(card_number.suffix(from: index2)))
            str = "\(String(card_number.prefix(upTo: index1)))" + "XX - XXXX - XXXX" + " - \(String(card_number.suffix(from: index2)))"
        }
        else
        {
            let index1 = card_number.index(card_number.startIndex, offsetBy: 2)
            print(String(card_number.prefix(upTo: index1)))
            
            let index2 = card_number.index(card_number.startIndex, offsetBy: 11)
            print(String(card_number.suffix(from: index2)))
            str = "\(String(card_number.prefix(upTo: index1)))" + "XX - XXXXXX - X" + "\(String(card_number.suffix(from: index2)))"
        }
        return str
    }
    
    @IBAction func deletecard(sender:UIButton)
    {
        let dict = ary[sender.tag] as! NSDictionary
       // let ser_id = dict["id"] as! Int
        let ser_id1 = "\(dict["id"]!)"
        let ser_id = (ser_id1 as  NSString).integerValue
        
        
        let alert = UIAlertController (title: "Message", message: "Do You Want to Delete This Card?", preferredStyle: .alert)
        alert.addAction(UIAlertAction (title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction (title: "Delete", style: .destructive, handler: {alert in
            SVProgressHUD.show(withStatus: "Deleting Card...")
            self.loaddelete(str_id: String(ser_id))}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func loaddelete(str_id:String)
    {
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        //address=kolkata&city=kolkata&state=wb&country=india&postal_code=700102&service_id=7
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        let params: Parameters = [Parameter.card_id: str_id
        ]
        
        
        Alamofire.request(Webservice.delete_card, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                        AppManager().AlertUser("Message", message: msg, vc: self)
                        SVProgressHUD.dismiss()
                        SVProgressHUD.show()
                        self.loadcard()
                        
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
    func loadcard() {
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        //        let params: Parameters = [Parameter.password: new_pass.text!,
        //
        //
        //                                  Parameter.confirm_password: con_pass.text!
        //            ,
        //                                  Parameter.old_password: OLD_PASS.text!
        //
        //        ]
        //
        
        Alamofire.request(Urls.view_card, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            
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
                        //  payment_accounts
                        let payment_accounts  = dict["data"] as! NSDictionary
                        
                        self.ary = payment_accounts["payment_accounts"] as!  NSArray
                        
                        
                        self.tbl.dataSource = self
                        self.tbl.reloadData()
                        self.createtable()
                        SVProgressHUD.dismiss()
                        
                    }
                    else
                    {
                        //AppManager().AlertUser("Message", message: msg, vc: self)
                        self.ary = []
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
    
    
    func loaddpay()
    {
        
        
        let currentDateTime = Date()
        
        print(currentDateTime)
        
        let format1 = DateFormatter()
        format1.dateFormat="yyyy-MM-dd HH:mm:ss z"
        let date1 = format1.date(from: "\(currentDateTime)")
        let format2 = DateFormatter()
        format2.dateFormat="yyyy-MM-dd HH:mm:ss"
        let str_result = format2.string(from: date1!)
        
        print(str_result)
        
        let token = UserDefaults.standard.object(forKey: "token")
        
        print(token)
        
        //address=kolkata&city=kolkata&state=wb&country=india&postal_code=700102&service_id=7
        
        let headers: HTTPHeaders = [
            "token": token as! String,
            
            ]
        
        
        
        
        let params: Parameters = [Parameter.card_no: card_no!,
                                  Parameter.month: ccExpiryMonth!,
                                  Parameter.year: ccExpiryYear!,
                                  Parameter.customer_name: name_oncard!,
                                  Parameter.cvv: cvvNumber!,
                                  Parameter.order_id: order_id!,
                                  "payment_time": str_result,
            
            
            
        ]
        
        
        print("---ggggg-\(params)------hghghgh-\(Webservice.pay_using_card)")
        
        Alamofire.request(Webservice.pay_using_card, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
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
                        
                      //  let alert = UIAlertController(title: "",message: msg,preferredStyle:.alert)
                        let alert = UIAlertController(title: "",message: "payment successful",preferredStyle:.alert)

                        alert.addAction(UIAlertAction (title:"OK", style: .cancel, handler: {
                            
                            alert in self.pushback()
                            
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                       
                        SVProgressHUD.dismiss()
                        
                        
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
    
    func pushback()
    {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
        self.navigationController?.pushViewController(obj, animated: false)
    }
    
    func loadadminacc()
    {
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
//        let headers: HTTPHeaders = [
//            "token": token as! String,
//
//            ]
//
//
//        let params: Parameters = [Parameter.order_id: order_id]
        
        
        Alamofire.request(Webservice.admin_paypal_details, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            
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
                        let admin_ary = dict1["admin_payment_details"] as! NSArray
                        
                        let admin_data = admin_ary[0] as! NSDictionary
                        
                        self.admin_email = "\(admin_data["account_email"]!)"
                        
                        let percentage_ary = dict1["admin_percentages"] as! NSArray
                        
                        let percentage_data = percentage_ary[0] as! NSDictionary
                        
                        self.percentage = "\(percentage_data["percentage"]!)"
                        
                        //SVProgressHUD.dismiss()
                        
                        //SVProgressHUD.show()
                        self.loadlandscaperacc()
                        
                        
                        
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
    
    func loadlandscaperacc()
    {
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
        //        let headers: HTTPHeaders = [
        //            "token": token as! String,
        //
        //            ]
        //
        
                let params: Parameters = [Parameter.landscaper_id: landscaper_id!]
        
        
        Alamofire.request(Webservice.landscaper_paypal_details, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            
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
                        let admin_ary = dict1["payment_accounts"] as! NSArray
                        
                        let admin_data = admin_ary[0] as! NSDictionary
                        
                        self.landscaper_email = "\(admin_data["account_email"]!)"
                        
                        print(self.admin_email)
                        print(self.percentage)
                        print(self.landscaper_email)
                        
                        
                        
                        
//                        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sm") as! SendMoney
//
//                        popOverVC.str_adminemailid=self.admin_email
//
//                        popOverVC.str_percentage=self.percentage
//
//                        popOverVC.str_landscaperemailid=self.landscaper_email
//
//                        popOverVC.str_price=self.total_amount
//
//                        popOverVC.order_id=self.order_id!
//
//                        popOverVC.order_no=self.order_no!
//
//                        self.addChildViewController(popOverVC)
//                        popOverVC.view.frame = self.view.frame
//                        self.view.addSubview(popOverVC.view)
//                        popOverVC.didMove(toParentViewController: self)
                        
                        
                        self.paypal()
                        
                    //    SVProgressHUD.dismiss()
                        
                        
                        
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
    
    
    func paypal()  {
        let token = UserDefaults.standard.object(forKey: "token")
        
        // print(token)
        
//        Username: info_api1.seazoned.com
//        Password: FWVRDFLQYACNVL9Z
//        Signature:
//        ArrtUvgPwlEBUA7Ks.xJQYk3p3J7AimiArq18xUp3DkUK8d3-AlRCU.D

        
//                let headers: HTTPHeaders = [
//                    "X-PAYPAL-SECURITY-USERID" :"4mldev.net-facilitator_api1.gmail.com",
//                    "X-PAYPAL-SECURITY-PASSWORD": "BH8C8836RTHPM3N6",
//                    "X-PAYPAL-SECURITY-SIGNATURE": "AuFtEVPCyBpm5uxOZkKLUrZ9mJewAY.WC9QJ6C33G.74LmpmmGQmrGJJ",
//                    "X-PAYPAL-REQUEST-DATA-FORMAT": "JSON",
//                    "X-PAYPAL-RESPONSE-DATA-FORMAT":"JSON",
//                    "X-PAYPAL-APPLICATION-ID":"APP-80W284485P519543T"
//
//                    ]
        
        let headers: HTTPHeaders = [
            "X-PAYPAL-SECURITY-USERID" :"info_api1.seazoned.com",
            "X-PAYPAL-SECURITY-PASSWORD": "FWVRDFLQYACNVL9Z",
            "X-PAYPAL-SECURITY-SIGNATURE": "ArrtUvgPwlEBUA7Ks.xJQYk3p3J7AimiArq18xUp3DkUK8d3-AlRCU.D",
            "X-PAYPAL-REQUEST-DATA-FORMAT": "JSON",
            "X-PAYPAL-RESPONSE-DATA-FORMAT":"JSON",
            "X-PAYPAL-APPLICATION-ID":"APP-09F61578JD2993335"
            
        ]
        
        let dic1 : NSDictionary = ["errorLanguage": ""]
        
        
         let tm =    Float(self.total_amount)
        
        let per = Float(self.percentage)
        
        
        let value = tm! * per! / 100
        
        let value1 =    String(format: "%.2f", value)
        
        let land_amt = tm! - value
        
         let land_amt2 =  String(format: "%.2f", land_amt)
        
        
        
        let dic2 : NSDictionary = ["amount": value1,"email":self.admin_email]       //admin
        
         let dic3 : NSDictionary = ["amount": land_amt2,"email":self.landscaper_email]   //Landscaper
        
        
        let ary : Array = [dic2,dic3]
        
        let dic4 : NSDictionary = ["receiver": ary]
        
        let params: Parameters = ["actionType": "PAY","currencyCode": "USD","requestEnvelope": dic1,"returnUrl":"http://seazoned.com/APP_HTML/transaction.html","cancelUrl":"http://seazoned.com/APP_HTML/transactiondeciline.html","receiverList":dic4]
        
        print("yui----\(params)")
    //    let url = "https://svcs.sandbox.paypal.com/AdaptivePayments/Pay"
          let url = "https://svcs.paypal.com/AdaptivePayments/Pay"
       // https://svcs.paypal.com/AdaptivePayments/Pay
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
            .responseJSON { response in
                //debugPrint(response.data)
                
                switch(response.result){
                case .success(_):
                    let result = response.result
                    
                    let dict = result.value as! NSDictionary
                    
                    print("-----gttt-----\(dict)")
                    
                    
                 //   let paypal_url =  "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey=\(dict.object(forKey: "payKey")!)"
                //
                    
                    let paypal_url =  "https://www.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey=\(dict.object(forKey: "payKey")!)"
                    
                    
                 //   https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey=AP-9HN42898P2974280X
                    
                    
                   // let succ = dict["responseEnvelope"] as! String
                    
                   // let msg = dict["msg"] as! String
                    
                   // if succ== ""
                 //   {
//                        let dict1 = dict["data"] as! NSDictionary
//                        let admin_ary = dict1["payment_accounts"] as! NSArray
//
//                        let admin_data = admin_ary[0] as! NSDictionary
//
//                        self.landscaper_email = "\(admin_data["account_email"]!)"
//
//                        print(self.admin_email)
//                        print(self.percentage)
//                        print(self.landscaper_email)
                    
                    
                    let mmm =   "\(dict.object(forKey: "payKey")!)"
                    
                                   let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "paymobile") as! paymobile
                    
                                    popOverVC.str_link = paypal_url
                    
                                        popOverVC.pay_key =  mmm
                    
                                            popOverVC.admin_email=self.admin_email
                    
                                            popOverVC.percentage=self.percentage
                    
                                            popOverVC.landscaper_email=self.landscaper_email
                    
                                            popOverVC.total_amount=self.total_amount
                    
                                            popOverVC.order_id=self.order_id!
                    
                                            popOverVC.order_no=self.order_no!
                    
                    
                    self.navigationController?.pushViewController(popOverVC, animated: true)
                    
                        
                        
                        //                        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sm") as! SendMoney
                        //
                        //                        popOverVC.str_adminemailid=self.admin_email
                        //
                        //                        popOverVC.str_percentage=self.percentage
                        //
                        //                        popOverVC.str_landscaperemailid=self.landscaper_email
                        //
                        //                        popOverVC.str_price=self.total_amount
                        //
                        //                        popOverVC.order_id=self.order_id!
                        //
                        //                        popOverVC.order_no=self.order_no!
                        //
                        //                        self.addChildViewController(popOverVC)
                        //                        popOverVC.view.frame = self.view.frame
                        //                        self.view.addSubview(popOverVC.view)
                        //                        popOverVC.didMove(toParentViewController: self)
                        
                        SVProgressHUD.dismiss()
                        
                        
                
                    
                    
                    
                    
                    break
                    
                case .failure(_):
                    print("Network Error")
                    SVProgressHUD.dismiss()
                    break
                    
                }
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
