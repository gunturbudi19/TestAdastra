//
//  RoundCornerView.swift
//  TestAdastra
//
//  Created by Guntur Budi on 02/11/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

@IBDesignable
class RoundCornerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var cornerRadius:CGFloat = 30{
        didSet{
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    
    func setupView(){
        layer.cornerRadius = 20
        
        layer.shadowColor = UIColor.darkText.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0.75, height: -0.75)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(rect: CGRect(x: self.bounds.origin.x+2, y: self.bounds.origin.y+5.0, width: self.bounds.width, height: self.bounds.height)).cgPath
    }

}
