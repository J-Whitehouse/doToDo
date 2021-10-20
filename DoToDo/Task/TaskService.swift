//
//  TaskService.swift
//  DoToDo
//
//  Created by Whitehouse, Jarret M on 10/20/21.
//

import Foundation
import Firebase

class TaskService {
    let database = Firestore.firestore()
    
    func get(collectionID: String, handler: @escaping ([appTask]) -> Void) {
        database.collection(collectionID).addSnapshotListener {
            QuerySnapshot, err in
            if let error = err {
                print(error)
                handler([])
            } else {
                handler(appTask.build(from: QuerySnapshot?.documents ?? []))
            }
            
        }
        
    }
}
