//
//  TaskDataViewController.swift
//  DoToDo
//
//  Created by Whitehouse, Jarret M on 10/25/21.
//

import UIKit
import Firebase

class TaskDetailViewController: UIViewController {
    
    //MARK: Attributes
    var taskID: String = ""
    var task: appTask?
    private var service: TaskService?
    
    //MARK: OUTLETS
    
    @IBOutlet var data: UILabel!
    @IBOutlet var dueDate: UILabel!
    
    //MARK: Custom MEthods
    func loadData() {
        
        service = TaskService()
        service?.getOne(collectionID: "tasks", taskID: taskID) { task in
            self.task = task
            self.data.text = self.task?.taskdata
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            self.dueDate.text = dateFormatter.string(from: self.task?.duedate as! Date )
        }
        
    }
    
    //MARK: Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(taskID)
        loadData()
    }
    
    
}
