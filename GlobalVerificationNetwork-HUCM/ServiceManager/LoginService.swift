//
//  LoginService.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 20/04/17.
//

import Foundation

typealias LoginServiceCompletion = (NetworkResponseStatus, Any) -> ()



/*
 * LoginService class with class method declaration and defination implementaion to handle functionality of Login api endpoint.
 */
class LoginService{

  // MARK:  authUserWith method.
  class func authUserWith(inputFields: [ String: String], completion: LoginServiceCompletion) {
    let apiUrl = String(format: "%@/%@", APIBASEURL, SIGNINMETHOD)
    let apiRequest = NSMutableURLRequest(url: NSURL(string: apiUrl)! as URL)
    let session = URLSession.shared
    // var err: NSError?
    
    apiRequest.httpMethod = POST
    apiRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: inputFields, options: .prettyPrinted)
      apiRequest.httpBody = jsonData
    }
    catch let error as NSError {
      print(error)
    }
    
    let task = session.dataTask(with: apiRequest as URLRequest, completionHandler: {data, response, error -> Void in
      if let httpResponse = response as? HTTPURLResponse {
        print("statusCode: \(httpResponse.statusCode)")
      }
      // 1. Validate response by httpStatusCode
      
      // 2. 200 than parse Data response by ViewModel class 
      
      // 3. Hit Completion Block to the Corresponding controller.      
      
    })
    task.resume()
  }

}
