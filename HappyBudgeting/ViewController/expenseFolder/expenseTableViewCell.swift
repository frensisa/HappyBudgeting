//
//  expenseTableViewCell.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 21/05/2023.
//

import UIKit

class expenseTableViewCell: UITableViewCell {

    @IBOutlet weak var expenseCategoryLabel: UILabel!
    @IBOutlet weak var expenceDescriptionLabel: UILabel!
    @IBOutlet weak var expenseImageView: UIImageView!
    @IBOutlet weak var expenseAmountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expenseAmountLabel.layer.cornerRadius = 8
        expenseAmountLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
