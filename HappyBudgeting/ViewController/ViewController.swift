//
//  ViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 21/05/2023.
//

import UIKit

class ViewController: UIViewController {

    var expenses = [expenseModule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenses = expenseModule.getExpenses()
        //UITabBar.appearance().barTintColor = UIColor.black
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? expenseTableViewCell
        else { return UITableViewCell()}
        
        let expense = expenses[indexPath.row]
        
        cell.expenseCategoryLabel.text = expense.expenseCategory
        cell.expenseImageView.image = UIImage(named: expense.expenseIcon)
        cell.expenseAmountLabel.text = "$\(expense.expenseAmount)"
        cell.expenceDescriptionLabel.text = expense.expenseDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Your Budget is $895"
    }
}



