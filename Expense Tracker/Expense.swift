//
//  Expense.swift
//  Expense Tracker
//
//  Created by Shashank Yadav on 25/01/26.
//

import Foundation

struct Expense:Identifiable,Codable {
    let id  = UUID()
    let amount:Double
    let date:Date
    let title:String
    let category:Category
    
    enum Category:String, Identifiable,CaseIterable,Codable {
        
        var id:String  {
            rawValue
        }
        case shopping
        case food
        case bills
        case entertainment
        case transport
    }
    
    
}
