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
    @IBOutlet var taskDatePicker: UIDatePicker!
    @IBOutlet var titleField: UITextField!
    
    var isCategoryPicked = false
    var taskCategory = TaskCategory()
    var taskDate: NSDate!
    var taskTitle: String!
    
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        taskCategory = addTaskViewModel.categoryAtIndex(index: row)
        isCategoryPicked = true
    }
    
    @IBAction func addTask(_ sender: Any) {
        
        if let taskTitle = titleField.text {
            self.taskTitle = taskTitle
        }else{
            let alert = UIAlertController(title: "Alert", message: "You have to enter a task title", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
            return
        }
        if !isCategoryPicked {
            taskCategory = addTaskViewModel.categoryAtIndex(index: 0)
        }
        taskDate = taskDatePicker.date as NSDate
        addTaskViewModel.addTask(title: taskTitle, date: taskDate, category: taskCategory)
        titleField.text = ""
    }
}
