//
//  GroupDebtsViewController.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 11/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit

class GroupDebtsViewController: UIViewController {

    @IBOutlet weak var debt: UILabel!
    var groupSelected: Group {
        get {
            return (self.tabBarController!.viewControllers![0] as! GroupExpensesViewController).groupSelected
        }
        set {
            (self.tabBarController!.viewControllers![0] as! GroupExpensesViewController).groupSelected = groupSelected
        }
    }
    var groupExpensesViewController: GroupExpensesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.debt.text = groupSelected.name

        print("Debts: ", groupSelected.name)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
