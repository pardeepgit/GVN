//
//  ScreeningRequestServices.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 15/06/17.
//

import Foundation


/*
 Screening Request Type Type enumeration....
 Enum types are Login, SignUp, ForgotPassword and ....
 */
enum ScreeningRequestType {
  case NewScreeningRequest
}



typealias ScreeningServiceCompletion = (NetworkResponseStatus, Any) -> ()



/*
 * ScreeningRequestServices class with class method declaration and defination implementaion to handle functionality of TazWorks XML Api request services.
 */
class ScreeningRequestServices{

  
  // MARK:  authUserWith method.
  class func newScreeningRequestWith(requestXml: String, serviceType:ScreeningRequestType ,completion: @escaping ScreeningServiceCompletion) {
    let apiRequest = ScreeningRequestServices.prepareScreeningRequestHeaderFor(type: serviceType, withRequestXml: requestXml)
    
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
  class func prepareScreeningRequestHeaderFor(type: ScreeningRequestType, withRequestXml requestXml: String) -> NSURLRequest {
    var apiUrl = ""
    switch type {
      
    case ScreeningRequestType.NewScreeningRequest:
      apiUrl = String(format: "%@", TAZWORKAPIURL)
    }
    
    let apiRequest = NSMutableURLRequest(url: NSURL(string: apiUrl)! as URL)
    apiRequest.httpMethod = POST
    apiRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    apiRequest.addValue("application/xml", forHTTPHeaderField: "Content-Type")
    apiRequest.httpBody = requestXml.data(using: String.Encoding.utf8)
    
    return apiRequest
  }

  
}
