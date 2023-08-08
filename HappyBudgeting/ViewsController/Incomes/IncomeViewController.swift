//
//  IncomeViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 22/05/2023.
//

import UIKit
import CoreData

class IncomeViewController: UIViewController, AddIncomeReloadDelegate {
    
    @IBOutlet weak var incomeTableView: UITableView!

    var manageObjectContext: NSManagedObjectContext?
    var incomeList = [Income]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool){

    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "To delete an income, swipe it left!", preferredStyle: .alert)
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

        let fetchRequest: NSFetchRequest<Income> = Income.fetchRequest()

        do {
            incomeList = try manageObjectContext.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.incomeTableView.reloadData()
            }
        } catch {
            print("Failed to fetch expenses: \(error)")
        }
    }
    
    func calculateTotalIncome() -> Double {
        var totalIncomeAmount: Double = 0
        
        for income in incomeList {
            totalIncomeAmount += income.incomeAmount
        }
        
        return totalIncomeAmount
    }
    func reloadTableView(on: Bool) {
        if on {
            DispatchQueue.main.async {
                self.loadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "incomeSave" {
            let vc = segue.destination as! AddIncomeViewController
            vc.delegateIncome = self
        }
    }
    
}//class ends



extension IncomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as? IncomeTableViewCell
        else { return UITableViewCell()}
        
        let income = incomeList[indexPath.row]
        
        cell.incomeCategoryLabel.text = income.incomeCategory
        cell.incomeAmountLabel.text = "$\(income.incomeAmount)"
        cell.incomeDescriptionLabel.text = income.incomeDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let totalIncome = calculateTotalIncome()
        return "Your income is $\(totalIncome)"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                
                let confirmationAlert = UIAlertController(title: "Are you sure you want to delete?", message: "This action is irreversible!", preferredStyle: .alert)
                
                confirmationAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self] (_) in
                    
                    let income = self.incomeList[indexPath.row]
                    
                    manageObjectContext?.delete(income)
                    
                    do {
                        try manageObjectContext?.save()
                    } catch {
                        print("Failed to delete expense: \(error)")
                    }
                    
                    incomeList.remove(at: indexPath.row)
                    
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }))
                
                confirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                present(confirmationAlert, animated: true, completion: nil)
            }
        }
}
