//
//  AddExpenseViewButton.swift
//  Expense Tracker
//
//  Created by Shashank Yadav on 27/01/26.
//

import SwiftUI

struct AddExpenseViewButton:View {
    let onTap:() -> Void
    var body: some View {
        Button(action:onTap) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Add Expense")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                Color.blue
            )
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
            .padding()
            .foregroundStyle(.white)
            
        }
    

    }
}
#Preview {
    AddExpenseViewButton(onTap: {print("tapped")})
}
