//
//  BookCell.swift
//  Seazoned
//
//  Created by Apple on 17/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var book_id: UILabel!
    
    @IBOutlet weak var ser_name: UILabel!
    
    @IBOutlet weak var named: UILabel!
    
    @IBOutlet weak var payment: UILabel!
    
    @IBOutlet weak var work: UILabel!
    
    @IBOutlet weak var imgvw: UIImageView!
    
    @IBOutlet weak var imginfo: UIImageView!
    
    @IBOutlet weak var work_view: RoundView!
    
    @IBOutlet weak var edit_view: UIView!
    
    @IBOutlet weak var btn_edit: UIButton!
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var time: UILabel!
     @IBOutlet weak var red_msg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
