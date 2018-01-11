//
//  GroupTabBarControllerViewController.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 11/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit

class GroupTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var grouopSelected: Group!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController){
        if (viewController.isKind(of: GroupExpensesViewController.classForCoder())){
            let groupExpenses = viewController as! GroupExpensesViewController
            print("Expenses", groupExpenses.groupSelected.name)
        }
        if (viewController.isKind(of: GroupDebtsViewController.classForCoder())){
            let groupDebts = viewController as! GroupDebtsViewController
            print("Debts", groupDebts.groupSelected.name)
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

}
