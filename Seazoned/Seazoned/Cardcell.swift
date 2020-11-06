//
//  cell.swift
//  cardtable
//
//  Created by Surjava Ghosh on 09/03/18.
//  Copyright © 2018 Surjava Ghosh. All rights reserved.
//

import UIKit

class Cardcell: UITableViewCell {

    @IBOutlet weak var bankname: UILabel!
    @IBOutlet weak var chip: UIImageView!
    @IBOutlet weak var cardno: UILabel!
    @IBOutlet weak var expires: UILabel!
    @IBOutlet weak var cardtype: UIImageView!
    @IBOutlet weak var cardview: UIView!
     @IBOutlet weak var red_msg: UIImageView!
    
    @IBOutlet weak var btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardview.layer.cornerRadius =  6
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
