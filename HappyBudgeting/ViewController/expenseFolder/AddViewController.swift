//
//  AddViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 22/05/2023.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    
    var expenseCategoryString: String = String()
    var expenseDescriptionString: String = String()
    var expenseAmountDouble: Double = Double()
    
    var manageObjectContext: NSManagedObjectContext?
    var expenseList = [Spendings]()
  
    
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

        //loadData()

    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//           textField.text = ""
//           textField.placeholder = nil
//       }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        expenseCategoryString = categoryTextfield.text ?? ""
        expenseDescriptionString = descriptionTextField.text ?? ""
        if let amountText = amountTextfield.text, let amount = Double(amountText) {
            expenseAmountDouble = amount
        }
        
        saveData()
        self.dismiss(animated: true)
    }
}


