//
//  CoreDataManager.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 11.07.2024.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to get shared app delegate")
        }
        return appDelegate.persistentContainer.viewContext
    }

    func fetchTransactions() -> [TransactionModel] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TransactionEntity")
        do {
            let savedTransactions = try context.fetch(fetchRequest)
            let transactions = savedTransactions.map { (managedObject) -> TransactionModel in
                let id = managedObject.value(forKey: "id") as? UUID ?? UUID()
                let amount = managedObject.value(forKey: "amount") as? Double ?? 0.0
                let timestamp = managedObject.value(forKey: "timestamp") as? Date ?? Date()
                let transactionTypeRaw = managedObject.value(forKey: "transactionType") as? String ?? "spend"
                let categoryTitle = managedObject.value(forKey: "category") as? String
                
                let transactionType = TransactionType(rawValue: transactionTypeRaw) ?? .spend
                let category = TransactionCategory.allCases.first(where: { $0.title == categoryTitle })
                
                return TransactionModel(
                    id: id,
                    transactionType: transactionType,
                    timestamp: timestamp,
                    amount: amount,
                    category: category
                )
            }
            return transactions
        } catch {
            print("Failed to fetch transactions: \(error)")
            return []
        }
    }

    func fetchBalance() -> Double? {
        let fetchRequest: NSFetchRequest<BalanceEntity> = BalanceEntity.fetchRequest()
        do {
            let balanceEntities = try context.fetch(fetchRequest)
            return balanceEntities.first?.balance
        } catch {
            print("Failed to fetch balance: \(error)")
            return nil
        }
    }

    func saveBalance(_ balance: Double) {
        let fetchRequest: NSFetchRequest<BalanceEntity> = BalanceEntity.fetchRequest()
        do {
            let balanceEntities = try context.fetch(fetchRequest)
            let balanceEntity = balanceEntities.first ?? BalanceEntity(context: context)
            balanceEntity.balance = balance
            try context.save()
        } catch {
            print("Failed to save balance: \(error)")
        }
    }
}

