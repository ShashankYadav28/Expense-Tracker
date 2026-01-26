//
//  ExpenseViewModel.swift
//  Expense Tracker
//
//  Created by Shashank Yadav on 25/01/26.
//

import Foundation
import Combine

class ExpenseViewModel :ObservableObject {
    
    @Published var expenses:[Expense] = []
    private let keyVariable = "saved_expenses"
    
    init() {
        loadExpenses()
    }
    
    var totalCalculation:Double {
        expenses.reduce(0) { partialResult, expense in
            partialResult+expense.amount
        }
    }
    
    func addExpense(amount:Double , title:String , date:Date , category:Expense.Category) {
        let newExpense = Expense(amount: amount, date: date, title: title, category: category)
        expenses.append(newExpense)
    }
    
    
    func saveExpenses() {
        do {
            let data  =  try JSONEncoder().encode(expenses)
            UserDefaults.standard.set(data, forKey: keyVariable)
        }
        catch  {
            print("Error in Encoding \(error)")
        }
        
    }
    
    func loadExpenses() {
        guard let data  = UserDefaults.standard.data(forKey: keyVariable) else {
            return
        }
        do {
            let decodedExpense  =  try JSONDecoder().decode([Expense].self, from: data)
            expenses = decodedExpense
        }
        catch  {
            print("Decoding Error is coming \(error)")
        }
    }
    
    func deleteExpense() {
        
    }
    
}
