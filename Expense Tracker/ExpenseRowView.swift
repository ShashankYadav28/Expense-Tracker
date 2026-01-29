//
//  ExpenseRowView.swift
//  Expense Tracker
//
//  Created by Shashank Yadav on 29/01/26.
//

import SwiftUI

struct ExpenseRowView: View {
    let expense:Expense
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(expense.title)
                    .font(.headline)
                Text(expense.category.rawValue.capitalized)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(expense.date,style: .date)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text("$\(expense.amount,specifier:"%.2f")")
                .font(.headline)
                .fontWeight(.medium)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            Color(.secondarySystemBackground)
        )
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
        .padding(.horizontal)
    }
}

#Preview {
    ExpenseRowView(expense:Expense(amount: 10000, date: Date(), title: "Party", category: .food) )
}
