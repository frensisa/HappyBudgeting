//
//  incomeModule.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 22/05/2023.
//

import Foundation

struct incomeModule{
    
    let incomeDescription: String
    let incomeCategory: String
    let incomeAmount: Int
    
    static func getIncome() -> [incomeModule]{
        let income1 = incomeModule(
            incomeDescription: "Salary",
            incomeCategory: "part time job",
            incomeAmount: 200)
        
        let income2 = incomeModule(
            incomeDescription: "From Grandma",
            incomeCategory: "Gifts",
            incomeAmount: 10)
        
        let income3 = incomeModule(
            incomeDescription: "Rent from Tenants",
            incomeCategory: "Passive income",
            incomeAmount: 500)
        
        let income4 = incomeModule(
            incomeDescription: "Salary",
            incomeCategory: "part time job",
            incomeAmount: 290)
        
        let income = [income1, income2, income3, income4]
        
        return income
    }
    
}
