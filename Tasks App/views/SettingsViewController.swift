//
//  SettingsViewController.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var categoryNameField: UITextField!
    @IBOutlet var colorsPickerView: UIPickerView!
    @IBOutlet var settingsViewModel: SettingsViewModel!
    
    var pickerDataSource = ["Green", "Red", "Yellow", "Blue"];
    var isColorSelected = false
    var addedCategoryName: String!
    var addedCategoryColor: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
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
}
