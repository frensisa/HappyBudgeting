//
//  AddIncomeViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 23/05/2023.
//

import UIKit
import CoreData

class AddIncomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var incomeCategoryTextField: UITextField!
    @IBOutlet weak var incomeDescriptionTextField: UITextField!
    @IBOutlet weak var incomeAmountTextField: UITextField!
    
    var incomeCategoryString: String = String()
    var incomeDescriptionString: String = String()
    var incomeAmountDouble: Double = Double()

    var manageObjectContext: NSManagedObjectContext?
    var incomeList = [Income]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incomeCategoryTextField.delegate = self
        incomeDescriptionTextField.delegate = self
        incomeAmountTextField.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func updateDetails(){
        
    }
    
    func saveData(){
        let newItem = Income(context: manageObjectContext!)
        newItem.incomeCategory = incomeCategoryString
        newItem.incomeDescription = incomeDescriptionString
        newItem.incomeAmount = incomeAmountDouble
                
        incomeList.append(newItem)

        do{
            try manageObjectContext?.save()
        }catch{
            fatalError("Error in saving data")
        }

        //loadData()

    }
    
    
    @IBAction func incomeDoneButtonTapped(_ sender: Any) {
        incomeCategoryString = incomeCategoryTextField.text ?? ""
        incomeDescriptionString = incomeDescriptionTextField.text ?? ""
        if let amountText = incomeAmountTextField.text, let amount = Double(amountText) {
            incomeAmountDouble = amount
        }
        
        saveData()
        self.dismiss(animated: true)
    }


}
