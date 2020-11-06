//
//  cell.swift
//  collecton
//
//  Created by Surjava Ghosh on 22/02/18.
//  Copyright © 2018 Surjava Ghosh. All rights reserved.
//

import UIKit

class cell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var add: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var users: UILabel!
    
    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var like_img: UIImageView!
    
    @IBOutlet weak var rate_view: UIView!
    
    @IBOutlet weak var like: UIButton!
    
    @IBOutlet weak var whole_view: UIView!
    
    @IBOutlet weak var price: UILabel!
     @IBOutlet weak var red_msg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dropShadow(myview: self.whole_view)
    }
    
    func dropShadow(scale: Bool = true , myview:UIView) {
        myview.layer.masksToBounds = false
        //myview.layer.shadowColor = UIColor (red: 6.0/255.0, green: 177.0/255.0, blue: 138.0/255.0, alpha: 1.0).cgColor
        myview.layer.shadowColor = UIColor.lightGray.cgColor
        myview.layer.shadowOpacity = 0.3
        myview.layer.shadowOffset = CGSize(width: 0, height: 1)
        myview.layer.shadowRadius = 3
        
        myview.layer.shadowPath = UIBezierPath(rect: myview.bounds).cgPath
        myview.layer.shouldRasterize = true
        myview.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

}
