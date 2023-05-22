//
//  AddViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 22/05/2023.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryTextfield.delegate = self
        descriptionTextField.delegate = self
        amountTextfield.delegate = self
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           textField.text = ""
           textField.placeholder = nil
       }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

    
    @IBAction func categoryTextfieldTapped(_ sender: Any) {
        //the text deletes
        categoryTextfield.text = ""
        categoryTextfield.placeholder = nil
    }
    
    @IBAction func descriptionTextFieldTapped(_ sender: Any) {
        //the text deletes
        descriptionTextField.text = ""
        descriptionTextField.placeholder = nil
    }
    
    @IBAction func amountTextfieldTapped(_ sender: Any) {
        //the text deletes
        amountTextfield.text = ""
        amountTextfield.placeholder = nil
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


