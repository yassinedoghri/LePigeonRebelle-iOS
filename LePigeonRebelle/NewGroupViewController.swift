//
//  NewGroupViewController.swift
//  LePigeonRebelle
//
//  Created by iMac on 05/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData

class NewGroupViewController: UIViewController {
    
    
    @IBOutlet weak var saveGroup: UIButton!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var membersList: UITableView!
    @IBOutlet weak var addMember: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Bonjour")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func memberAdd(_ sender: UIButton) {
    }
    
    @IBAction func addGroup(_ sender: UIButton) {
        // create a new group in the database with the group name in the TextField
        print("Bonjour")
        let entityName:String = String(describing: Group.self)
        let group_name:String = groupName.text!
        
        let group:Group = NSEntityDescription.insertNewObject(forEntityName: entityName, into: DataBaseController.persistentContainer.viewContext) as! Group
        group.name = group_name
        
        DataBaseController.saveContext()
        
        let fetchRequest:NSFetchRequest<Group> = Group.fetchRequest()
        
        do {
            let searchResults = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
            for result in searchResults as [Group] {
                print("\(result.name)")
            }
        }
        catch {
            print("Error: \(error)")
        }
    }
    
}
