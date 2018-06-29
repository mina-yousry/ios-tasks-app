//
//  TaskDetailsViewController.swift
//  Tasks App
//
//  Created by Admin on 6/29/18.
//  Copyright © 2018 dp. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {
    
    var selectedTask: ToDoTask!
    @IBOutlet var taskTitleLbl: UILabel!
    @IBOutlet var taskCategoryLbl: UILabel!
    @IBOutlet var taskStatusLbl: UILabel!
    @IBOutlet var taskDate: UILabel!
    @IBOutlet var addTaskViewModel: AddTaskViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Task Details"
        
        let editBtn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(gotoEditScreen))
        self.navigationItem.rightBarButtonItem  = editBtn
        
        taskTitleLbl.text = selectedTask?.title
        taskCategoryLbl.text = selectedTask?.taskCategory?.name
        taskDate.text = convertDate(date: (selectedTask?.completionDate)!)
        switch selectedTask?.status {
        case 0:
            taskStatusLbl.text = "Not Done"
        case 1:
            taskStatusLbl.text = "Done"
        default:
            taskStatusLbl.text = "Not Done"
        }
    }
    
    @IBAction func markAsDone(_ sender: Any){
        selectedTask.status = 1
        addTaskViewModel.updateTask(task: selectedTask, completion: {
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    @IBAction func deleteTask(_ sender: Any){
        addTaskViewModel.deleteTask(task: selectedTask, completion: {
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    func convertDate(date: NSDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy  HH:mm"
        let myString = formatter.string(from: date as Date)
        return myString
    }
    
    @objc func gotoEditScreen() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "addTask") as! AddTaskViewController
        nextViewController.editedTask = selectedTask
        self.show(nextViewController, sender: self)
    }
}
