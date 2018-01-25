//
//  FriendsViewController.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 21/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData
import AvatarImageView
import SkyFloatingLabelTextField

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    @IBOutlet weak var friendsListView: UITableView!
    @IBOutlet weak var addFriend: UIBarButtonItem!
    @IBOutlet weak var friendNameField: SkyFloatingLabelTextField!
    @IBOutlet weak var okButton: UIButton!
    
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        
        friendsListView.dataSource = self
        friendsListView.delegate = self
        
    }
    
    @IBAction func addMember(_ sender: UIBarButtonItem) {
        friendNameField.isHidden = false
        okButton.isHidden = false
    }
    
    @IBAction func okButton(_ sender: UIButton) {
        if (friendNameField.text != nil) {
            let newUser:User = NSEntityDescription.insertNewObject(forEntityName: "User", into: DataBaseController.persistentContainer.viewContext) as! User
            newUser.name = friendNameField.text
            DataBaseController.saveContext()
            
            friendNameField.isHidden = true
            okButton.isHidden = true
            
            users.append(newUser)
            friendsListView.reloadData()
        }
    }
    
    func getData() {
        let context = DataBaseController.persistentContainer.viewContext
        do {
            users = try context.fetch(User.fetchRequest())
            users = users.filter {$0.isDefaultUser != true}
        }
        catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getData()
        friendsListView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MemberTableViewCell
        
        let friend = users[indexPath.row]
        cell.memberName.text = friend.name
        cell.avatarImageView.dataSource = DataSource(userName: friend.name!)
//        cell.icon.image = UIImage(named: "icon-emotion-happyx3")
//        cell.icon.contentMode = .scaleAspectFit
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        let expense = groupSelected.expenses?.allObjects[indexPath.row]
        //
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let tabBarController = storyboard.instantiateViewController(withIdentifier: "GroupTabVC") as! GroupTabBarController
        //
        //
        //        if let viewControllers = tabBarController.viewControllers,
        //            let groupExpensesController = viewControllers.first as? GroupExpensesViewController {
        //            groupExpensesController.groupSelected = groupSelected
        //        }
        //
        //
        //        navigationController?.pushViewController(tabBarController, animated: true)
        //
        //
    }


}
