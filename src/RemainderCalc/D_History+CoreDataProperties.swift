//
//  D_History+CoreDataProperties.swift
//  


import Foundation
import CoreData


extension D_History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<D_History> {
        return NSFetchRequest<D_History>(entityName: "D_History")
    }

    @NSManaged public var m_i_answer: String?
    @NSManaged public var m_i_decimal_position: Int16
    @NSManaged public var m_i_dividend: NSDecimalNumber?
    @NSManaged public var m_i_divisor: NSDecimalNumber?
    @NSManaged public var m_i_expression: String?
    @NSManaged public var m_k_update_time: Date
}
