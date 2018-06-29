//
//  TasksFetcher.swift
//  Tasks App
//
//  Created by Admin on 6/29/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit
import CoreData

class TasksFetcher: NSObject {
    
    func fetchNotDoneTasks(completion: ([ToDoTask])->()) {
        let fetchTasksRequest: NSFetchRequest<ToDoTask> = ToDoTask.fetchRequest()
        let notDonePredict = NSPredicate(format: "status == %d", 0)
        fetchTasksRequest.predicate = notDonePredict
        do{
            let fetchedTasks = try PersistenceUtility.context.fetch(fetchTasksRequest)
            completion(fetchedTasks)
        }catch{
            
        }
    }
    
    func fetchDoneTasks(completion: ([ToDoTask])->()) {
        let fetchTasksRequest: NSFetchRequest<ToDoTask> = ToDoTask.fetchRequest()
        let notDonePredict = NSPredicate(format: "status == %d", 1)
        fetchTasksRequest.predicate = notDonePredict
        do{
            let fetchedTasks = try PersistenceUtility.context.fetch(fetchTasksRequest)
            completion(fetchedTasks)
        }catch{
            
        }
    }
    
    func fetchTask(ForTitle title: String,AndCtegory category: TaskCategory,completion: (ToDoTask)->()) {
        let fetchTasksRequest: NSFetchRequest<ToDoTask> = ToDoTask.fetchRequest()
        let specificTaskPredict = NSPredicate(format: "title == %@ AND taskCategory == %@", title,category)
        fetchTasksRequest.predicate = specificTaskPredict
        do{
            let fetchedTasks = try PersistenceUtility.context.fetch(fetchTasksRequest)
            if fetchedTasks.count != 0 {
                completion(fetchedTasks[0])
            }
        }catch{
            
        }
    }
    
    func updateTask(task: ToDoTask) {
        let fetchTasksRequest: NSFetchRequest<ToDoTask> = ToDoTask.fetchRequest()
        let specificTaskPredict = NSPredicate(format: "title == %@ AND taskCategory == %@", task.title!,task.taskCategory!)
        fetchTasksRequest.predicate = specificTaskPredict
        do{
            let managedObjectContext = PersistenceUtility.context
            let fetchedTasks = try managedObjectContext.fetch(fetchTasksRequest)
            if fetchedTasks.count != 0 {
                print("fetched task title\(String(describing: fetchedTasks[0].completionDate))")
                fetchedTasks[0].setValue(task.title!, forKey: "title")
                fetchedTasks[0].setValue(task.completionDate!, forKey: "completionDate")
                fetchedTasks[0].setValue(task.status, forKey: "status")
                fetchedTasks[0].setValue(task.taskCategory!, forKey: "taskCategory")
                do{
                    try managedObjectContext.save()
                }catch{
                    print(error)
                }
            }
        }catch{
            print(error)
        }
    }
    
}
