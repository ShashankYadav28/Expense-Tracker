//
//  AddExpenseView.swift
//  Expense Tracker
//
//  Created by Shashank Yadav on 28/01/26.
//

import SwiftUI

struct AddExpenseView: View {
    @State var title:String  = ""
    @State var amount:String  = ""
    @State var date:Date  = Date()
    @State var category:Expense.Category  = .food
    
    let onsave:(String,String,Date,Expense.Category) -> Void
    let onCancel: ()-> Void
    var body: some View {
        NavigationStack {
            Form {
                Section("Details"){
                    TextField("Title", text: $title)
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                    DatePicker("Date ", selection: $date,displayedComponents: [.date,.hourAndMinute])
                }
                Section("Category") {
                    Picker("category Selection", selection: $category) {
                        ForEach(Expense.Category.allCases) { data in
                            Text(data.rawValue.capitalized)
                                .tag(data)
                            
                        }
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onsave(title, amount, date, category)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button() {
                        onCancel()
                        
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
       
        
        
    }
}

#Preview {
    AddExpenseView(
        onsave: { title, amount, date, category in
            print(title)
            print(amount)
            print(date)
            print(category)
        },
           onCancel: {
               print("Cancelled")
           }
       )
}
