//
//  TotalCardView.swift
//  Expense Tracker
//
//  Created by Shashank Yadav on 26/01/26.
//

import SwiftUI

struct TotalCardView: View {
    let total:String
    var body: some View {
        VStack(alignment: .center,spacing: 6) {
            Text("Total spent")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(total)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 16, height: 16))
                .fill(Color(.secondarySystemBackground))
        )
        .padding(.horizontal,20)
    }
}

#Preview {
    TotalCardView(total: "Total")
}
