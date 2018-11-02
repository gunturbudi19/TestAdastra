//
//  CategoryVC.swift
//  TestAdastra
//
//  Created by Guntur Budi on 02/11/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {

    var arrayCategory = Array<Any>()
    var arrayOfColours = String()
    
    @IBOutlet var txCategoryName: UITextField!
    @IBOutlet var colorPreview: UIView!
    @IBOutlet var txHexaColor: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formatAccessoryKeyboard()
        self.checkCategory()
        // Do any additional setup after loading the view.
    }
    
    func formatAccessoryKeyboard(){
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.barStyle = UIBarStyle.default
        keyboardToolbar.isTranslucent = true
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel , target: self, action: #selector(CategoryVC.endEditingText))
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(CategoryVC.endEditingText))
        keyboardToolbar.setItems([cancelButton, flexBarButton, doneBarButton], animated: true)
        
        txCategoryName.inputAccessoryView = keyboardToolbar
        txHexaColor.inputAccessoryView = keyboardToolbar
    }
    
    @objc func endEditingText(){
        view.endEditing(true)
    }

    func checkCategory(){
            arrayCategory = UserDefaults.standard.value(forKey: Fieldname().colorLibrary) as? Array<Any> ?? []
            if arrayCategory.count == 0 {
                arrayCategory = Fieldname().colors as! [Any]
                Sessions().addColorLibrary(array: arrayCategory as NSArray)
            }
            
            print("array add Category  : \(arrayCategory)")
            
            
    }
    
    @IBAction func actAddCategory(_ sender: Any) {
        let tempDict = [ "category": txCategoryName.text ?? "" ,
                        "hexa": txHexaColor.text ?? "" ,
                        "name" : "new category"] as [String : Any]
        arrayCategory.append(tempDict)
        Sessions().addColorLibrary(array: arrayCategory as NSArray)
         _ = navigationController?.popViewController(animated: true)
    }

}


extension CategoryVC: UITextFieldDelegate{
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if(textField.tag == 2){
            colorPreview.backgroundColor = (GlobalMethod().hexStringToUIColor(hex: txHexaColor.text ?? "#FFFFFF"))
        }
    }
}
