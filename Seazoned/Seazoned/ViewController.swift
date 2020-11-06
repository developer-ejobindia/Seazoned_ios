//
//  ViewController.swift
//  Seazoned
//
//  Created by Student on 01/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
   @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var taskProgress:UIProgressView!
    var progressValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.perform(#selector(updateProgress), with: nil, afterDelay: 0.2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.perform(#selector(updateProgress), with: nil, afterDelay: 0.2)
        
        self.navigationController?.isNavigationBarHidden = true

    }
    
    @objc func updateProgress() {
//        progressValue = progressValue + 0.05
//        self.taskProgress.progress = Float(progressValue)
//        if progressValue != 1.0 {
//            self.perform(#selector(updateProgress), with: nil, afterDelay: 0.2)
//        }
        
        
        
        
        
        
        
        
//        if UserDefaults.standard.value(forKey: "session") != nil
//        {
//
//            let str_session = UserDefaults.standard.value(forKey: "session") as! String
//            if str_session=="1"
//            {
//                let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
//                self.navigationController?.pushViewController(obj, animated: false)
//            }
//            else
//            {
//                let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
//                self.navigationController?.pushViewController(obj, animated: false)
//            }
//
//
//        }
//        else
//        {
//            let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
//            self.navigationController?.pushViewController(obj, animated: false)
//        }
//
        
        
        
        
        
        
        
        
        
        checkfbgmail()
        
        
        
        
//        let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
//        self.navigationController?.pushViewController(obj, animated: false)
    }
    
    func checkfbgmail()
    {
        
        
      
                    
                    // self.red_msg.isHidden = false
                    
                    if UserDefaults.standard.value(forKey: "session") != nil
                    {
                        
                        let str_session = UserDefaults.standard.value(forKey: "session") as! String
                        if str_session=="1"
                        {
                            let obj = self.storyboard?.instantiateViewController(withIdentifier: "db") as! Dashboard
                            self.navigationController?.pushViewController(obj, animated: false)
                        }
                        else
                        {
                            let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
                            self.navigationController?.pushViewController(obj, animated: false)
                        }
                        
                        
                    }
                    else
                    {
                        let obj = self.storyboard?.instantiateViewController(withIdentifier: "lg") as! Login
                        self.navigationController?.pushViewController(obj, animated: false)
                    }
                    
                    print("ok")
                    
                 
                    
               
                    
                    
    
                
                
                
                
                
    
            

        
    }
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

