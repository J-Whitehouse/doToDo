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
        
        //Add a document to the collection named "cities"
        db.collection("cities").document("LA").setData([
            "name": "Los Angeles",
            "state": "CA",
            "country": "USA"
        ]) { err in
            if let err = err{
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

