//
//  WelcomeViewController.swift
//  LePigeonRebelle
//
//  Created by Sousou on 06/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData

var defaultUser:User?


class WelcomeViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // initialize static data in Core Data
        // group Types
        let entityName:String = String(describing: GroupType.self)
        let fetchRequest:NSFetchRequest<GroupType> = GroupType.fetchRequest()
        
        do {
            let searchResultsCount = try DataBaseController.persistentContainer.viewContext.count(for: fetchRequest)
            if (searchResultsCount == 0) {
                print("Saving GroupType!")
                let groupTypes: [String] = ["House", "Birthday", "Leisure", "Trip", "Other"]
                for type in groupTypes {
                    let groupType:GroupType = NSEntityDescription.insertNewObject(forEntityName: entityName, into: DataBaseController.persistentContainer.viewContext) as! GroupType
                    groupType.wording = type
                }
                DataBaseController.saveContext()
            } else {
                print("GroupType Already Saved!")
                let searchResults = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
                for result in searchResults as [GroupType] {
                    print("\(String(describing: result.wording))")
                }
            }
        }
        catch {
            print("Error: \(error)")
        }
        
        // expense Types
        let entityNameET:String = String(describing: ExpenseType.self)
        let fetchRequestET:NSFetchRequest<ExpenseType> = ExpenseType.fetchRequest()
        
        do {
            let searchResultsCount = try DataBaseController.persistentContainer.viewContext.count(for: fetchRequestET)
            if (searchResultsCount == 0) {
                print("Saving ExpenseType!")
                let expenseTypes: [String] = ["Refund", "Split Equally", "Split Unequally", "Split by Shares"]
                for type in expenseTypes {
                    let expenseType:ExpenseType = NSEntityDescription.insertNewObject(forEntityName: entityNameET, into: DataBaseController.persistentContainer.viewContext) as! ExpenseType
                    expenseType.wording = type
                }
                DataBaseController.saveContext()
            } else {
                print("ExpenseType Already Saved!")
                let searchResults = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequestET)
                for result in searchResults as [ExpenseType] {
                    print("\(String(describing: result.wording))")
                }
            }
        }
        catch {
            print("Error: \(error)")
        }
        
        // expense Categories
        let entityNameEC:String = String(describing: ExpenseCategory.self)
        let fetchRequestEC:NSFetchRequest<ExpenseCategory> = ExpenseCategory.fetchRequest()
        
        do {
            let searchResultsCount = try DataBaseController.persistentContainer.viewContext.count(for: fetchRequestEC)
            if (searchResultsCount == 0) {
                print("Saving ExpenseCategory!")
                let expenseCategories: [String] = ["Leisure", "Food", "House", "Groceries", "Services", "Transport", "Other"]
                for category in expenseCategories {
                    let expenseCategory:ExpenseCategory = NSEntityDescription.insertNewObject(forEntityName: entityNameEC, into: DataBaseController.persistentContainer.viewContext) as! ExpenseCategory
                    expenseCategory.wording = category
                }
                DataBaseController.saveContext()
            } else {
                print("ExpenseCategory Already Saved!")
                let searchResults = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequestEC)
                for result in searchResults as [ExpenseCategory] {
                    print("\(String(describing: result.wording))")
                }
            }
        }
        catch {
            print("Error: \(error)")
        }
    }

    @IBAction func startPressed(_ sender: Any) {
        let entityNameU:String = String(describing: User.self)
        
        let user:User = NSEntityDescription.insertNewObject(forEntityName: entityNameU, into: DataBaseController.persistentContainer.viewContext) as! User
        user.name = userNameField.text!
        user.isDefaultUser = true
        DataBaseController.saveContext()
        
        defaultUser = user
        
        UserDefaults.standard.set(true, forKey: "defaultUserCreated")
    }
    
}
