//
//  DriverDetail+CoreDataProperties.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 02/06/17.
//

import Foundation
import CoreData


extension DriverDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DriverDetail> {
        return NSFetchRequest<DriverDetail>(entityName: "DriverDetail")
    }

    @NSManaged public var licenseduration: String?
    @NSManaged public var licensenumber: String?
    @NSManaged public var licensestate: String?
    @NSManaged public var order: DraftOrder?

}
