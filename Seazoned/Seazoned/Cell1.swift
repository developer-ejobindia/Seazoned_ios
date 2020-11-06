//
//  Cell1.swift
//  swrevealviewswift2
//
//  Created by Student on 13/09/17.
//  Copyright © 2017 os4ed. All rights reserved.
//

import UIKit

class Cell1: UITableViewCell {

    
    
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!
    @IBOutlet var btn12: UIButton!
    @IBOutlet var txtvw: UITextView!

    
    @IBOutlet var imgvw: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.backgroundColor=UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
