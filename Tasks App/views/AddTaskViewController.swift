//
//  AddTaskViewController.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//
//Users/admin/Documents/IOS Projects/Tasks App/Tasks App.xcodeproj

import UIKit

class AddTaskViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet var addTaskViewModel: AddTaskViewModel!
    @IBOutlet var categoriesPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Task"
        addTaskViewModel.fetchCategories {
            self.categoriesPickerView.reloadAllComponents()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addTaskViewModel.categoriesNumber()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return addTaskViewModel.categoryNameForRow(row: row)
    }
    
}
