//
//  AddViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 22/05/2023.
//

import UIKit
import CoreData

protocol ReloadDelegate {
    func reloadTabeView(on: Bool)
}

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    
    var expenseCategoryString: String = String()
    var expenseDescriptionString: String = String()
    var expenseAmountDouble: Double = Double()
    
    var manageObjectContext: NSManagedObjectContext?
    var expenseList = [Spendings]()
    
    var delegate: ReloadDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryTextfield.delegate = self
        descriptionTextField.delegate = self
        amountTextfield.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageObjectContext = appDelegate.persistentContainer.viewContext
        
    }
    
    func saveData(){
        let newItem = Spendings(context: manageObjectContext!)
        newItem.expenseCategory = expenseCategoryString
        newItem.expenseDescription = expenseDescriptionString
        newItem.expenseAmount = expenseAmountDouble
                
        expenseList.append(newItem)

        do{
            try manageObjectContext?.save()
        }catch{
            fatalError("Error in saving data")
        }
        
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        expenseCategoryString = categoryTextfield.text ?? ""
        expenseDescriptionString = descriptionTextField.text ?? ""
        if let amountText = amountTextfield.text, let amount = Double(amountText) {
            expenseAmountDouble = amount
        }
        
        saveData()
        delegate?.reloadTabeView(on: true)
        self.dismiss(animated: true)
    }
}


