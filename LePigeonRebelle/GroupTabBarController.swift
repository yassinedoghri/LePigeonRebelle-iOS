//
//  GroupTabBarControllerViewController.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 11/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit

class GroupTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    @IBOutlet weak var groupSelected: UINavigationItem!
    
    var group: Group!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newExpense(_ sender: UIBarButtonItem) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? NewExpenseViewController {
            viewController.groupSelected = group
        }
    }

    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController){
        if (viewController.isKind(of: GroupExpensesViewController.classForCoder())){
            let groupExpenses = viewController as! GroupExpensesViewController
        }
        if (viewController.isKind(of: GroupDebtsViewController.classForCoder())){
            let groupDebts = viewController as! GroupDebtsViewController
        }
    }

}
