//
//  TransactionEntity+CoreDataProperties.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 11.07.2024.
//
//

import Foundation
import CoreData


extension TransactionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
        return NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    }

    @NSManaged public var amount: Double
    @NSManaged public var category: String?
    @NSManaged public var id: UUID?
    @NSManaged public var timestamp: Date?
    @NSManaged public var transactionType: String?

}

extension TransactionEntity : Identifiable {

}
