//
//  expensesModule.swift
//  HappyBudgeting
//
//  Created by frensisa daudze on 22/05/2023.
//

import Foundation

struct expenseModule{
    let expenseDescription: String
    let expenseCategory: String
    let expenseAmount: Int
    let expenseIcon: String
    
    static func getExpenses() -> [expenseModule]{
        let expense1 = expenseModule(
            expenseDescription: "Dog School",
            expenseCategory: "Pets",
            expenseAmount: 50,
            expenseIcon: "a dog")
        
        let expense2 = expenseModule(
            expenseDescription: "Membership",
            expenseCategory: "Gym",
            expenseAmount: 30,
            expenseIcon: "gym")
        
        let expense3 = expenseModule(
            expenseDescription: "Dinner",
            expenseCategory: "Groceries",
            expenseAmount: 15,
            expenseIcon: "groceries")
        
        let expense4 = expenseModule(
            expenseDescription: "Gift from Grandma",
            expenseCategory: "Savings",
            expenseAmount: 10,
            expenseIcon: "savings")
        
        let expenses = [expense1, expense2, expense3, expense4]
        
        return expenses
    }
}
