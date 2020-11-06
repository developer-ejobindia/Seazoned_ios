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

import WebKit
class paymobile: UIViewController,UITableViewDelegate, WKNavigationDelegate,UIWebViewDelegate  {
    @IBOutlet weak var webview: UIWebView!
    
   
    var str_link : String = ""
    var admin_email:String!
    var percentage:String!
    var landscaper_email:String!
    var total_amount:String!
    var order_id:String!
var pay_key:String!
    var landscaper_id:String!
    
    var order_no:String!
    
    @IBOutlet weak var lower_view: UIView!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var nodata: UILabel!
    var isexpand: Bool!
    var indexPathForTable: Int?

    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var bell_view: UIView!
    var expandedLabel: UITextView!
    
    var indexOfCellToExpand: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   //     self.tbl.isHidden = true
   
    
  indexOfCellToExpand = -1
         SVProgressHUD.show()
        
        self.perform(#selector(loadweb), with: self, afterDelay: 0.5)
      

        
        print(self.view.frame.size.height)
        // Do any additional setup after loading the view.
        
        let des_obj = Design()
        des_obj.round_corner(my_view: lower_view,value: 6)
        des_obj.view_round(my_view: bell_view)
        
    }
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //if navigationType == UIWebViewNavigationType.linkClicked {
          //  UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)

           // return false
        //}
        
        print(request.url!)
        
        let uuu = "\(request.url!)"
        if uuu == "http://seazoned.com/APP_HTML/transaction.html"
        {
            
            print("ok")
            
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sm") as! SendMoney
            
            popOverVC.str_adminemailid=self.admin_email
            popOverVC.str_KEY = self.pay_key
            popOverVC.str_percentage=self.percentage
            
            popOverVC.str_landscaperemailid=self.landscaper_email
            
            popOverVC.str_price=self.total_amount
            
            popOverVC.order_id=self.order_id!
            
            popOverVC.order_no=self.order_no!
            
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            
        }
        
        else if uuu == "http://seazoned.com/APP_HTML/transactiondeciline.html"
        {
              print("cancel")
            
            
//                                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sm") as! SendMoney
//
//                                    popOverVC.str_adminemailid=self.admin_email
//                                    popOverVC.str_KEY = self.pay_key
//                                    popOverVC.str_percentage=self.percentage
//
//                                    popOverVC.str_landscaperemailid=self.landscaper_email
//
//                                    popOverVC.str_price=self.total_amount
//
//                                    popOverVC.order_id=self.order_id!
//
//                                    popOverVC.order_no=self.order_no!
//
//                                    self.addChildViewController(popOverVC)
//                                    popOverVC.view.frame = self.view.frame
//                                    self.view.addSubview(popOverVC.view)
//                                    popOverVC.didMove(toParentViewController: self)
            
            
            
            
        }
        else
        
        {
             print("holo nah")
            
            
            
        }
        
       
        
        return true
    }
    @objc func loadweb()
    {
        
       
        let url = URL(string: str_link)!
        
        let req1 = URLRequest.init(url: url)
     webview.loadRequest(req1)
        
        
    }
    
  func webViewDidFinishLoad(_ webView: UIWebView)
    {
        
        SVProgressHUD.dismiss()
        
    }

    var ary : NSArray!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ary.count
    }
    
 
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  self.view.frame.size.height == 568
            
        {
            
            if indexPath.row == indexOfCellToExpand
            {
                return 60 + expandedLabel.frame.height + 280
            }
            
        }
            
        else if  self.view.frame.size.height == 667
            
        {
            
            if indexPath.row == indexOfCellToExpand
            {
                return 60 + expandedLabel.frame.height + 370
            }
            
        }
        else if  self.view.frame.size.height == 736
            
        {
            
            if indexPath.row == indexOfCellToExpand
            {
                return 60 + expandedLabel.frame.height + 480
            }
            
        }
        
        else if  self.view.frame.size.height == 812
            
        {
            
            if indexPath.row == indexOfCellToExpand
            {
                return 60 + expandedLabel.frame.height + 200
            }
            
        }
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        indexPathForTable = indexPath.row
        print("dggfgfgf")
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

       
        
       
       // loaddata()
        
    }
    
    func loaddata() {
        
     
    }
    
    
    
    //MARK: Tabbar
    
    @IBAction func tabbar(_ sender: UIButton) {
        
        //Help
        if sender.tag==0 {
            
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "faq") as! faq
            self.navigationController?.pushViewController(obj, animated: false)
            print("hhghg")
            
        }
            //Message
        else if sender.tag==1 {
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "clst") as! Chatlist
//            self.navigationController?.pushViewController(obj, animated: false)
            
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
    
    //MARK: Expand Table
    
    
    func expandCell(sender: UITapGestureRecognizer)
    {
        
       
            
      
    }
}
