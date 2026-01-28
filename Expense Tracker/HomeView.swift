//
//  HomeView.swift
//  Expense Tracker
//
//  Created by Shashank Yadav on 27/01/26.
//

import SwiftUI

struct HomeView:View {
    @StateObject var expenseViewModel = ExpenseViewModel()
//    @State private var showAddExpense = false
    @State var addExpenseScreen = false
    var body: some View {
        NavigationStack {
            TotalCardView(total: expenseViewModel.formattedTotal)
            AddExpenseViewButton {
                addExpenseScreen = true
            }
        }
        .sheet(isPresented: $addExpenseScreen) {
            AddExpenseView { title, amount, date, expense in
                guard let doubleAmount  = Double(amount) else {
                    print("cannot convert the type ")
                    return
                }
                expenseViewModel.addExpense(amount: doubleAmount , title: title, date: date, category: expense)
                addExpenseScreen = false
            } onCancel: {
                addExpenseScreen = false
            }

        }
       
    }
}
#Preview {
    HomeView()
}
