//
//  AddMemberViewController.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 18/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData
import AvatarImageView

protocol ModalViewControllerDelegate
{
    func sendValue( value : [User])
}

class AddMemberViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    struct DataSource: AvatarImageViewDataSource {
        var name: String
        var avatar: UIImage?
        
        init(userName: String) {
            name = DataSource.setUserName(userName: userName)
        }
        
        static func setUserName(userName: String) -> String {
            let name = userName
            return name
        }
    }

    @IBOutlet weak var MembersList: UITableView!
    @IBOutlet weak var newMemberNameField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    
    
    var users: [User] = []
    var userList: [User] = []
    var user: User!
    
    var delegate:ModalViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.loadUsers()

        MembersList.delegate = self
        MembersList.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MembersList.reloadData()
    }
    
    @IBAction func newMember(_ sender: UIButton) {
    }
    
    func loadUsers() {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            users = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
            for user in userList as [User] {
                users = users.filter {$0.name != user.name}
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MemberTableViewCell
        
        let user = users[indexPath.row]
            cell.memberName.text = user.name
        cell.avatarImageView.dataSource = DataSource(userName: user.name!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        if (userList.contains(user)) {
            print("User already selected")
        } else {
            userList.append(user)
        }
        users.remove(at: indexPath.row)
        MembersList.reloadData()
    }

    @IBAction func addNewMember(_ sender: UIButton) {
        newMemberNameField.isHidden = false
        okButton.isHidden = false
    }

    @IBAction func okButton(_ sender: UIButton) {
        if ((newMemberNameField.text) != nil) {
            let newUser:User = NSEntityDescription.insertNewObject(forEntityName: "User", into: DataBaseController.persistentContainer.viewContext) as! User
            newUser.name = newMemberNameField.text
            DataBaseController.saveContext()
            
            newMemberNameField.isHidden = true
            okButton.isHidden = true
            
            users.append(newUser)
            MembersList.reloadData()
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
          delegate?.sendValue(value: userList) //call the func in the previous vc
    }
    
    
    @IBAction func dismissPopup(_ sender: UIButton) {
            delegate?.sendValue(value: userList)
            print(userList.count)
        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)

        dismiss(animated: true, completion: nil)
    }

    @IBAction func addMember(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
