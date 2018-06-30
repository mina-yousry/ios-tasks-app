//
//  TasksListViewModel.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit
import CoreData

class TasksListViewModel: NSObject,AlertProtocol {
    
    @IBOutlet var tasksFetcher: TasksFetcher! //tasks handler that deals with core data

    var doneTasks = [ToDoTask]()
    var notDoneTasks = [ToDoTask]()
    var alertHandler: AlertProtocol!
    
    //fetch tasks to send it to tasks table view
    func fetchTasks(completion: ()->()) {
        tasksFetcher.fetchNotDoneTasks(completion: { tasksNotDone in
            self.notDoneTasks = tasksNotDone
            self.tasksFetcher.fetchDoneTasks(completion: {tasksDone in
                self.doneTasks = tasksDone
                completion()
            })
        })
    }
    
    //return number of rows depending on the section
    func numberOfRowsForSection(section: Int) -> Int {
        switch section {
        case 0:
            return notDoneTasks.count
        case 1:
            return doneTasks.count
        default:
            return 0
        }
    }
    
    //return a task depending on table view row
    func taskAtIndex(indexPath: IndexPath) -> ToDoTask {
        switch indexPath.section {
        case 0:
            return notDoneTasks[indexPath.row]
        case 1:
            return doneTasks[indexPath.row]
        default:
            return notDoneTasks[indexPath.row]
        }
    }
    
    //delete a specific task
    func deleteTask(indexPath: IndexPath,completion: ()->()) {
        var deletedTask = ToDoTask()
        switch indexPath.section {
        case 0:
            deletedTask = notDoneTasks[indexPath.row]
            notDoneTasks.remove(at: indexPath.row)
        case 1:
            deletedTask = doneTasks[indexPath.row]
            doneTasks.remove(at: indexPath.row)
        default:
            deletedTask = notDoneTasks[indexPath.row]
            notDoneTasks.remove(at: indexPath.row)
        }
        tasksFetcher.deleteTask(task: deletedTask)
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
