//
//  AddIncomeViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 23/05/2023.
//

import UIKit

class AddIncomeViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var incomeCategoryTextField: UITextField!
    @IBOutlet weak var incomeDescriptionTextField: UITextField!
    @IBOutlet weak var incomeAmountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incomeCategoryTextField.delegate = self
        incomeDescriptionTextField.delegate = self
        incomeAmountTextField.delegate = self
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           textField.text = ""
           textField.placeholder = nil
       }
   

    
    @IBAction func incomeDoneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func incomeCategoryTextFieldTapped(_ sender: Any) {
        //the text deletes
        incomeCategoryTextField.text = ""
        incomeCategoryTextField.placeholder = nil
    }
    
    @IBAction func incomeDescriptionTextFieldTapped(_ sender: Any) {
        //the text deletes
        incomeDescriptionTextField.text = ""
        incomeDescriptionTextField.placeholder = nil
    }
    
    @IBAction func incomeAmountTextFieldTapped(_ sender: Any) {
        //the text deletes
        incomeAmountTextField.text = ""
        incomeAmountTextField.placeholder = nil
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
