//
//  TasksListViewController.swift
//  Tasks App
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit

class TasksListViewController: UITableViewController,AlertProtocol {
    
    @IBOutlet var tasksListViewModel: TasksListViewModel!
    @IBOutlet var tasksTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tasksListViewModel.alertHandler = self
        tasksListViewModel.setTaskAlertHAndler()
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Not Done"
        default:
            return "Done"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksListViewModel.numberOfRowsForSection(section: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        let task = tasksListViewModel.taskAtIndex(indexPath: indexPath)
        cell.taskTitle.text = task.title!
        cell.taskDate.text = convertDate(date: task.completionDate!)
        cell.colorImage.layer.cornerRadius = (cell.colorImage.frame.height)/2
        switch task.taskCategory?.color {
        case "Green":
            cell.colorImage.backgroundColor = UIColor.green
        case "Red":
            cell.colorImage.backgroundColor = UIColor.red
        case "Yellow":
            cell.colorImage.backgroundColor = UIColor.yellow
        case "Blue":
            cell.colorImage.backgroundColor = UIColor.blue
        default:
            cell.colorImage.backgroundColor = UIColor.green
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskDetails" {
            let nextScene =  segue.destination as! TaskDetailsViewController
            if let indexPath = tasksTableView.indexPathForSelectedRow {
                let pressedTask = tasksListViewModel.taskAtIndex(indexPath: indexPath)
                nextScene.selectedTask = pressedTask
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let deleteAlert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this task?", preferredStyle: UIAlertControllerStyle.alert)
            deleteAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.tasksListViewModel.deleteTask(indexPath: indexPath, completion: {
                    self.tasksTableView.reloadData()
                })
            }))
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            
            present(deleteAlert, animated: true, completion: nil)
        }
    }
    
    func convertDate(date: NSDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy  HH:mm"
        let myString = formatter.string(from: date as Date)
        return myString
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
