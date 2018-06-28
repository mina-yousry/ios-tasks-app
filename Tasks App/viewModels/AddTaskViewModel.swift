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
}
