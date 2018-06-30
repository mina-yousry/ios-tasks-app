//
//  SettingsViewController.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var categoryNameField: UITextField!
    @IBOutlet var colorsPickerView: UIPickerView!
    @IBOutlet var settingsViewModel: SettingsViewModel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    var pickerDataSource = ["Green", "Red", "Yellow", "Blue"];
    var isColorSelected = false
    var addedCategoryName: String!
    var addedCategoryColor: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        if UserDefaults.standard.object(forKey: "tasks_notifications") != nil {
            if UserDefaults.standard.bool(forKey: "tasks_notifications") {
                notificationSwitch.setOn(true, animated: true)
            }else{
                notificationSwitch.setOn(false, animated: true)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        addedCategoryColor = pickerDataSource[row]
        isColorSelected = true
    }
    
    @IBAction func addCategory(_ sender: Any) {
        
        if !isColorSelected {
            addedCategoryColor = pickerDataSource[0]
        }
        if let categoryName = categoryNameField.text {
            addedCategoryName = categoryName
        }else{
            let alert = UIAlertController(title: "Alert", message: "You have to enter a category name", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
            return
        }
        categoryNameField.text = ""
        settingsViewModel.addCategory(name: addedCategoryName, color: addedCategoryColor)
    }
    
    @IBAction func notifswitch(_ sender: Any) {
        if notificationSwitch.isOn{
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(granted,error) in
                if granted {
                    self.showAlert(message: "notifications has been enabled")
                } else {
                    self.showAlert(message: "notifications has been disabled")
                }
            })
            UserDefaults.standard.set(true, forKey: "tasks_notifications")
        }else{
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UserDefaults.standard.set(false, forKey: "tasks_notifications")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.gotoTasksList()
            //alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func gotoTasksList() {
        self.navigationController?.popViewController(animated: true)
    }
}
