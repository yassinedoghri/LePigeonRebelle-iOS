//
//  NewExpenseViewController.swift
//  LePigeonRebelle
//
//  Created by Sousou on 06/01/2018.
//  Copyright © 2018 Le Pigeon Rebelle. All rights reserved.
//

import UIKit
import CoreData
import AvatarImageView
import DropDown

class NewExpenseViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    struct DataSource: AvatarImageViewDataSource {
        var name: String
        var avatar: UIImage?
        
        init(userName: String) {
            name = DataSource.setUserName(userName: userName)
        }
        
        static func setUserName(userName: String) -> String {
            let name = userName
            return name
        }
    }
    
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var payedByField: UITextField!
    @IBOutlet weak var expenseTypeField: UITextField!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var expenceCategoryButton: UIButton!
    @IBOutlet weak var payedForButton: UIButton!
    @IBOutlet weak var userOwingListView: UITableView!

    // date picker
    let datePicker = UIDatePicker()
    
    var types: [ExpenseType] = []
    var categories: [ExpenseCategory] = []
    var users: [User] = []
    var userGroupList: [UserGroup] = []
    var userOwingList: [User] = []
    var groupSelected: Group!
    var userPaying: User!
    
    let categoryPickerView = UIPickerView()
    let groupPickerView = UIPickerView()
    let payedByPickerView = UIPickerView()
    
    let chooseExpenseCategoryDropDown = DropDown()
    let choosePayedForDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.chooseExpenseCategoryDropDown,
            self.choosePayedForDropDown
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateField.delegate = self
        self.descriptionField.delegate = self
        self.amountField.delegate = self
        self.payedByField.delegate = self
        self.expenseTypeField.delegate = self
        self.commentField.delegate = self
        
        let image = UIImage(named: "ec_other1x")
        expenceCategoryButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.groupLabel.text = groupSelected.name

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        self.createDatePicker()
        
        self.loadTypes()
        self.loadUserGroupList()
        self.loadUsers()
        self.loadCategories()
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        
        expenseTypeField.inputView = categoryPickerView
        
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
        
        payedByPickerView.delegate = self
        payedByPickerView.dataSource = self
        
        payedByField.inputView = payedByPickerView
        
        setupDropDowns()
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userOwingListView.reloadData()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    
    @IBAction func chooseExpenseCategroy(_ sender: UIButton) {
        chooseExpenseCategoryDropDown.show()
    }
    
    
    @IBAction func choosePayedFor(_ sender: UIButton) {
        choosePayedForDropDown.show()
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
    
    func loadCategories() {
        let fetchRequest:NSFetchRequest<ExpenseCategory> = ExpenseCategory.fetchRequest()
        
        do {
            categories = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    func loadUserGroupList() {
        let fetchRequest:NSFetchRequest<UserGroup> = UserGroup.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "group == %@", groupSelected)
        
        do {
            userGroupList = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func loadUsers() {
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()

        do {
            users = try DataBaseController.persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var numberOfRows: Int = 0
        
        if (pickerView == categoryPickerView) {
            numberOfRows = types.count
        }
        if (pickerView == payedByPickerView) {
            numberOfRows = userGroupList.count
        }
        return numberOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title: String = ""
        
        if (pickerView == categoryPickerView) {
            title = types[row].wording!
        }
        if (pickerView == payedByPickerView) {
            title = (userGroupList[row].user?.name!)!
        }
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == categoryPickerView) {
            expenseTypeField.text = types[row].wording
            expenseTypeField.resignFirstResponder()
        }
        if (pickerView == payedByPickerView) {
            payedByField.text = userGroupList[row].user?.name!
            userPaying = userGroupList[row].user
            payedByField.resignFirstResponder()
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
        
        let expense:Expense = NSEntityDescription.insertNewObject(forEntityName: entityName, into: DataBaseController.persistentContainer.viewContext) as! Expense
        expense.desc = description
        expense.date = date! as NSDate
        expense.comment = comment
        expense.group = groupSelected
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        var amount = formatter.number(from: amountField.text!)
        for user in userOwingList {
            let debt:Debt = NSEntityDescription.insertNewObject(forEntityName: "Debt", into: DataBaseController.persistentContainer.viewContext) as! Debt
            debt.amount = amount as! NSDecimalNumber
            debt.userPaying = userPaying
            debt.userOwing = user
            expense.addToDebts(debt)
        }
        
        if let type = types.first(where: { $0.wording == self.expenseTypeField.text! }) {
            expense.type = type
        }
        
        DataBaseController.saveContext()

        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userOwingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MemberTableViewCell
        
        let friend = userOwingList[indexPath.row]
        cell.memberName.text = friend.name
        cell.avatarImageView.dataSource = DataSource(userName: friend.name!)

        return cell
    }
    
    func setExpenseCategoryImage(expenseCategory: String) -> String {
        let imageName = "ec_" + expenseCategory.lowercased() + "1x"
        return imageName
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    //MARK: - Setup
    
    func setupDropDowns() {
        setupChoosePayedForDropDown()
        setupExpenseCategoryDropDown()
    }
    
    func setupChoosePayedForDropDown() {
        choosePayedForDropDown.anchorView = payedForButton
        
        // Will set a custom with instead of anchor view width
        //		dropDown.width = 100
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        choosePayedForDropDown.bottomOffset = CGPoint(x: 0, y: payedForButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        var usersName: [String] = []
        var users: [User] = []
        for userGroup in userGroupList {
            usersName.append((userGroup.user?.name!)!)
            users.append(userGroup.user!)
        }
        choosePayedForDropDown.dataSource = usersName
        
        // Action triggered on selection
        choosePayedForDropDown.selectionAction = { [weak self] (index, item) in
            self?.userOwingList.append((self?.userGroupList[index].user!)!)
            self?.userOwingListView.reloadData()
        }
        
//        choosePayedForDropDown.multiSelectionAction = { [weak self] (indices, items) in
//            print("Muti selection action called with: \(items)")
//            self?.userOwingList.append(users.filter {$0.name = items[indices.]})
//                    self?.userOwingListView.reloadData()
//                    print(self?.userOwingList[items.index(of: item)!])
//                }
//        }
        
        // Action triggered on dropdown cancelation (hide)
        //		dropDown.cancelAction = { [unowned self] in
        //			// You could for example deselect the selected item
        //			self.dropDown.deselectRowAtIndexPath(self.dropDown.indexForSelectedRow)
        //			self.actionButton.setTitle("Canceled", forState: .Normal)
        //		}
        
        // You can manually select a row if needed
        //		dropDown.selectRowAtIndex(3)
    }
    
    func setupExpenseCategoryDropDown() {
        chooseExpenseCategoryDropDown.anchorView = expenceCategoryButton
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        chooseExpenseCategoryDropDown.bottomOffset = CGPoint(x: 0, y: expenceCategoryButton.bounds.height)
        
        var categoryExpense: [String] = []
        for eC in categories {
            categoryExpense.append(eC.wording!)
        }
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseExpenseCategoryDropDown.dataSource = categoryExpense
        
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        chooseExpenseCategoryDropDown.cellNib = UINib(nibName: "ExpenseCategoryCell", bundle: nil)
        
        chooseExpenseCategoryDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? ExpenseCategoryCell else { return }
            let image = UIImage(named: self.setExpenseCategoryImage(expenseCategory: item))?.withRenderingMode(.alwaysOriginal)
            cell.imageCategory.image = image
            // Setup your custom UI components
        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/
        
        // Action triggered on selection
        chooseExpenseCategoryDropDown.selectionAction = { [weak self] (index, item) in
            var image = UIImage(named: (self?.setExpenseCategoryImage(expenseCategory: item))!)
            self?.expenceCategoryButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    @IBAction func cancelNewExpense(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
