//
//  ViewController.swift
//  cardtable
//
//  Created by Surjava Ghosh on 09/03/18.
//  Copyright © 2018 Surjava Ghosh. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class Cardlist: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ary:NSArray!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 220
    }
    
    
    
    @IBAction func add(_ sender: Any) {
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tabcell = Bundle.main.loadNibNamed("Cardcell", owner: self, options: nil)?.first as! Cardcell
        
        let dict = ary[indexPath.row] as! NSDictionary
        
        tabcell.bankname.text = dict["name"] as? String
        tabcell.expires.text = "\(dict["month"]!)" + "/" + "\(dict["year"]!)"
      //  tabcell.cardno.text = dict["card_number"] as? String
        
        
        let card_number = "\(dict["card_no"]!)"
        
        let card_type = "\(dict["card_brand"]!)"
        
        if card_type=="Visa"  {
            tabcell.cardtype.image=UIImage (named: "visa.png")
        }
        else if card_type=="MasterCard"  {
            tabcell.cardtype.image=UIImage (named: "mastercard.png")
        }
        else if card_type=="American Express"  {
            tabcell.cardtype.image=UIImage (named: "american-express.png")
        }
        else
        {
            tabcell.cardtype.image=UIImage (named: "")
        }
        
        
        if card_number != "" {
            tabcell.cardno.text = cardnumber(card_number: card_number)
        }
        else
        {
            tabcell.cardno.text = "XXXX - XXXX - XXXX - XXXX"
        }
        
        tabcell.btn.tag = indexPath.row
        tabcell.btn.addTarget(self, action: #selector(self.deletecard(sender:)), for: .touchUpInside)
        
        return tabcell
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
      //  let ser_id = dict["id"] as! Int
        
        
        
        let ser_id1 = "\(dict["id"]!)"
         let ser_id = (ser_id1 as  NSString).integerValue
        
        let alert = UIAlertController (title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction (title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction (title: "Edit", style: .default, handler: {alert in
          
            
            
            self.edit_data(value: dict)
            //self.loaddelete(str_id: String(ser_id)
            }))
        alert.addAction(UIAlertAction (title: "Delete", style: .default, handler: {alert in
            SVProgressHUD.show(withStatus: "Delete Card...")
            
            
            
            
            self.loaddelete(str_id: String(ser_id))}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func  edit_data(value:NSDictionary)
  {
    
    print("dict value",value)
    
    let s = UIStoryboard.init(name: "Main", bundle: nil)
    let obj = self.storyboard?.instantiateViewController(withIdentifier: "addcrd") as! Addnewcard
    obj.value = value
    obj.flag = "1"
    

    self.navigationController?.pushViewController(obj, animated: false)
    
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
                        self.loaddata()
                        
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
    
    @IBAction func back(_ sender: Any) {
        
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "h") as? Home
//        let navController = UINavigationController(rootViewController: secondViewController!)
//        //navController.setViewControllers([secondViewController!], animated:true)
//        self.revealViewController().pushFrontViewController(navController, animated: false)
        self.navigationController?.popViewController(animated: true)
    }
      @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var tab1: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true
        
        tab1.dataSource = nil
        
        
        
//        let str = "Hello, world!"
//        let index = str.index(str.startIndex, offsetBy: 4)
//        //print(str[index])
//        print(String(str.suffix(from: index)))
//        print(String(str.prefix(upTo: index)))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show()
        loaddata()
    }
    
    func loaddata() {
        
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
                        
                        
                        self.tab1.dataSource = self
                        self.tab1.reloadData()
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
    
    
}

