//
//  TermsAndConditionsView.swift
//  custom view
//
//  Created by Apple on 26/09/18.
//  Copyright © 2018 Os4ed. All rights reserved.
//

import UIKit

class TermsAndConditionsView: UIView {
    
    var delegate: TermsAndConditionsDelegate?
    
    var superViewContorller: UIViewController?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var termsAndConditionsButton: UIButton!
    
    var isChecked: Bool = false
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initXibFile()
        self.setupCheckBox()
        self.setupButtonFunctions()
    }
    
    
    
    
    fileprivate func initXibFile() {
        Bundle.main.loadNibNamed("TermsAndConditionsView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
    
    
    fileprivate func setupCheckBox() {
        self.checkBox.layer.borderWidth = 0.5
        self.checkBox.layer.borderColor = UIColor.black.cgColor
        self.checkBox.layer.cornerRadius = 3
    }
    
    
    
    
    
    fileprivate func setupButtonFunctions() {
        self.checkBox.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        self.termsAndConditionsButton.addTarget(self, action: #selector(termsAndConditionsButtonPressed), for: .touchUpInside)
    }
    
    
    
    
    
    @objc fileprivate func checkBoxPressed() {
        isChecked = !isChecked
        
        if isChecked {
            checkBox.setImage(#imageLiteral(resourceName: "checked").withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            checkBox.setImage(nil, for: .normal)
        }
    }
    
    
    
    
    @objc fileprivate func termsAndConditionsButtonPressed() {
        print("WEW")
        
        let s = UIStoryboard(name: "Main", bundle: nil)
        
        let obj = s.instantiateViewController(withIdentifier: "termViewController") as! termViewController
        
        self.superViewContorller?.navigationController?.pushViewController(obj, animated: true)
        
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initXibFile()
        self.setupCheckBox()
        self.setupButtonFunctions()
    }
}
