//
//  RoundView.swift
//  Seazoned
//
//  Created by Apple on 17/03/18.
//  Copyright © 2018 Seazoned.com. All rights reserved.
//

import UIKit

class RoundView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.clipsToBounds=true
        self.layer.cornerRadius=self.frame.size.width/2
        
    }
    
    
    

}
