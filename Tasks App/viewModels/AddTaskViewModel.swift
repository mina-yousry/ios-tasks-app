//
//  AddTaskViewModel.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewModel: NSObject,AlertProtocol {

    var categories = [TaskCategory]()
    var alertHandler: AlertProtocol!
    @IBOutlet var tasksFetcher: TasksFetcher!
    
    func categoriesNumber() -> Int{
        return categories.count
    }
    
    func categoryNameForRow(row: Int) -> String {
        return categories[row].name!
    }
    
    func fetchCategories(completion:()->()) {
        let fetchCategoriesRequest: NSFetchRequest<TaskCategory> = TaskCategory.fetchRequest()
        do{
            let fetshedCategories = try PersistenceUtility.context.fetch(fetchCategoriesRequest)
            self.categories = fetshedCategories
            completion()
        }catch{
            
        }
    }
    
    func categoryAtIndex(index: Int) -> TaskCategory {
        return categories[index]
    }
    
    func addTask(title: String,date: NSDate,category: TaskCategory) {
        tasksFetcher.addTask(title: title, date: date, category: category)
    }
    
    func category(category: TaskCategory) -> Int {
        fetchCategories {}
        var index = 0
        for storedCategory in categories {
            if storedCategory == category{
                return index
            }
            index = index + 1
        }
        return 0
    }
    
    func updateTask(task: ToDoTask,completion: ()->()) {
        tasksFetcher.updateTask(task: task)
        completion()
    }
    
    func deleteTask(task: ToDoTask,completion: ()->()) {
        tasksFetcher.deleteTask(task: task)
        completion()
    }
    
    func showAlert(message: String) {
        alertHandler.showAlert(message: message)
    }
    
    //set the alert handler in tasks fetcher to be able to send alerts
    func setTaskAlertHAndler() {
        tasksFetcher.alertHandler = self
    }
}
