//
//  User.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 20/04/17.
//

import Foundation


/*
 * User model class declaration with instance veriable declaration for the User model class populate from LoginService api response.
 */
class User {
  
  var userId: String?
  
  var firstName: String?
  
  var lastName: String?
  
  
  // MARK:  Default constructor.
  init() {
    // perform default initialization here
    
    userId = ""
    firstName = ""
    lastName = ""
  }
  
}
