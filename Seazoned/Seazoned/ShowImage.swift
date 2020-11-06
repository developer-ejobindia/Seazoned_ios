//
//  ShowImage.swift
//  Seazoned
//
//  Created by apple on 19/07/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit
import Kingfisher

class ShowImage: UIViewController {
  @IBOutlet weak var red_msg: UIImageView!
    @IBOutlet weak var imgvw: UIImageView!
    var str_img:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        showAnimate()
        
        let tap = UITapGestureRecognizer()
        
        tap.addTarget(self, action: #selector(removeAnimate))
        
        self.view.addGestureRecognizer(tap)
        
        let url = URL(string: str_img)
        imgvw.kf.setImage(with: url)
        
    }

    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    @objc func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
