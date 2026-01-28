//
//  HomeView.swift
//  Expense Tracker
//
//  Created by Shashank Yadav on 27/01/26.
//

import SwiftUI

struct HomeView:View {
    @StateObject var expenseViewModel = ExpenseViewModel()
    var body: some View {
        TotalCardView(total: expenseViewModel.formattedTotal)
    }
}
#Preview {
    HomeView()
}
