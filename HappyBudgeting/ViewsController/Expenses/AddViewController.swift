//
//  AddViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 22/05/2023.
//

import UIKit
import CoreData

protocol AddExpenseReloadDelegate {
    func reloadTabeView(on: Bool)
}

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var expensePickerView: UIPickerView!
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    
    var expenseCategoryString: String = String()
    var expenseDescriptionString: String = String()
    var expenseAmountDouble: Double = Double()
    var selectedIconName: String = ""
    
    var manageObjectContext: NSManagedObjectContext?
    var expenseList = [Spendings]()
    
    var delegate: AddExpenseReloadDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryTextfield.delegate = self
        descriptionTextField.delegate = self
        amountTextfield.delegate = self
        expensePickerView.dataSource = self
        expensePickerView.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageObjectContext = appDelegate.persistentContainer.viewContext
        
    }
    
    func saveData(){
        let newItem = Spendings(context: manageObjectContext!)
        newItem.expenseCategory = expenseCategoryString
        newItem.expenseDescription = expenseDescriptionString
        newItem.expenseAmount = expenseAmountDouble
        newItem.expenseIconName = selectedIconName
                
        expenseList.append(newItem)

        do{
            try manageObjectContext?.save()
        }catch{
            fatalError("Error in saving data")
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let namesArray = ["a dog", "cool", "groceries", "gym", "savings", "car"]
        if row < namesArray.count {
            selectedIconName = namesArray[row]
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


extension AddViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
}

extension AddViewController: UIPickerViewDelegate {
    internal func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45 // Adjust this value to make the aisle bigger
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40)) // Adjust the width and height to your desired size
        
        let namesArray = ["a dog", "cool", "groceries", "gym", "savings", "car"]
        if row < namesArray.count {
            let imageName = namesArray[row]
            imageView.image = UIImage(named: imageName)?.resizeExpense(to: CGSize(width: 40, height: 40))
        } else {
            imageView.image = nil
        }
        
        return imageView
    }
}

extension UIImage {
    func resizeExpense(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
