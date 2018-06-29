//
//  TasksListViewController.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit

class TasksListViewController: UITableViewController {
    
    @IBOutlet var tasksListViewModel: TasksListViewModel!
    @IBOutlet var tasksTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasksListViewModel.fetchTasks {
            DispatchQueue.main.async() {
                self.tasksTableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksListViewModel.numberOfRowsForSection(section: section)
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedTask = tasksListViewModel.taskAtIndex(index: indexPath.row)
//        let taskDetailsView = TaskDetailsViewController()
//        taskDetailsView.selectedTask = selectedTask
//        self.performSegue(withIdentifier: "taskDetails", sender: self)
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.taskTitle.text = tasksListViewModel.taskAtIndex(index: indexPath.row).title!
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskDetails" {
            let nextScene =  segue.destination as! TaskDetailsViewController
            if let indexPath = tasksTableView.indexPathForSelectedRow {
                let pressedTask = tasksListViewModel.taskAtIndex(index: indexPath.row)
                nextScene.selectedTask = pressedTask
            }
        }
    }

}
