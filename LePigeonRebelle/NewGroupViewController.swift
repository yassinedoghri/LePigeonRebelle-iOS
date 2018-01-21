//
//  NewGroupViewController.swift
//  LePigeonRebelle
//
//  Created by iMac on 05/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData
import SkyFloatingLabelTextField


class NewGroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, ModalViewControllerDelegate {
    
    
    @IBOutlet weak var saveGroup: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var membersList: UITableView!
    @IBOutlet weak var addMember: UIButton!
    @IBOutlet weak var type: UITextField!
    
    var pickerView = UIPickerView()
    
    var groupTypes: [GroupType] = []
    var userList: [User] = []
    var userGroup: UserGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("load"), object: nil)

        self.loadTypes()
        self.loadDefaultUser()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        membersList.delegate = self
        membersList.dataSource = self
        
        type.inputView = pickerView
        type.textAlignment = .center
        type.placeholder = "Select type"
        
        print(userList.count)
    }
    
    func reload() {
        membersList.reloadData()
        print("Data reloaded", userList.count)
    }
    
    func sendValue(value: [User]) {
        userList = value
        for user in userList as [User] {
            print(user.name)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        membersList.reloadData()
        print(userList.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AddMemberViewController {
            membersList.reloadData()
            viewController.userList = userList
            viewController.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MemberTableViewCell
        
        let user = userList[indexPath.row]
        if (user.isDefaultUser != true) {
            cell.memberName.text = user.name
        } else {
            cell.memberName.text = "Me"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            userList.remove(at: indexPath.row)
            membersList.reloadData()
        }
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
            
            for user in userList as [User] {
                let userGroup:UserGroup = NSEntityDescription.insertNewObject(forEntityName: "UserGroup", into: DataBaseController.persistentContainer.viewContext) as! UserGroup
                userGroup.user = user
                userGroup.group = group
                let cell = membersList.cellForRow(at: IndexPath(row: userList.index(of: user)!, section: 0)) as! MemberTableViewCell
                let formatter = NumberFormatter()
                formatter.generatesDecimalNumbers = true
                let budget = formatter.number(from: cell.budget.text!)
                userGroup.budget = budget as? NSDecimalNumber
                group.budget = group.budget?.adding(userGroup.budget!)
            }
            DataBaseController.saveContext()
        }
        catch {
            print("Error: \(error)")
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadTypes() {
        let fetchRequest:NSFetchRequest<GroupType> = GroupType.fetchRequest()
        
        do {
            groupTypes = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    func loadDefaultUser() {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isDefaultUser == %@", NSNumber(value: true))
        
        do {
            let defaultUser = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
            userList.append(defaultUser.first!)
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type.text = groupTypes[row].wording
        type.resignFirstResponder()
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
}
