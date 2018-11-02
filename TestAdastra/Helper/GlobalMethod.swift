//
//  GlobalMethod.swift
//  TestAdastra
//
//  Created by Guntur Budi on 02/11/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class GlobalMethod: NSObject {
    
    func formatView (view:UIView, setShadow:Bool) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        
        if(setShadow){
            self.setShadow(view: view)
        }
        
        view.setNeedsUpdateConstraints()
    }
    
    func setShadow(view:UIView){
        view.layer.shadowColor = UIColor.darkText.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize(width: 1.5, height: -1)
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
        view.layer.shadowPath = UIBezierPath(rect: CGRect(x: view.bounds.origin.x+2, y: view.bounds.origin.y+5.0, width: view.bounds.width, height: view.bounds.height)).cgPath
    }
  
}
