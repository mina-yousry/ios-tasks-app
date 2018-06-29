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
    
    @IBOutlet var tasksFetcher: TasksFetcher!

    var doneTasks = [ToDoTask]()
    var notDoneTasks = [ToDoTask]()
    
    func fetchTasks(completion: ()->()) {
        tasksFetcher.fetchNotDoneTasks(completion: { tasksNotDone in
            self.notDoneTasks = tasksNotDone
            self.tasksFetcher.fetchDoneTasks(completion: {tasksDone in
                self.doneTasks = tasksDone
                completion()
            })
        })
    }
    
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
}
