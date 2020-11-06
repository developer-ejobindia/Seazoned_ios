//
//  AddFavoritePopup.swift
//  Seazoned
//
//  Created by Apple on 11/04/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class AddFavoritePopup: UIViewController {

    @IBOutlet weak var popupview: UIView!
     @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var ok_view: UIView!
    
    @IBOutlet weak var cancel_view: UIView!
    
    var landscaper_id:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        
        
        popupview.clipsToBounds=true
        popupview.layer.cornerRadius=3
        
        let des_obj = Design()
        
        des_obj.button_round(my_view: cancel_view)
        
        des_obj.button_round(my_view: ok_view)
        
        des_obj.green_gradient(my_view: ok_view)
    }

    @IBAction func ok(_ sender: Any) {
        
        loadlike(landscaper_id: landscaper_id!)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
                        
                        self.removeAnimate()
                        
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
