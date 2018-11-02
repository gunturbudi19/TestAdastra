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
    var gradientLayer: CAGradientLayer!
    
    var dictToDo = NSDictionary()
    
    var isKeyboardShown = Bool()
    
    
    override func viewWillAppear(_ animated: Bool) {
       // self.checkToDo()
    }
    
    override func viewDidLoad() {
        //commit
        super.viewDidLoad()
        self.formatInputKeyboard()
        self.formatAccessoryKeyboard()
        self.checkToDo()
        isKeyboardShown = false
        self.registerForKeyboardNotification()
      
    }
    
    func checkToDo(){
        arrayToDo = UserDefaults.standard.value(forKey: Fieldname().toDoName) as? Array<Any> ?? []
        print(arrayToDo)
        if arrayToDo.count == 0 {
            print("No Data")
        }else{
            tblToDo.reloadData()
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
//    var listTimeInput = [Int]()
//    var timePickerView = UIPickerView()
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    var currentDateString = String()
//    var currentTimeString = String()
    
    func formatInputKeyboard(){
      //  timePickerView.delegate = self
      //  timePickerView.tag=2
        
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
        
       // txTime.text = "\(jamInt):00"
        
        currentDateString = txDateToDo.text!
       // currentTimeString = txTime.text!
        
        
        datePicker.datePickerMode = .date
        datePicker.maximumDate = maxDate
        if(jamInt+1 >= 24){
            datePicker.minimumDate = dateNextDay
        }else{
            datePicker.minimumDate = Date()
        }
        txDateToDo.inputView = datePicker
        
        
    }

    @IBAction func closeSettingView(_ sender: Any) {
        self.isShowSettings(isShow: false)
    }
    
    @IBAction func closeAddToDoView(_ sender: Any) {
        self.isShowAddToDo(isShow: false)
    }
    
    
    @IBAction func actAdd(_ sender: Any) {
        print("Add Item")
        txNameToDo.text = ""
        txCategoryToDo.text = ""
        self.isShowAddToDo(isShow: true)
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
                             Fieldname().dateTD : txDateToDo.text ?? ""] as [String : Any]
            arrayToDo.append(tempDict)
            Sessions().addToDoList(array: arrayToDo)
            self.isShowAddToDo(isShow: false)
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
    
    func isShowAddToDo(isShow: Bool){
       
        
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
                //  self.isShowDimWithLoading(isDim: false, isLoading: false)
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
        print("dictData : \(dictData)")
       // cell.contentView.layer.addSublayer(self.createGradientLayer(firstColor: .white, secondColor: .yellow))
        if(fmod(Double(indexPath.row), 2) == 0){
        cell.viewBG.layer.addSublayer(self.createGradientLayer(firstColor: .white, secondColor: .yellow))
        }else {
        cell.viewBG.layer.addSublayer(self.createGradientLayer(firstColor: .white, secondColor: .red))
        }
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
    
    /*
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
     return 100
     }
     */
    
}


extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var result = Int()
       
//        if pickerView == timePickerView {
//            result = listTimeInput.count
//        }
        
        return Fieldname().setColors.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        var result = String()

//        if pickerView == timePickerView {
//            result = String("\(listTimeInput[row]):00")
//        }
        result  = Fieldname().setColors[row]
        return result
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
      
    }
}



// Format TextView
extension ViewController: UITextFieldDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Begin Editing")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let dateOrder = "\(dateFormatter.string(from: datePicker.date))"
        print(dateOrder)
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
            //print("notification: Keyboard will show || with keyboard height : \(keyboardSize.height)")
            // if self.view.frame.origin.y == 0{
            if !isKeyboardShown{
                isKeyboardShown = true
                self.view.frame.origin.y -= 100//keyboardSize.height
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            // print("notification: Keyboard will hide || with keyboard height : \(keyboardSize.height)")
            // if self.view.frame.origin.y != 0 {
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
