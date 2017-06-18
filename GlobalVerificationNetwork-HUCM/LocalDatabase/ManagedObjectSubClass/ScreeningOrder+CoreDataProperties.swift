//
//  ScreeningOrder+CoreDataProperties.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 05/06/17.
//

import Foundation
import CoreData


extension ScreeningOrder {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ScreeningOrder> {
    return NSFetchRequest<ScreeningOrder>(entityName: "ScreeningOrder")
  }

  @NSManaged public var packagetype: String?
  @NSManaged public var fee: String?
  @NSManaged public var orderdate: String?
  @NSManaged public var ordertime: String?
  @NSManaged public var xmlrequest: String?
  @NSManaged public var xmlresponse: String?
  
}
