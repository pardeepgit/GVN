//
//  DriverInfo.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 25/05/17.
//

import Foundation


/*
 * DriverInfo model class declaration with instance veriable declaration for the DriverInfo model class populate for New Screening api Request.
 */
class DriverInfo {
  
  var licenseState: String?
  
  var licenseDuration: String?

  var licenseNumber: String?

  
  // MARK:  Default constructor.
  init() {
    // perform default initialization here
    
    licenseState = ""
    licenseDuration = ""
    licenseNumber = ""
  }
  
}
