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
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
  
    func setCollectionCellLayout(view: UICollectionView , numOfRow: Int) -> CGSize{
        
        let numberOfCellInRow = numOfRow
        var collectionCellWidth = CGFloat()
        var collectionCellHeight = CGFloat()
        
        var finalWidthWithPadding = CGFloat()
        var finalHeightWithPadding = CGFloat()
        
        
        collectionCellWidth = view.frame.size.width/CGFloat(numberOfCellInRow)
        collectionCellHeight = collectionCellWidth/2
        finalWidthWithPadding = collectionCellWidth
        finalHeightWithPadding = collectionCellHeight
        
     
        
        return CGSize(width: finalWidthWithPadding, height: finalHeightWithPadding)
        
    }
}
