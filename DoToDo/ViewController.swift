//
//  ViewController.swift
//  DoToDo
//
//  Created by Whitehouse, Jarret M on 10/18/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    //MARK: Atrributes
    let db = Firestore.firestore()
    
    //MARK: IBOutlets and Actions
    @IBOutlet var txtTask: UITextField!
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        
        var taskdata: String = ""
        
        if let td = txtTask.text {
            taskdata = td
        }
        
        //Add a document to the collection named "cities"
        var ref: DocumentReference? = nil
        
        ref = db.collection("tasks").addDocument(data: [
            "details": taskdata
        ]) { err in
            if let err = err{
                print("Error writing document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

