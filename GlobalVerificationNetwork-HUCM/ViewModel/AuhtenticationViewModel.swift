//
//  AuhtenticationViewModel.swift
//  GlobalVerificationNetwork-HUCM
//
import Foundation


/*
 * AuthenticationViewModel class with class method declaration and defination implementaion to handle functionality of AuthenticationServices class.
 */
class AuthenticationViewModel {
  
  /*
  static func parseApiResponseBy(responseData:Data) -> (NetworkResponseStatus, AnyObject){
    
    var responseDict = [String:AnyObject]()
    var responseType = NetworkResponseStatus.None
    
    
    do {
      // Code to serialized json string into json object by NSJSONSerialization class method JSONObjectWithData.
      responseDict = try (JSONSerialization.jsonObject(with: responseData, options: []) as? [String:AnyObject])!
    }
    catch let error as NSError {
      print(error)
    }
    
    if let status = responseDict["status"] as? String{
      if status == "200"{
        responseType = NetworkResponseStatus.Success
      }
      else{
        
      }
    }
    else{
      responseType = NetworkResponseStatus.Failure
    }
    
  }
  */
  
}
