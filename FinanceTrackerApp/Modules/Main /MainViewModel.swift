//
//  MainViewModel.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 09.07.2024.
//

import Foundation

final class MainViewModel {
    var transactions: [Transaction]
    var userBalance: Balance
    
    init(transactions: [Transaction], userBalance: Balance) {
        self.transactions = transactions
        self.userBalance = userBalance
    }
}
