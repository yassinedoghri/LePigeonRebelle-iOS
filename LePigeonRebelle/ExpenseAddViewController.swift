//
//  ExpenseAddViewController.swift
//  LePigeonRebelle
//
//  Created by Sousou on 05/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit

class ExpenseAddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var groupField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var payedByField: UITextField!
    @IBOutlet weak var expenseTypeField: UITextField!
    @IBOutlet weak var payedForField: UITextField!
    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupField.delegate = self
        self.dateField.delegate = self
        self.descriptionField.delegate = self
        self.amountField.delegate = self
        self.payedByField.delegate = self
        self.payedForField.delegate = self
        self.expenseTypeField.delegate = self
        self.commentField.delegate = self
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func cancelNewExpense(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
