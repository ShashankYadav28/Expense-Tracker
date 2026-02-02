//
//  EmptyView.swift
//  Expense Tracker
//
//  Created by Shashank Yadav on 30/01/26.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack(spacing: 16){
            Image(systemName: "tray")
                .font(.system(size: 75))
            Text("No expenses yet")
                .font(.title)
                .fontWeight(.semibold)
            Text("Tap + to your first expense")
                .font(.body)
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding(.top,60)
    }
}

#Preview {
    EmptyView()
}
