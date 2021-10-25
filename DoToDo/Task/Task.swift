//
//  Task.swift
//  DoToDo
//
//  Created by Whitehouse, Jarret M on 10/20/21.
//

import UIKit
import Firebase

struct appTask {
    let taskdata: String?
    let duedate: Date?
    let completed: Bool?
}

extension appTask {
    //Turn a collection of docs from firestoe into an array of appTasks
    static func build(from documents: [QueryDocumentSnapshot]) -> [appTask] {
        var tasks = [appTask]()
        
        for document in documents {
            tasks.append(appTask(taskdata: document["taskdata"] as? String ?? "", duedate: document[""] as? Date ?? "",completed: document[""] as? Bool ?? ""))
        }
        
        return tasks
    }
}
