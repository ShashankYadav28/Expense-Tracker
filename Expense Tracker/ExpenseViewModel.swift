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
    
    var formattedTotal:String  {
        
        // create a numberformatter
        let formatter = NumberFormatter()
        // tell what kind of formatting
        formatter.numberStyle = .currency
        
        // currencyt symbol for localization
        formatter.currencySymbol = "$"
        // formatter.string return optional we need to hanlde that also and one more thiung we did this formatting because interview perfer
        return formatter.string(from: NSNumber(value: totalCalculation)) ?? "0.00"
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
