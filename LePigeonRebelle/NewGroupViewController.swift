//
//  NewGroupViewController.swift
//  LePigeonRebelle
//
//  Created by iMac on 05/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData

class NewGroupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var saveGroup: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var membersList: UITableView!
    @IBOutlet weak var addMember: UIButton!
    @IBOutlet weak var type: UITextField!
    
    var pickerView = UIPickerView()
    
    var groupTypes: [GroupType] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadTypes()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        type.inputView = pickerView
        type.textAlignment = .center
        type.placeholder = "Select type"
        
        
    }
    
    
    @IBAction func memberAdd(_ sender: UIButton) {
    }
    
    @IBAction func saveGroup(_ sender: Any) {
        // create a new group in the database with the group name in the TextField
        let entityName:String = String(describing: Group.self)
        let group_name:String = groupName.text!
        
        let fetchRequestGT:NSFetchRequest<GroupType> = GroupType.fetchRequest()
        fetchRequestGT.predicate = NSPredicate(format: "wording == %@", type.text!)
        let resultGT: GroupType
        
        do {
            let searchResults = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequestGT)
            resultGT = searchResults[0]
            let group:Group = NSEntityDescription.insertNewObject(forEntityName: entityName, into: DataBaseController.persistentContainer.viewContext) as! Group
            group.name = group_name
            group.type = resultGT
            
            DataBaseController.saveContext()
        }
        catch {
            print("Error: \(error)")
        }
        
        
        
        let fetchRequestG:NSFetchRequest<Group> = Group.fetchRequest()
        
        do {
            let searchResults = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequestG)
            for result in searchResults as [Group] {
                print(result.name)
                print(result.type.wording)
            }
        }
        catch {
            print("Error: \(error)")
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectType(_ sender: UITextField) {
    }
    
    // returns the number of 'columns' to display.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groupTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groupTypes[row].wording
    }
    
    func loadTypes() {
        let fetchRequest:NSFetchRequest<GroupType> = GroupType.fetchRequest()
        
        do {
            groupTypes = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error: \(error)")
        }
        
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type.text = groupTypes[row].wording
        type.resignFirstResponder()
        
    }
}
