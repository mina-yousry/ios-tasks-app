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
    
    var alertHandler: AlertProtocol! //used to send alerts
    
    //this method is used to fetch the tasks that are done
    func fetchNotDoneTasks(completion: ([ToDoTask])->()) {
        let fetchTasksRequest: NSFetchRequest<ToDoTask> = ToDoTask.fetchRequest()
        let notDonePredict = NSPredicate(format: "status == %d", 0)
        fetchTasksRequest.predicate = notDonePredict
        do{
            let fetchedTasks = try PersistenceUtility.context.fetch(fetchTasksRequest)
            completion(fetchedTasks)
        }catch{
            alertHandler.showAlert(message: "Error fetching tasks")
        }
    }
    
    //this method is used to fetch the tasks that are not done
    func fetchDoneTasks(completion: ([ToDoTask])->()) {
        let fetchTasksRequest: NSFetchRequest<ToDoTask> = ToDoTask.fetchRequest()
        let notDonePredict = NSPredicate(format: "status == %d", 1)
        fetchTasksRequest.predicate = notDonePredict
        do{
            let fetchedTasks = try PersistenceUtility.context.fetch(fetchTasksRequest)
            completion(fetchedTasks)
        }catch{
            alertHandler.showAlert(message: "Error fetching tasks")
        }
    }
    
    //this method is used to add a task
    func addTask(title: String,date: NSDate,category: TaskCategory) {
        let task = ToDoTask(context: PersistenceUtility.context)
        task.title = title
        task.completionDate = date
        task.taskCategory = category
        task.status = 0
        PersistenceUtility.saveContext()
    }

    //this method is used to fetch a single task
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
            alertHandler.showAlert(message: "Error fetching task")
        }
    }
    
    //this method is used to update a task
    func updateTask(task: ToDoTask) {
        let fetchTasksRequest: NSFetchRequest<ToDoTask> = ToDoTask.fetchRequest()
        let specificTaskPredict = NSPredicate(format: "title == %@ AND taskCategory == %@", task.title!,task.taskCategory!)
        fetchTasksRequest.predicate = specificTaskPredict
        do{
            let managedObjectContext = PersistenceUtility.context
            let fetchedTasks = try managedObjectContext.fetch(fetchTasksRequest)
            if fetchedTasks.count != 0 {
                fetchedTasks[0].setValue(task.title!, forKey: "title")
                fetchedTasks[0].setValue(task.completionDate!, forKey: "completionDate")
                fetchedTasks[0].setValue(task.status, forKey: "status")
                fetchedTasks[0].setValue(task.taskCategory!, forKey: "taskCategory")
                do{
                    try managedObjectContext.save()
                }catch{
                    alertHandler.showAlert(message: "Error updating task")
                }
            }
        }catch{
            alertHandler.showAlert(message: "Error updating task")
        }
    }
    
    //this method is used to delete a task
    func deleteTask(task: ToDoTask) {
        let fetchTasksRequest: NSFetchRequest<ToDoTask> = ToDoTask.fetchRequest()
        let specificTaskPredict = NSPredicate(format: "title == %@ AND taskCategory == %@", task.title!,task.taskCategory!)
        fetchTasksRequest.predicate = specificTaskPredict
        do{
            let managedObjectContext = PersistenceUtility.context
            let fetchedTasks = try managedObjectContext.fetch(fetchTasksRequest)
            if fetchedTasks.count != 0 {
                managedObjectContext.delete(fetchedTasks[0])
            }
        }catch{
            alertHandler.showAlert(message: "Error deleting task")
        }
    }
}
