//
//  IncomeViewController.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 22/05/2023.
//

import UIKit

class IncomeViewController: UIViewController {
    
    var income = [incomeModule]()

    override func viewDidLoad() {
        super.viewDidLoad()

        income = incomeModule.getIncome()
        
    }
}


//@IBOutlet weak var incomeDescriptionLabel: UILabel!
//@IBOutlet weak var incomeCategoryLabel: UILabel!
//@IBOutlet weak var incomeAmountLabel: UILabel!


extension IncomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as? incomeTableViewCell
        else { return UITableViewCell()}
        
        let income = income[indexPath.row]
        
        cell.incomeCategoryLabel.text = income.incomeCategory
        cell.incomeAmountLabel.text = "$\(income.incomeAmount)"
        cell.incomeDescriptionLabel.text = income.incomeDescription
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Your Budget is $1000"
    }
}
