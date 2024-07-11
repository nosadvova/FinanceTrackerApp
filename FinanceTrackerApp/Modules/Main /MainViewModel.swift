//
//  MainViewModel.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 09.07.2024.
//

import Foundation

final class MainViewModel {
    var transactions: [TransactionModel] = []
    var userBalance: Balance = Balance(balance: 0.0045)
    
    var currentOffset = 0
    let limit = 20
    var isFetchingMore = false
    
    init(transactions: [TransactionModel], userBalance: Balance) {
        self.transactions = transactions
        self.userBalance = userBalance
    }
    
    func addFunds(_ amount: Double) {
        userBalance.balance += amount
    }
    
    var userBalanceText: String {
        "Balance: \(userBalance.balance.formattedToDecimalPlaces(to: 4)) BTC"
    }
}
