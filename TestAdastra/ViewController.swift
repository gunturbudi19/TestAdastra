//
//  ViewController.swift
//  TestAdastra
//
//  Created by Guntur Budi on 02/11/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet var tblToDo: UITableView!
    @IBOutlet var settingsView: UIView!
    @IBOutlet var addToDoView: UIView!
    
    @IBOutlet var dimView: UIView!
    
    @IBOutlet var txNameToDo: UITextField!
    @IBOutlet var txCategoryToDo: UITextField!
    @IBOutlet var txDateToDo: UITextField!
    
    var urls = String()
    var arrayToDo = Array<Any>()
    var arrayCategory = Array<Any>()
    var gradientLayer: CAGradientLayer!
    
    var dictToDo = NSDictionary()
    
    var isKeyboardShown = Bool()
    var categoryActionSchedule = String()
    var indexChanged = Int()
    var hexaToSave = String()
   
    
    override func viewWillAppear(_ animated: Bool) {
       self.checkToDo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formatInputKeyboard()
        self.formatAccessoryKeyboard()
        categoryActionSchedule = "add"
        isKeyboardShown = false
        
        self.registerForKeyboardNotification()
      
    }
    
    func checkToDo(){
        arrayToDo = UserDefaults.standard.value(forKey: Fieldname().toDoName) as? Array<Any> ?? []
        arrayCategory = UserDefaults.standard.value(forKey: Fieldname().colorLibrary) as? Array<Any> ?? []
        if arrayToDo.count == 0 {
            print("No Data")
        }else{
            tblToDo.reloadData()
        }
        
        if arrayCategory.count == 0 {
            arrayCategory = Fieldname().colors as! [Any]
            Sessions().addColorLibrary(array: arrayCategory as NSArray)
        }
        
        print("arrayCategory : \(arrayCategory)")
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToAddCategory"{
            self.isShowSettings(isShow: false)
        }
    }
    
    func formatView(){
        GlobalMethod().formatView(view: addToDoView, setShadow: true)
        GlobalMethod().formatView(view: settingsView, setShadow: true)
    }
    
    func formatAccessoryKeyboard(){
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.barStyle = UIBarStyle.default
        keyboardToolbar.isTranslucent = true
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel , target: self, action: #selector(ViewController.endEditingText))
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(ViewController.endEditingText))
        keyboardToolbar.setItems([cancelButton, flexBarButton, doneBarButton], animated: true)
        

        txCategoryToDo.inputAccessoryView = keyboardToolbar
        txNameToDo.inputAccessoryView = keyboardToolbar
        txDateToDo.inputAccessoryView = keyboardToolbar
    }
    
    @objc func endEditingText(){
        view.endEditing(true)
    }
    
    func checkIsFirst()
    {
        if(UserDefaults.standard.string(forKey: "isFirst") == nil){
            
        }else{
            
        }
        
        
    }
    var datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    var currentDateString = String()
    var pickerCategory = UIPickerView()
    var categoryValues = [String]()

    func formatInputKeyboard(){
        pickerCategory.delegate = self
        dateFormatter.dateFormat = "EEE yyyy-MM-dd"
        
        timeFormatter.dateFormat = "HH"
        _ = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let maxDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        let dateNextDay = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        let jam = "\(timeFormatter.string(from: Date()))"
        var jamInt = Int(jam)!+1
        
        if (jamInt >= 24) {
            if(jamInt == 24){
                jamInt = jamInt-24;
            }else{
                jamInt = jamInt-24+1;
            }
            txDateToDo.text = "\(dateFormatter.string(from: dateNextDay!))"
        }else{
            txDateToDo.text = "\(dateFormatter.string(from: Date()))"
        }

        currentDateString = txDateToDo.text!
     
        
        datePicker.datePickerMode = .date
        datePicker.maximumDate = maxDate
        if(jamInt+1 >= 24){
            datePicker.minimumDate = dateNextDay
        }else{
            datePicker.minimumDate = Date()
        }
        txDateToDo.inputView = datePicker
        
        txCategoryToDo.inputView = pickerCategory
       
        
        
    }

    @IBAction func closeSettingView(_ sender: Any) {
        self.isShowSettings(isShow: false)
    }
    
    @IBAction func closeAddToDoView(_ sender: Any) {
        categoryActionSchedule = "add"
        self.isShowAddToDo(isShow: false, category: categoryActionSchedule, dict: [:])
    }
    
    
    @IBAction func actAdd(_ sender: Any) {
        print("Add Item")
        txNameToDo.text = ""
        txCategoryToDo.text = ""
        categoryActionSchedule = "add"
        self.isShowAddToDo(isShow: true, category: categoryActionSchedule, dict: [:])
    }
    
    @IBAction func actSetting(_ sender: Any) {
        print("Setting")
        self.isShowSettings(isShow: true)
    }
    
    @IBAction func actAddToDo(_ sender: Any) {
        if(txCategoryToDo.text?.count == 0 || txNameToDo.text?.count == 0){
           self.toast(msg: "Please Complete The Data")
        }else {
            let tempDict = [ Fieldname().nameTD : txNameToDo.text ?? "" ,
                             Fieldname().categoryTD : txCategoryToDo.text ?? "" ,
                             Fieldname().dateTD : txDateToDo.text ?? "",
                             Fieldname().hexaTD : hexaToSave] as [String : Any]
            
            if categoryActionSchedule == "add"{
                arrayToDo.append(tempDict)
            }else{
                arrayToDo[indexChanged] = tempDict
               
                print("putCategory")
            }
            
            Sessions().addToDoList(array: arrayToDo)
            self.isShowAddToDo(isShow: false, category: "add", dict: [:])
            self.tblToDo.reloadData()
            
        }
    }
    
    func isShowDimView(isShow:Bool){
        if isShow {
            dimView.isHidden = false
        }else {
            dimView.isHidden = true
        }
        
    }
    
    func isShowAddToDo(isShow: Bool, category : String , dict : NSDictionary){
       
        if category == "add"{
                if isShow {
                    self.addToDoView.center = CGPoint(x: self.view.center.x , y : self.view.center.y)
                    self.addToDoView.alpha = 1
                    
                    self.isShowDimView(isShow: true)
                    self.view.addSubview(self.addToDoView)
                    
                    UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
                        self.addToDoView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
                        self.addToDoView.transform = .identity
                    })
                }else{
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                        self.addToDoView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                    }) { (success) in
                      //  self.isShowDimWithLoading(isDim: false, isLoading: false)
                        self.isShowDimView(isShow: false)
                        self.addToDoView.removeFromSuperview()
                    }
                }
        }else if category == "put" {
            if isShow {
                self.addToDoView.center = CGPoint(x: self.view.center.x , y : self.view.center.y)
                self.addToDoView.alpha = 1
                
                self.isShowDimView(isShow: true)
                txDateToDo.text = dict[Fieldname().dateTD] as? String ?? ""
                txCategoryToDo.text = dict[Fieldname().categoryTD] as? String ?? ""
                
                var tempColors = arrayCategory
                
                for index in 0..<tempColors.count{
                    let tempDictColor = tempColors[index] as! NSDictionary
                    if(tempDictColor["category"] as? String ?? "#FFFFFF" == txCategoryToDo.text){
                        hexaToSave = tempDictColor["hexa"] as! String
                    }
                }
                
                txNameToDo.text = dict[Fieldname().nameTD] as? String ?? ""
                self.view.addSubview(self.addToDoView)
                
                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
                    self.addToDoView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
                    self.addToDoView.transform = .identity
                })
            }else{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                    self.addToDoView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                }) { (success) in
                    //  self.isShowDimWithLoading(isDim: false, isLoading: false)
                    self.isShowDimView(isShow: false)
                    self.addToDoView.removeFromSuperview()
                }
            }
        }
    }
    
    func isShowSettings(isShow: Bool){
        //self.isShowAddToDo(isShow: false)
        
        if isShow {
            self.settingsView.center = CGPoint(x: self.view.center.x , y : self.view.center.y)
            self.settingsView.alpha = 1
            
            self.isShowDimView(isShow: true)
            self.view.addSubview(self.settingsView)
            
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
                self.settingsView.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
                self.settingsView.transform = .identity
            })
        }else{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.settingsView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            }) { (success) in
                self.isShowDimView(isShow: false)
                self.settingsView.removeFromSuperview()
            }
        }
    }

}


