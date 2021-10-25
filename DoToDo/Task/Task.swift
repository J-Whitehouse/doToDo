//
//  Task.swift
//  DoToDo
//
//  Created by Whitehouse, Jarret M on 10/20/21.
//

import UIKit
import Firebase

struct appTask {
    let taskID: String?
    let taskdata: String?
    let duedate: Date?
    let completed: Bool?
}

extension appTask {
    //Turn a collection of docs from firestoe into an array of appTasks
    static func build(from documents: [QueryDocumentSnapshot]) -> [appTask] {
        var tasks = [appTask]()
        
        for document in documents {
            // Create a dateformatter object to make dates of different styles
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            let stamp = document["duedate"] as? Timestamp
            var taskduedate: Date
            if let dd = stamp {
                taskduedate = dd.dateValue()
            } else {
                // If no due date, set it to today
                taskduedate = Date()
            }
            
            tasks.append(appTask(
                            taskID: document.documentID,
                            taskdata: document["taskdata"] as? String ?? "",
                            duedate: taskduedate,
                            completed: document["completed"] as? Bool))
        }
        
        return tasks
    }
    
    static func buildOne(from document: DocumentSnapshot) -> appTask {
        
        let stamp = document["duedate"] as? Timestamp
        var taskduedate: Date
        if let dd = stamp {
            taskduedate = dd.dateValue()
        } else {
            // If no due date, set it to today
            taskduedate = Date()
        }
        
        return appTask(taskID: document.documentID,
                       taskdata: document["taskdata"] as? String ?? "",
                       duedate: taskduedate,
                       completed: document["completed"] as? Bool)
    }
}
