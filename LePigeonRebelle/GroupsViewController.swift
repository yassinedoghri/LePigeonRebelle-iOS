//
//  GroupsViewController.swift
//  LePigeonRebelle
//
//  Created by iMac on 07/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData

class GroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet weak var groupsListView: UITableView!
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        groupsListView.dataSource = self
        groupsListView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        groupsListView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupTableViewCell
        
        let group = groups[indexPath.row]
        cell.groupName?.text = group.name!
        if (group.budget != 0){
            cell.budget.text = String(describing: group.budget!) + "€"
        } else {
            cell.budget.text = "No budget!"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let group = groups[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "GroupTabVC") as! GroupTabBarController
        
        tabBarController.groupSelected.title = group.name
        tabBarController.group = group
        if let viewControllers = tabBarController.viewControllers,
            let groupExpensesController = viewControllers.first as? GroupExpensesViewController {
            groupExpensesController.groupSelected = group
        }        
        navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    
    func getData() {
        let context = DataBaseController.persistentContainer.viewContext
        do {
            groups = try context.fetch(Group.fetchRequest())
        }
        catch {
            print(error)
        }
    }
}
