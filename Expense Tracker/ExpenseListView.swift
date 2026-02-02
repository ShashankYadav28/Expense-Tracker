//
//  ExpenseListView.swift
//  Expense Tracker
//
//  Created by Shashank Yadav on 29/01/26.
//

import SwiftUI

struct ExpenseListView: View {
    let expense:[Expense]
    let onDelete : (UUID) -> Void
    var body: some View {
        List{
                ForEach(expense) { expense in
                    ExpenseRowView(expense: expense, ondelete: onDelete)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            
       
           
        }
        .listRowSpacing(4)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color(.systemGroupedBackground))
        
    }
}

#Preview {
    ExpenseListView(expense:
                        [Expense(amount: 10000,
                                     date: Calendar.current.date(from: DateComponents(year: 2024,month: 03,day:28))! ,
                                     title: "party",
                                     category: .food),
                         Expense(amount: 20000,
                                 date: Calendar.current.date(from: DateComponents(year: 2023,month: 02,day:25))! ,
                                 title: "shopping",
                                 category: .shopping),
                         Expense(amount: 20000,
                                 date: Calendar.current.date(from: DateComponents(year: 2023,month: 02,day:25))! ,
                                 title: "entertainnment",
                                 category: .shopping),
                         Expense(amount: 20000,
                                 date: Calendar.current.date(from: DateComponents(year: 2023,month: 02,day:25))! ,
                                 title: "transport",
                                 category: .transport)
                         
                         
                         
    
                        ], onDelete: { id in
        print("deleted id is ",id)
        
    })
}
