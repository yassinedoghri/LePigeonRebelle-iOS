//
//  NewExpenseViewController.swift
//  LePigeonRebelle
//
//  Created by Sousou on 06/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData

class NewExpenseViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var groupField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var payedByField: UITextField!
    @IBOutlet weak var expenseTypeField: UITextField!
    @IBOutlet weak var payedForField: UITextField!
    @IBOutlet weak var commentField: UITextField!
    
    // date picker
    let datePicker = UIDatePicker()
    
    var types: [ExpenseType] = []
    var groups: [Group] = []
    
    let categoryPickerView = UIPickerView()
    let groupPickerView = UIPickerView()
    
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
        
        self.createDatePicker()
        
        self.loadTypes()
        self.loadGroups()
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        
        expenseTypeField.inputView = categoryPickerView
        
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
        
        groupField.inputView = groupPickerView
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func loadTypes() {
        let fetchRequest:NSFetchRequest<ExpenseType> = ExpenseType.fetchRequest()
        
        do {
            types = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error: \(error)")
        }

    }
    
    func loadGroups() {
        let fetchRequest:NSFetchRequest<Group> = Group.fetchRequest()
        
        do {
            groups = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numberOfRows: Int = 0
        
        if (pickerView == groupPickerView) {
            numberOfRows = groups.count
        }
        if (pickerView == categoryPickerView) {
            numberOfRows = types.count
        }
        return numberOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title: String = ""
        
        if (pickerView == groupPickerView) {
            title = groups[row].name!
        }
        if (pickerView == categoryPickerView) {
            title = types[row].wording!
        }
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == categoryPickerView) {
            expenseTypeField.text = types[row].wording
            expenseTypeField.resignFirstResponder()
        }
        if (pickerView == groupPickerView) {
            groupField.text = groups[row].name!
            groupField.resignFirstResponder()
        }
    }
    
    func createDatePicker() {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.doneDatePickerPressed))
        toolbar.setItems([done], animated: false)
        
        dateField.inputAccessoryView = toolbar
        dateField.inputView = datePicker
        
        //format picker to only display date
        datePicker.datePickerMode = .date
    }
    
    @objc func doneDatePickerPressed() {
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: datePicker.date)
        
        dateField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    @IBAction func saveExpense(_ sender: Any) {
        // save a new Expense in the database with the description
        print("Saving Expense...")
        let entityName:String = String(describing: Expense.self)
        let description:String = self.descriptionField.text!
        let comment:String = self.commentField.text!

        // date
        let dateString:String = self.dateField.text!

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let date = dateFormatter.date(from: dateString)
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        let amount = formatter.number(from: amountField.text!)
        let debt:Debt = NSEntityDescription.insertNewObject(forEntityName: "Debt", into: DataBaseController.persistentContainer.viewContext) as! Debt
        debt.amount = amount as! NSDecimalNumber
        
        let expense:Expense = NSEntityDescription.insertNewObject(forEntityName: entityName, into: DataBaseController.persistentContainer.viewContext) as! Expense
        expense.desc = description
        expense.date = date! as NSDate
        expense.comment = comment
        expense.addToDebts(debt)
        
        if let group = groups.first(where: { $0.name == self.groupField.text! }) {
            expense.group = group
        }
        if let type = types.first(where: { $0.wording == self.expenseTypeField.text! }) {
            expense.type = type
        }
        
        DataBaseController.saveContext()
        
//        let fetchRequest:NSFetchRequest<Expense> = Expense.fetchRequest()
//        
//        do {
//            let searchResults = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
//            for result in searchResults as [Expense] {
//                print("\(String(describing: result.description))")
//            }
//        }
//        catch {
//            print("Error: \(error)")
//        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelNewExpense(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
