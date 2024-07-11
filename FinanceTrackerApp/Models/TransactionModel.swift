//
//  Transaction.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 09.07.2024.
//

import UIKit

struct TransactionModel: Identifiable {
    var id: UUID
    var transactionType: TransactionType
    var timestamp: Date
    var amount: Double
    var category: TransactionCategory?
    
    init(
        id: UUID,
        transactionType: TransactionType,
        timestamp: Date,
        amount: Double,
        category: TransactionCategory? = nil
    ) {
        self.id = id
        self.transactionType = transactionType
        self.timestamp = timestamp
        self.amount = amount
        self.category = category
    }
}

enum TransactionType: String {
    case recieve = "Recieved"
    case spend = "Spent"
    
    var image: String {
        switch self {
        case .recieve:
            "arrow.down.backward"
        case .spend:
            "arrow.up.right"
        }
    }
}

enum TransactionCategory: String, CaseIterable {
    case groceries = "Groceries"
    case taxi = "Taxi"
    case electronics = "Electronics"
    case restaurant = "Restaurant"
    case other = "Other"
    
    var title: String {
        self.rawValue
    }
    
    var image: String {
        switch self {
        case .groceries:
            "basket.fill"
        case .taxi:
            "car.fill"
        case .electronics:
            "tv"
        case .restaurant:
            "fork.knife.circle.fill"
        case .other:
            "ellipsis.circle.fill"
        }
    }
}
