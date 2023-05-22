//
//  incomeTableViewCell.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 22/05/2023.
//

import UIKit

class incomeTableViewCell: UITableViewCell {

    @IBOutlet weak var incomeDescriptionLabel: UILabel!
    @IBOutlet weak var incomeCategoryLabel: UILabel!
    @IBOutlet weak var incomeAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        incomeAmountLabel.layer.cornerRadius = 8
        incomeAmountLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
