//
//  Design.swift
//  Seazoned
//
//  Created by Student on 01/02/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit

class Design: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func add_border(my_view : UIView, width : CGFloat)
    {
        my_view.layer.borderColor =  UIColor.white.cgColor
        my_view.layer.borderWidth = width;
        
    }
    
    func add_borderwithcolor(my_view : UIView, width : CGFloat ,color:UIColor)
    {
        my_view.layer.borderColor =  color.cgColor
        my_view.layer.borderWidth = width;
        
    }
    
    func button_round(my_view:UIView)
    {
        
        my_view.clipsToBounds=true
        my_view.layer.cornerRadius=my_view.frame.size.height/2
        
    }
    
    func view_round(my_view:UIView)
    {
        
        my_view.clipsToBounds=true
        my_view.layer.cornerRadius=my_view.frame.size.width/2
        
    }
    
    func red_gradient(my_view:UIView)
    {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor (red: 245.0/255.0, green: 36.0/255.0, blue: 65.0/255.0, alpha: 1.0).cgColor, UIColor (red: 251.0/255.0, green: 114.0/255.0, blue: 116.0/255.0, alpha: 1.0).cgColor]
        
        my_view.layer.addSublayer(gradientLayer)
        
        gradientLayer.startPoint = CGPoint (x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint (x: 1.0, y: 0.5)
        
    }
    
    func green_gradient(my_view:UIView)
    {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor (red: 19.0/255.0, green: 192.0/255.0, blue: 155.0/255.0, alpha: 1.0).cgColor, UIColor (red: 0.0/255.0, green: 236.0/255.0, blue: 182.0/255.0, alpha: 1.0).cgColor]
        
        my_view.layer.addSublayer(gradientLayer)
        
        gradientLayer.startPoint = CGPoint (x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint (x: 1.0, y: 0.5)
        
    }
    
    
    //MARK:Drop Shadow
    
    func dropShadow(scale: Bool = true , myview:UIView) {
        myview.layer.masksToBounds = false
        //myview.layer.shadowColor = UIColor (red: 6.0/255.0, green: 177.0/255.0, blue: 138.0/255.0, alpha: 1.0).cgColor
        myview.layer.shadowColor = UIColor.red.cgColor
        myview.layer.shadowOpacity = 0.3
        myview.layer.shadowOffset = CGSize(width: 0, height: 2)
        myview.layer.shadowRadius = 6
        
        myview.layer.shadowPath = UIBezierPath(rect: myview.bounds).cgPath
        myview.layer.shouldRasterize = true
        myview.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    
    func round_corner(my_view:UIView,value:Int)
    {
        my_view.clipsToBounds=true
        my_view.layer.cornerRadius=CGFloat(value)
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
