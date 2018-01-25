//
//  GroupExpensesViewController.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 11/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData

class GroupExpensesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var expensesListView: UITableView!
    
    var groupSelected : Group!
    var groupDebtsController: GroupDebtsViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        expensesListView.dataSource = self
        expensesListView.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        expensesListView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (groupSelected.expenses?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as! ExpenseTableViewCell
        
        var price: NSDecimalNumber = 0.0
        
        let expense = groupSelected.expenses?.allObjects[indexPath.row] as! Expense
        cell.expenseName.text = expense.desc
        
        for debt in expense.debts?.allObjects as! [Debt] {
            price = price.adding(debt.amount!)
        }
        cell.price.text = String(describing: price) + "€"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
