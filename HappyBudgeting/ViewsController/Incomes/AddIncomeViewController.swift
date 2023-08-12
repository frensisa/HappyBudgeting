//
//  AddIncomeViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 23/05/2023.
//

import UIKit
import CoreData

protocol AddIncomeReloadDelegate {
    func reloadTableView(on: Bool)
}

class AddIncomeViewController: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet weak var incomePickerView: UIPickerView!
    @IBOutlet weak var incomeCategoryTextField: UITextField!
    @IBOutlet weak var incomeDescriptionTextField: UITextField!
    @IBOutlet weak var incomeAmountTextField: UITextField!
    
    var incomeCategoryString: String = String()
    var incomeDescriptionString: String = String()
    var incomeAmountDouble: Double = Double()

    var manageObjectContext: NSManagedObjectContext?
    var incomeList = [Income]()
    
    var delegateIncome: AddIncomeReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incomeCategoryTextField.delegate = self
        incomeDescriptionTextField.delegate = self
        incomeAmountTextField.delegate = self
        incomePickerView.dataSource = self
        incomePickerView.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageObjectContext = appDelegate.persistentContainer.viewContext
        
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
        delegateIncome?.reloadTableView(on: true)
        self.dismiss(animated: true)
    }


}


extension AddIncomeViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
}

extension AddIncomeViewController: UIPickerViewDelegate {
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45 // Adjust this value to make the aisle bigger
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40)) // Adjust the width and height to your desired size

        switch row {
        case 0:
            imageView.image = UIImage(named: "a dog")?.resize(to: CGSize(width: 40, height: 40))
        case 1:
            imageView.image = UIImage(named: "groceries")?.resize(to: CGSize(width: 40, height: 40))
        case 2:
            imageView.image = UIImage(named: "gym")?.resize(to: CGSize(width: 40, height: 40))
        case 3:
            imageView.image = UIImage(named: "savings")?.resize(to: CGSize(width: 40, height: 40))
        case 4:
            imageView.image = UIImage(named: "tmybudget")?.resize(to: CGSize(width: 40, height: 40))
        default:
            imageView.image = nil
        }
        return imageView
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
         draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}



