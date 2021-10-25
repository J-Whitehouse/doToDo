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
        
        cell.textLabel?.text = tasks[indexPath.row].taskdata
        cell.detailTextLabel?.text = tasks[indexPath.row].String(duedate)
    
        return cell
    }
}
