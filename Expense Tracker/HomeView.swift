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
            List{
                    TotalCardView(total: expenseViewModel.formattedTotal)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                    
                        if expenseViewModel.expenses.isEmpty {
                            VStack(spacing: 16){
                                Image(systemName: "tray")
                                    .font(.system(size: 75))
                                Text("No expenses yet")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                Text("Tap + to your first expense")
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        else {
                            GroupedListContentView(groupedExpenses: expenseViewModel.groupedExpenses) { id  in
                                expenseViewModel.deleteExpense(at: id)
                            } formattedDate: { date in
                                expenseViewModel.formattedDate(date: date)
                            }

                        }
                }
            .safeAreaInset(edge: .bottom, content: {
                AddExpenseViewButton(onTap: {
                    addExpenseScreen = true
                })
                .padding(.horizontal,16)
                .padding(.top,8)
                .background(.ultraThinMaterial)
                   
            })
            .listRowSpacing(10)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(
                    Color(.systemGroupedBackground)
                )
                .navigationTitle("Expenses")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu {
                            Picker("sorted selection", selection: $expenseViewModel.selection) {
                                ForEach(ExpenseViewModel.sortOption.allCases) { data in
                                    Text(data.rawValue)
                                        .tag(data)
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                    }
                })
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Category Selection", selection: $expenseViewModel.selectdCategory) {
                                ForEach(Expense.Category.allCases) { category in
                                    Text(category.rawValue)
                                        .tag(category)
                                }
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }
                    }
                }
                .searchable(text: $expenseViewModel.searchTextField, placement: .navigationBarDrawer, prompt: "Search Expenses")
            
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

struct GroupedListContentView: View {
    let groupedExpenses:[(date:Date,expenses:[Expense])]
    let  onDelete:(UUID) -> Void
    let  formattedDate:(Date) -> String
    var body:some View {
        ForEach(groupedExpenses,id:\.date) { group in
            Section {
                ForEach(group.expenses) { expense in
                    ExpenseRowView(expense: expense) { id in
                        onDelete(id)
                    }
//                                        .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                    
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                //                                .listRowInsets(EdgeInsets())
            } header: {
                Text(formattedDate(group.date))
                    .font(.caption)
                    .foregroundStyle(.primary)
                
            }
        }
        
    }
}

#Preview {
    HomeView()
}
