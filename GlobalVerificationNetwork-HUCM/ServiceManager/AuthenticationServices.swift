//
//  AuthenticationServices.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 13/06/17.
//

import Foundation

/*
 User Auth Api Request Type Type enumeration....
 Enum types are Login, SignUp, ForgotPassword and ....
 */
enum UserAuthApiRequestType {
  case Login
  case SignUp
  case ForgotPassword
}




/*
 * AuthenticationServices class with class method declaration and defination implementaion to handle functionality of Login api endpoint.
 */
class AuthenticationServices{
  
  // MARK:  authUserWith method.
  class func authUserWith(inputFields: [ String: String], serviceType:UserAuthApiRequestType ,completion: @escaping LoginServiceCompletion) {
    let apiRequest = AuthenticationServices.prepareRequestHeaderFor(type: serviceType, withRequestDict: inputFields)
    
    let session = URLSession.shared
    let task = session.dataTask(with: apiRequest as URLRequest, completionHandler: {data, response, error -> Void in
      
      // 1. Validate response by httpStatusCode
      let apiStatus = UtilManager.sharedInstance.validateNetworkResponseHttpStatusCodeBy(response: response!)
      switch apiStatus {
      case NetworkResponseStatus.NetworkSuccess:
        
        // 1. Validate response by Api Response Data
        let validateResponseStatusTupple = UtilManager.sharedInstance.validateNetworkResponseBy(response: data!)
        let validateResponseStatus = validateResponseStatusTupple.0
        let responseMsg = validateResponseStatusTupple.1
        if validateResponseStatus == NetworkResponseStatus.Success{ // For Success
          
          // 2. 200 than parse Data response by ViewModel class
          
          
          // 3. Hit Completion Block to the Corresponding controller.
          completion(validateResponseStatus, responseMsg)
        }
        else{
          // 3. Hit Completion Block to the Corresponding controller.
          completion(validateResponseStatus, responseMsg)
        }
        break
        
      case NetworkResponseStatus.NetworkError:
        // 3. Hit Completion Block to the Corresponding controller.
        completion(apiStatus, "Server not found")
        break
        
      default:
        print("")
      }
      
      
      
    })
    task.resume()
  }
  
  
  // MARK:  prepareRequestHeaderFor method.
  class func prepareRequestHeaderFor(type: UserAuthApiRequestType, withRequestDict inputFields: [ String: String]) -> NSURLRequest {
    var apiUrl = ""
    switch type {
    case UserAuthApiRequestType.Login:
      apiUrl = String(format: "%@/%@", APIBASEURL, SIGNINMETHOD)
      
    case UserAuthApiRequestType.SignUp:
      apiUrl = String(format: "%@/%@", APIBASEURL, REGISTERMETHOD)
      
    case UserAuthApiRequestType.ForgotPassword:
      apiUrl = String(format: "%@/%@", APIBASEURL, SIGNINMETHOD)
    }
    
    let apiRequest = NSMutableURLRequest(url: NSURL(string: apiUrl)! as URL)
    apiRequest.httpMethod = POST
    apiRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: inputFields, options: .prettyPrinted)
      apiRequest.httpBody = jsonData
    }
    catch let error as NSError {
      print(error)
    }
    
    return apiRequest
  }
  
}
