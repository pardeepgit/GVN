//
//  ScreeningRequest.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 25/05/17.
//

import Foundation


/*
 * ScreeningRequest model class declaration with instance veriable declaration for the ScreeningRequest model class populate from New Screening api Request.
 */
class ScreeningRequest {
  
  var applicantInfo: ApplicantInfo?

  var driverInfo: DriverInfo?

  var screeningPackageType: ScreeningSearchPackagesType?

  var verificationServiceFlag: Bool?
  
  var isScreeningRequestInProcess: Bool?
  
  /*
   * Method to design Singleton design pattern for ScreeningRequest class.
   * Create singleton instance by global and constant variable declaration.
   */
  class var sharedInstance: ScreeningRequest {
    struct Singleton {
      static let instance = ScreeningRequest()
    }
    return Singleton.instance
  }
  
  
  // MARK:  Default constructor.
  private init() {
    // perform default initialization here
    
    applicantInfo = ApplicantInfo()
    driverInfo = DriverInfo()
    verificationServiceFlag = false
    screeningPackageType = ScreeningSearchPackagesType.None
    
    isScreeningRequestInProcess = false
  }
  
}
