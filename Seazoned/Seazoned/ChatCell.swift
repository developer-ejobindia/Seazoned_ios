//
//  ChatCell.swift
//  Seazoned
//
//  Created by Apple on 02/05/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var book_id: UILabel!
    
    @IBOutlet weak var ser_name: UILabel!
     @IBOutlet weak var re_img: UIImageView!
    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var work_view: UIView!
    
    @IBOutlet weak var online_view: RoundView!
    
    @IBOutlet weak var lbl_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let des_obj = Design()
        des_obj.view_round(my_view: self.work_view)
        //des_obj.red_gradient(my_view: self.work_view)
        
       // self.online_view.layer.borderWidth=2
        
        self.online_view.layer.borderWidth=0.1

        self.online_view.layer.borderColor=UIColor.white.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