extension ViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayToDo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idIdentifier = "cellToDo"
        let cell = tableView.dequeueReusableCell(withIdentifier: idIdentifier,
                                                 for: indexPath) as! TableViewCell
         let dictData = arrayToDo[indexPath.row] as! NSDictionary
        cell.viewBG.layer.addSublayer(self.createGradientLayer(firstColor: .white, secondColor: GlobalMethod().hexStringToUIColor(hex: dictData[Fieldname().hexaTD] as? String ?? "#FFFFFF")))
        

        cell.lblNameToDo.text = dictData[Fieldname().nameTD] as? String ?? ""
        cell.lblDateToDo.text = dictData[Fieldname().dateTD] as? String ?? ""
        cell.lblCategoryToDo.text = dictData[Fieldname().categoryTD] as? String ?? ""
        return cell
    }
    
    
    
    
    func createGradientLayer(firstColor : UIColor , secondColor : UIColor) -> CALayer{
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        return gradientLayer
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(tableView.isEqual(tblToDo)){
            if editingStyle == .delete {
                self.arrayToDo.remove(at: indexPath.row)
                Sessions().addToDoList(array: arrayToDo)
                self.tblToDo.deleteRows(at: [indexPath], with: .automatic)
               
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tblToDo {
            let tempDict = arrayToDo[indexPath.row] as! NSDictionary
            categoryActionSchedule = "put"
            indexChanged = indexPath.row
            self.isShowAddToDo(isShow: true, category: categoryActionSchedule, dict: tempDict)
        }
        
    }
 
    
}


extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayCategory.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        var result = String()
        let tempDictColor = arrayCategory[row] as! NSDictionary
        result  = tempDictColor["category"] as? String ?? ""
        return result
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var result = String()
        let tempDictColor = arrayCategory[row] as! NSDictionary
        result = tempDictColor["category"] as? String ?? ""
        hexaToSave = tempDictColor["hexa"] as? String ?? ""
        txCategoryToDo.text = result
    }
}



extension ViewController: UITextFieldDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let dateOrder = "\(dateFormatter.string(from: datePicker.date))"
        if textField.isEqual(txDateToDo){
            txDateToDo.text = dateOrder
        }
    }
}


extension ViewController{
    
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification , object: nil)
        
        
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if !isKeyboardShown{
                isKeyboardShown = true
                self.view.frame.origin.y -= 100//keyboardSize.height
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if isKeyboardShown{
                isKeyboardShown = false
                self.view.frame.origin.y += 100//keyboardSize.height
            }
        }
    }
    
    func toast(msg:String) {
        let alert = UIAlertController.init(title: "", message: msg, preferredStyle: UIAlertController.Style.alert)
        let continueButton = UIAlertAction.init(title: "Continue", style: UIAlertAction.Style.default, handler:{ action in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(continueButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
