//
//  DebtsViewController.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 14/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData

class DebtsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    
    @IBOutlet weak var debtsListView: UITableView!
    
    var debtsList: [Debt] = []
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.getData()
        self.listDebts()
        //self.debt.text = groupSelected.name
        debtsListView.dataSource = self
        debtsListView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getData()
        self.listDebts()
        print(debtsList.count)
        debtsListView.reloadData()
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
    
    func listDebts() {
        debtsList.removeAll()
        for group in groups {
            for expense in group.expenses?.allObjects as! [Expense] {
                for expenseDebt in expense.debts?.allObjects as! [Debt] {
                    print(expenseDebt.amount)
                    debtsList.append(expenseDebt)
                }
            }
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
