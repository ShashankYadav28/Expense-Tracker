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
    @Published var selection:sortOption = .newest
    @Published var selectdCategory:Expense.Category = .all
    @Published var searchTextField = ""
    
    private let keyVariable = "saved_expenses"
    
    init() {
        loadExpenses()
    }
    
    var totalCalculation:Double {
        expenses.reduce(0) { partialResult, expense in
            partialResult+expense.amount
        }
    }
    
    // for this i am making the one computed property will return taht
    
    var displayExpense:[Expense] {
        var result = expenses
        
        
        if (selectdCategory != .all) {
          
                result = result.filter {
                    $0.category == selectdCategory
                }
            
        }
        
        if !searchTextField.isEmpty {
            result  = result.filter({
                $0.title.lowercased().contains(searchTextField.lowercased())
            })
        }
        
        switch selection {
        case .newest:
            result  = result.sorted(by: { previousResult, currentResult in
                previousResult.date>currentResult.date
            })
        case .oldest:
            result  = result.sorted(by: { previousResult, currentResult in
                previousResult.date<currentResult.date
            })

        case .highestAmount:
            result  = result.sorted(by: { previousResult, currentResult in
                previousResult.amount>currentResult.amount
            })
        case .lowestAmount:
            result  = result.sorted(by: { previousResult, currentResult in
                previousResult.amount<currentResult.amount
            })
        }
        
        return result 
        
    }
    
    
//    var filteredExpenses:[Expense] {
//        if selectdCategory == .all {
//            return expenses
//        }
//        else {
//            return expenses.filter {
//                $0.category == selectdCategory
//            }
//        }
//    }
//    
//    var searchExpenses:[Expense] {
//        if searchTextField.isEmpty {
//            return filteredExpenses
//        }
//        else {
//            
//           return  filteredExpenses.filter {
//                $0.title.lowercased().contains(
//                    searchTextField.lowercased()
//                )
//            }
//        
//        }
//        
//    }
//    
//    var sortedExpenses:[Expense] {
//        switch selection {
//        case .newest:
//            return searchExpenses.sorted { previousExpense, currentExpense in
//                previousExpense.date>currentExpense.date
//            }
//        case .oldest:
//            return searchExpenses.sorted {
//                $0.date<$1.date
//            }
//        case .highestAmount:
//            return searchExpenses.sorted {
//                $0.amount>$1.amount
//            }
//        case .lowestAmount:
//            return searchExpenses.sorted {
//                $0.amount<$1.amount
//            }
//        }
//        
//    }
    
    var groupedExpenses:[(date:Date,expenses:[Expense])] {
        let current = Calendar.current  // itt gives acces to calender utilities and properties
        let grouped = Dictionary(grouping: displayExpense) { element in
            current.startOfDay(for: element.date) // caledar property startday is used so that i can remove the time if it not done then even on the same day with different time will be consider as a different key and expenses
        }
        return grouped
            .map {
            (date:$0.key,expenses:$0.value)
                
        
        }
            .sorted { first, second in
                first.date>second.date
                
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
    
    func formattedDate(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM YYYY";
        return formatter.string(from: date)
    }
    
    func addExpense(amount:Double , title:String , date:Date , category:Expense.Category) {
        let newExpense = Expense(amount: amount, date: date, title: title, category: category)
        expenses.append(newExpense)
        saveExpenses()
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
    
    func deleteExpense(at id:UUID) {
//        expenses.removeAll { expense in
//            expense.id == id
//            
//        }
        guard let index = expenses.firstIndex(where: { expense in
            expense.id == id;
        }) else {
            return ;
        }
        expenses.remove(at: index)
        saveExpenses()
        
    }
}

extension ExpenseViewModel {
    enum sortOption :String ,Identifiable,CaseIterable {
        var id:String  {
            rawValue
        }
        case newest
        case oldest
        case highestAmount
        case lowestAmount
    }
}
