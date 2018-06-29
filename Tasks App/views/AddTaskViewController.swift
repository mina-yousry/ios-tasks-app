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
    @IBOutlet var addBtn: UIButton!
    
    var isCategoryPicked = false
    var addedTaskCategory = TaskCategory()
    var taskDate: NSDate!
    var taskTitle: String!
    var editedTask: ToDoTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Task"
        addTaskViewModel.fetchCategories {
            self.categoriesPickerView.reloadAllComponents()
        }
        
        if (editedTask) != nil {
            setViews()
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
        addedTaskCategory = addTaskViewModel.categoryAtIndex(index: row)
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
            addedTaskCategory = addTaskViewModel.categoryAtIndex(index: 0)
        }
        
        taskDate = taskDatePicker.date as NSDate
        
        if addBtn.titleLabel?.text == "Save" {
            editedTask.title = taskTitle
            editedTask.completionDate = taskDate
            editedTask.taskCategory = addedTaskCategory
            addTaskViewModel.updateTask(task: editedTask,completion: {
                self.navigationController?.popToRootViewController(animated: true)
            })
        }else{
            addTaskViewModel.addTask(title: taskTitle, date: taskDate, category: addedTaskCategory)
        }
        titleField.text = ""
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func setViews() {
        titleField.text = editedTask.title
        taskDatePicker.date = editedTask.completionDate! as Date
        if let editedTaskCategory = editedTask.taskCategory {
            categoriesPickerView.selectRow(addTaskViewModel.category(category: editedTaskCategory), inComponent: 0, animated: true)
        }
        addBtn.setTitle("Save", for: UIControlState.normal)
        self.title = "Edit Task"
    }
}
