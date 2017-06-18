//
//  ApplicantDetail+CoreDataProperties.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 02/06/17.
//

import Foundation
import CoreData


extension ApplicantDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ApplicantDetail> {
        return NSFetchRequest<ApplicantDetail>(entityName: "ApplicantDetail")
    }

    @NSManaged public var address: String?
    @NSManaged public var dob: String?
    @NSManaged public var email: String?
    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
    @NSManaged public var middlename: String?
    @NSManaged public var muncipality: String?
    @NSManaged public var postalcode: String?
    @NSManaged public var region: String?
    @NSManaged public var ssn: String?
    @NSManaged public var telephone: String?
    @NSManaged public var order: DraftOrder?

}
