//
//  TaskDataViewController.swift
//  DoToDo
//
//  Created by Whitehouse, Jarret M on 10/25/21.
//

import UIKit
import Firebase
import GoogleSignIn

class TaskDetailViewController: UIViewController {
    
    // MARK: Attributes
    var taskID: String = ""
    var task: appTask?
    private var service: TaskService?
    
    // MARK: IBOutlets and Actions
    @IBOutlet var lblTaskData: UILabel!
    @IBOutlet var lblDueDate: UILabel!
    @IBOutlet var switchCompleted: UISwitch!
    
    @IBAction func switchOnValueChanged(_ sender: Any) {
        let db = Firestore.firestore()
        var completed: Bool = false
        
        if switchCompleted.isOn {
            print("The switch is on; the task is completed")
            completed = true
        } else {
            print("The switch is off; the task is NOT completed")
            completed = false
        }
        
        // Get a reference to our Firestore document
        let taskRef: DocumentReference? = db.collection("tasks").document(self.taskID)
        taskRef?.updateData(["completed": completed]) { err in
            if let error = err {
                print("Error updating document: \(error)")
            } else {
                print("Document \(taskRef!.documentID) updated!")
            }
        }
        
        // Dismiss this view
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: Custom methods
    func loadData() {
        service = TaskService()
        
        var collection = ""
        if let user = GIDSignIn.sharedInstance.currentUser {
            collection = user.userID!
        }
        
        service?.getOne(collectionID: collection, taskID: taskID) { task in
            self.task = task
            self.lblTaskData.text = self.task?.taskdata
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            self.lblDueDate.text = dateFormatter.string(from: self.task?.duedate as! Date)
            
            if self.task?.completed == false {
                self.switchCompleted.setOn(false, animated: false)
            } else {
                self.switchCompleted.setOn(true, animated: false)
            }
        }
    }
    
    
    // MARK: Lifecycle functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(taskID)
        loadData()
    }
    
}
