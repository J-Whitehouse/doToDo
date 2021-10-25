//
//  TasksTableViewController.swift
//  DoToDo
//
//  Created by Whitehouse, Jarret M on 10/20/21.
//

import UIKit
import Firebase

class TasksTableViewController: UITableViewController {
    
    //MARK: Attributes
    private var service: TaskService?
    
    private var allTasks = [appTask]() {
        didSet {
            DispatchQueue.main.async {
                self.tasks = self.allTasks
            }
        }
    }
    
    var tasks = [appTask]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Custom Methods
    
    func loadData() {
        service = TaskService()
        service?.get(collectionID: "tasks") {
            tasks in
            self.allTasks = tasks
        }
    }
    
    // MARK: Event Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        //Load this data from Firestore
        loadData()
        
    }
    
    //MARK: Table View Controller requires two methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create an instance if tge UITableViewCell with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        var duedate: Date?
        duedate = tasks[indexPath.row].duedate
        
        cell.textLabel?.text = tasks[indexPath.row].taskdata
        
        if (duedate != nil) {
            cell.detailTextLabel?.text = dateFormatter.string(from: duedate as! Date)
        }
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskDetailSegue" {
            
            let detailView = segue.destination as! TaskDetailViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let taskID = tasks[indexPath.row].taskID!
                
                //Set the task ID on the destination view controller
                
                detailView.taskID = taskID
            }
        }
    }
}
