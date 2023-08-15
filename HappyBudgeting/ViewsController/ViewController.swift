//
//  ViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 21/05/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, AddExpenseReloadDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var manageObjectContext: NSManagedObjectContext?
    var expenseList = [Spendings]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool){

    }
    
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "To delete an expense, swipe it left!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    func loadData() {
        guard let manageObjectContext = manageObjectContext else {
            return
        }

        let fetchRequest: NSFetchRequest<Spendings> = Spendings.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "expenseDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            expenseList = try manageObjectContext.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Failed to fetch expenses: \(error)")
        }
    }

    func calculateTotalSpent() -> Double {
        var totalAmount: Double = 0
        
        for expense in expenseList {
            totalAmount += expense.expenseAmount
        }
        
        return totalAmount
    }
    
    func reloadTabeView(on: Bool) {
        if on {
            DispatchQueue.main.async {
                self.loadData()
            }
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save" {
            let vc = segue.destination as! AddViewController
            vc.delegate = self
        }
    }
    
}//class ends

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExpenseTableViewCell
        else { return UITableViewCell()}
        
        let expense = expenseList[indexPath.row]
        
        cell.expenseCategoryLabel.text = expense.expenseCategory
        cell.expenseImageView.image = UIImage(named: expense.expenseIconName ?? "placeholder_icon")?.resizeExpense(to: CGSize(width: 40, height: 40))
        cell.expenseAmountLabel.text = "$\(expense.expenseAmount)"
        cell.expenceDescriptionLabel.text = expense.expenseDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let totalSpent = calculateTotalSpent()
        return "You have spent $\(totalSpent)"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Create a confirmation alert
                let confirmationAlert = UIAlertController(title: "Are you sure you want to delete?", message: "This action is irreversible!", preferredStyle: .alert)
                
                // Add a "Yes" action to delete the item
                confirmationAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self] (_) in
                    // Handle the deletion action
                    
                    // 1. Get the expense item to be deleted
                    let expense = self.expenseList[indexPath.row]
                    
                    // 2. Delete the expense item from the context
                    manageObjectContext?.delete(expense)
                    
                    // 3. Save the changes
                    do {
                        try manageObjectContext?.save()
                    } catch {
                        print("Failed to delete expense: \(error)")
                    }
                    
                    // 4. Remove the expense item from the expenseList array
                    expenseList.remove(at: indexPath.row)
                    
                    // 5. Delete the table view cell
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    
                    // 6. Update the section header with the new total spent amount
                    tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }))
                
                // Add a "Cancel" action to dismiss the alert
                confirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                // Present the confirmation alert
                present(confirmationAlert, animated: true, completion: nil)
            }
        }
}



