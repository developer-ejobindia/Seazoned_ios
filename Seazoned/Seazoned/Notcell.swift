//
//  Notcell.swift
//  Seazoned
//
//  Created by Apple on 03/04/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit

class Notcell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var imgvw: UIImageView!
     @IBOutlet weak var red_msg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgvw.clipsToBounds=true
        self.imgvw.layer.cornerRadius=self.imgvw.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
