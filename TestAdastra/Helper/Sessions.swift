//
//  Sessions.swift
//  TestAdastra
//
//  Created by Guntur Budi on 02/11/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class Sessions: NSObject {
    
    func addToDoList(array: Array<Any>){
        UserDefaults.standard.set(array, forKey: Fieldname().toDoName)
    }
    
    func addColorLibrary(array: NSArray){
         UserDefaults.standard.set(array, forKey: Fieldname().colorLibrary)
    }

    
}
