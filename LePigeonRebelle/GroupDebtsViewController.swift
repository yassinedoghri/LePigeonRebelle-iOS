//
//  GroupDebtsViewController.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 11/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData

class GroupDebtsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var debtsListView: UITableView!
    
    var groupSelected: Group {
        get {
            return (self.tabBarController!.viewControllers![0] as! GroupExpensesViewController).groupSelected
        }
        set {
            (self.tabBarController!.viewControllers![0] as! GroupExpensesViewController).groupSelected = groupSelected
        }
    }
    var groupExpensesViewController: GroupExpensesViewController?
    
    var debtsList: [Debt] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.listDebts()
        debtsListView.dataSource = self
        debtsListView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listDebts()
        debtsListView.reloadData()
    }
    
    func listDebts() {
        debtsList.removeAll()
        for expense in groupSelected.expenses?.allObjects as! [Expense] {
            for expenseDebt in expense.debts?.allObjects as! [Debt] {
                debtsList.append(expenseDebt)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.debtsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DebtCell", for: indexPath) as! DebtTableViewCell
        
        let expenseDebt = debtsList[indexPath.row]
        cell.amount.text = String(describing: expenseDebt.amount!) + "€"
        cell.userPaying.text = expenseDebt.userPaying?.name
        cell.userOwed.text = expenseDebt.userOwing?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}
