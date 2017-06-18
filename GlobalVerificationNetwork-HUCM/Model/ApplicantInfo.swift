//
//  ApplicantInfo.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 25/05/17.
//

import Foundation


/*
 * ApplicantInfo model class declaration with instance veriable declaration for the ApplicantInfo model class populate for New Screening api Request.
 */
class ApplicantInfo {
  
  var firstName: String?
  
  var lastName: String?

  var middleName: String?

  var ssnNumber: String?

  var dob: String?

  var email: String?

  var address: String?

  var postalCode: String?

  var city: String?

  var state: String?

  
  // MARK:  Default constructor.
  init() {
    // perform default initialization here
    
    firstName = ""
    lastName = ""
    middleName = ""
    ssnNumber = ""
    dob = ""
    email = ""
    address = ""
    postalCode = ""
    city = ""
    state = ""
  }
  
  
}
