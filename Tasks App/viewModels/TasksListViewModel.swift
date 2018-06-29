//
//  TasksListViewModel.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit
import CoreData

class TasksListViewModel: NSObject {

    var tasks = [ToDoTask]()
    
    func fetchTasks(completion: ()->()) {
        let fetchTasksRequest: NSFetchRequest<ToDoTask> = ToDoTask.fetchRequest()
        do{
            let fetchedTasks = try PersistenceUtility.context.fetch(fetchTasksRequest)
            self.tasks = fetchedTasks
            completion()
        }catch{
            
        }
    }
    
    func numberOfRowsForSection(section: Int) -> Int {
        return tasks.count
    }
    
    func taskAtIndex(index: Int) -> ToDoTask {
        return tasks[index]
    }
}
