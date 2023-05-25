//
//  ProfileViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 22/05/2023.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var budgetLabel: UILabel!
    
    var manageObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            manageObjectContext = appDelegate.persistentContainer.viewContext
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.async {
            let budget = self.calculateBudget()
            self.budgetLabel.text = "$\(budget)"
        }
    }

    func calculateBudget() -> Double {
        guard let manageObjectContext = manageObjectContext else {
            return 0.0
        }

        let fetchRequest: NSFetchRequest<Income> = Income.fetchRequest()
        
        do {
            let incomes = try manageObjectContext.fetch(fetchRequest)
            let totalIncome = incomes.reduce(0.0) { $0 + ($1.incomeAmount ) }
            
            let expenseFetchRequest: NSFetchRequest<Spendings> = Spendings.fetchRequest()
            let expenses = try manageObjectContext.fetch(expenseFetchRequest)
            let totalExpenses = expenses.reduce(0.0) { $0 + ($1.expenseAmount ) }
            
            // Calculate the budget
            let budget = totalIncome - totalExpenses
            
            // Update the budget label
            budgetLabel.text = "Your Budget is $\(budget)"
            
            return budget
        } catch {
            print("Failed to fetch incomes or expenses: \(error)")
        }
        
        return 0.0
    }

}
