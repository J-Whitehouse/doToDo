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
    @IBOutlet var switchCompleted: UISwitch!
    
    @IBAction func switchOnValueChanged(_ sender: Any) {
        
        if switchCompleted.isOn {
            print("The switch is on; the task is completed")
        } else{
            print("The switch is off; the task is NOT completed")
        }
    }
    
    //MARK: Custom Methods
    func loadData() {
        
        service = TaskService()
        service?.getOne(collectionID: "tasks", taskID: taskID) { task in
            self.task = task
            self.data.text = self.task?.taskdata
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            self.dueDate.text = dateFormatter.string(from: self.task?.duedate as! Date )
            
            if self.task?.completed == false {
                self.switchCompleted.setOn(false, animated: false)
            } else {
                self.switchCompleted.setOn(true, animated: false)
            }
        }
        
    }
    
    //MARK: Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(taskID)
        loadData()
    }
    
    
}
