//
//  GroupExpensesViewController.swift
//  LePigeonRebelle
//
//  Created by walidebisi on 11/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData

class GroupExpensesViewController: UIViewController {
    @IBOutlet weak var expense: UILabel!
    var groupSelected : Group!
    var groupDebtsController: GroupDebtsViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.expense.text = groupSelected.name
        print("Expenses: ", groupSelected.name)
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
