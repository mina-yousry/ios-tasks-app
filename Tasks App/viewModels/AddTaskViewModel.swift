//
//  AddTaskViewModel.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewModel: NSObject {

    var categories = [TaskCategory]()
    
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
        let task = ToDoTask(context: PersistenceUtility.context)
        task.title = title
        task.completionDate = date
        task.taskCategory = category
        task.status = 0
        PersistenceUtility.saveContext()
    }
}
