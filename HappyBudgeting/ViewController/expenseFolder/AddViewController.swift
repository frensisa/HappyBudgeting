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

class AddViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {

    @IBOutlet weak var expensePickerView: UIPickerView!
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    
    var expenseCategoryString: String = String()
    var expenseDescriptionString: String = String()
    var expenseAmountDouble: Double = Double()
    
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


extension AddViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
}

extension AddViewController: UIPickerViewDelegate {
    
    
    func expensePickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45 // Adjust this value to make the aisle bigger
    }
    
    func expensePickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 42, height: 42)) // Adjust the width and height to your desired size

        switch row {
        case 0:
            imageView.image = UIImage(named: "a dog")?.resize(to: CGSize(width: 42, height: 42))
        case 1:
            imageView.image = UIImage(named: "groceries")?.resize(to: CGSize(width: 42, height: 42))
        case 2:
            imageView.image = UIImage(named: "gym")?.resize(to: CGSize(width: 42, height: 42))
        case 3:
            imageView.image = UIImage(named: "savings")?.resize(to: CGSize(width: 42, height: 42))
        case 4:
            imageView.image = UIImage(named: "tmybudget")?.resize(to: CGSize(width: 42, height: 42))
        default:
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
