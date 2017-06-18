//
//  DraftOrder+CoreDataProperties.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 02/06/17.
//

import Foundation
import CoreData


extension DraftOrder {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<DraftOrder> {
    return NSFetchRequest<DraftOrder>(entityName: "DraftOrder")
  }
  
  @NSManaged public var saveddraftdate: String?
  @NSManaged public var isdriversearch: Int64
  @NSManaged public var packagetype: Int64
  @NSManaged public var status: Int64
  @NSManaged public var applicantsearch: ApplicantDetail?
  @NSManaged public var driversearch: DriverDetail?
  
}
