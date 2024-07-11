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
    
    func saveTransaction(_ transaction: TransactionModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "TransactionEntity", in: context)!
        let transactionObject = NSManagedObject(entity: entity, insertInto: context)
        
        transactionObject.setValue(transaction.id, forKey: "id")
        transactionObject.setValue(transaction.amount, forKey: "amount")
        transactionObject.setValue(transaction.timestamp, forKey: "timestamp")
        transactionObject.setValue(transaction.transactionType.rawValue, forKey: "transactionType")
        transactionObject.setValue(transaction.category?.title, forKey: "category")
        
        do {
            try context.save()
        } catch {
            print("Failed to save transaction: \(error)")
        }
    }
    
    func fetchTransactions(offset: Int, limit: Int) -> [TransactionModel] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TransactionEntity")
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
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

