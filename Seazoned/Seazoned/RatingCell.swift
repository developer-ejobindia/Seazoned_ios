//
//  RatingCell.swift
//  Seazoned
//
//  Created by Apple on 26/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit

class RatingCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var rt_date: UILabel!
    @IBOutlet weak var imgvw: UIImageView!
    @IBOutlet var floatRatingView: FloatRatingView!
    
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
