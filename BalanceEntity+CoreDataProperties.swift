//
//  BalanceEntity+CoreDataProperties.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 11.07.2024.
//
//

import Foundation
import CoreData


extension BalanceEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BalanceEntity> {
        return NSFetchRequest<BalanceEntity>(entityName: "BalanceEntity")
    }

    @NSManaged public var balance: Double

}

extension BalanceEntity : Identifiable {

}
