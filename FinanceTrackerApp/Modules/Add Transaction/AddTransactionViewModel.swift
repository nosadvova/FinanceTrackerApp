//
//  AddTransactionViewModel.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 09.07.2024.
//

import Foundation

final class AddTransactionViewModel {
    var transactionAmount: Double = 0
    var transactionCategories: [TransactionCategory] = TransactionCategory.allCases
    var chosenCategory: TransactionCategory?
    
    init() {
        
    }
    
    var isButtonActive: Bool {
        chosenCategory != nil && transactionAmount != 0
    }
    
    var tableViewHeight: CGFloat {
        CGFloat(44 * transactionCategories.count)
    }
}
