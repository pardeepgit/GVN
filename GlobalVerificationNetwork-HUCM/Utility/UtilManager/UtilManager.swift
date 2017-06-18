//
//  UtilManager.swift
//
//

import UIKit




/*
 Network request execution Type enumeration....
 Enum types are Success, Failure, NetworkSuccess and NetworkError....
 */
enum NetworkResponseStatus {
  case Success
  case Failure
  case NetworkSuccess
  case NetworkError
  case None
}




class UtilManager: NSObject {
  
  /*
   * Method to design Singleton design pattern for UtilManager class.
   * Create singleton instance by global and constant variable declaration.
   */
  class var sharedInstance: UtilManager {
    struct Singleton {
      static let instance = UtilManager()
    }
    return Singleton.instance
  }
  
  
  // MARK:  default initializer.
  private override init() {
    super.init()
    // Code to force non-instantiate from outside class
  }
  
  
  /*
   * isValidEmail method to validate parameter email address to return true of false.
   */
  // MARK:  isValidEmail method.
  func isValidEmail(emailStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: emailStr)
  }
  
  
  
  
  /*
   * loaderConfig method to set configuration of Swift progress loader.
   */
  // MARK:  loaderConfig method.
  func loaderConfig(){
    var config : SwiftLoader.Config = SwiftLoader.Config()
    config.backgroundColor = UIColor(red: 59/255, green: 164/255, blue: 220/255, alpha: 1.0)
    config.spinnerColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    config.titleTextColor = UIColor(red:0.88, green:0.26, blue:0.18, alpha:1)
    config.spinnerLineWidth = 2.0
    config.foregroundColor = UIColor.black
    config.foregroundAlpha = 0.5
    SwiftLoader.setConfig(config)
  }
  
  
  
  // MARK:  ------------------------------  Date to String and String to Date conversion  -------------------------------.
  /*
   @discussion     This methods is used to convert Date object into String type from conversion.
   @paramters      date of Date type to convert into date string and formatedString is date formatter string.
   @return             String type of date converted from Date object to date string.
   */
  func changeDateStringFormatterForDateString(dateString: String, byDateFormattedString formatedString: String, toRequiredFormat requiredFormatString: String) -> String {
    var changeFormatterDateString = ""
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formatedString
    dateFormatter.locale = Locale.current
    let date = dateFormatter.date(from:dateString)

    dateFormatter.dateFormat = requiredFormatString
    dateFormatter.locale = Locale.current
    changeFormatterDateString = dateFormatter.string(from:date!)

    return changeFormatterDateString
  }

  
  
  /*
   @discussion     This methods is used to convert Date object into String type from conversion.
   @paramters      date of Date type to convert into date string and formatedString is date formatter string.
   @return             String type of date converted from Date object to date string.
   */
  func getDateStringFromDateObject(date: Date, byDateFormattedString formatedString: String) -> String {
    var dateString = ""

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formatedString
    dateFormatter.locale = Locale.current
    dateString = dateFormatter.string(from:date as Date)

    return dateString
  }
  
  /*
   @discussion     This methods is used to convert String type into Date Obkect from conversion.
   @paramters      dateString of String type to convert into Date Object and formatedString is date formatter string.
   @return             Date type of date converted from String type to Date type.
   */
  func getDateObjectFromDateString(dateString: String, byDateFormattedString formatedString: String) -> Date {
    var dateObject: Date?
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formatedString
    dateFormatter.locale = Locale.current
    
    if let date = dateFormatter.date(from:dateString){
      dateObject = date
    }
    else{
      dateObject = Date()
    }
    
    return dateObject!
  }
  // MARK:  --------------------------------------------------- End ----------------------------------------------------------.

  
  
  
  /*
   @discussion     .
   @paramters      .
   @return             .
   */
  func getArrayOfExpiryYearFromCurrentYear() -> [String] {
    var arrayOfExpiryYear = [String]()
    
    var year = 2017
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    let yearInString = formatter.string(from: NSDate() as Date)
    year = Int(yearInString)!
    
    for _ in 1...21 {
      let yearString:String = String(year)
      arrayOfExpiryYear.append(yearString)

      year = year + 1
    }
    
    return arrayOfExpiryYear
  }
  
  
  
  /*
   @discussion     .
   @paramters      .
   @return             .
   */
  func validateNetworkResponseHttpStatusCodeBy(response: URLResponse) -> NetworkResponseStatus {
    var networkResponseStatus = NetworkResponseStatus.None
    
    if let httpResponse = response as? HTTPURLResponse {
      let statusCode = httpResponse.statusCode
      
      switch statusCode {
      case 200:
        networkResponseStatus = NetworkResponseStatus.NetworkSuccess
        break
        
      default:
        networkResponseStatus = NetworkResponseStatus.NetworkError
        break
      }
    }
    
    return networkResponseStatus
  }
  
  
  /*
   @discussion     .
   @paramters      .
   @return             .
   */
  func validateNetworkResponseBy(response: Data) -> (NetworkResponseStatus, String) {
    var responseStatus = NetworkResponseStatus.None
    var responseMsg = ""
    var responseDict = [String:AnyObject]()
    
    do {
      // Code to serialized json string into json object by NSJSONSerialization class method JSONObjectWithData.
      responseDict = try (JSONSerialization.jsonObject(with: response, options: []) as? [String:AnyObject])!
    }
    catch let error as NSError {
      print(error)
    }
    
    if let status = responseDict["status"] as? String{
      if status == "200"{
        responseStatus = NetworkResponseStatus.Success
        responseMsg = (responseDict["message"] as? String)!
      }
      else{
        responseStatus = NetworkResponseStatus.Failure
        if let msg = responseDict["message"] as? String{
          responseMsg = msg
        }
      }
    }
    else{
      responseStatus = NetworkResponseStatus.Failure
      responseMsg = "Server not found"
    }
    
    return (responseStatus, responseMsg)
  }
  
  
  
  
  
  /*
   @discussion     .
   @paramters      .
   @return             .
   */
  func getMonthNumberFromMonthName(month: String) -> String {
    var monthNumber = ""
    
    switch month {
    case MonthNameTypeEnum.January.rawValue:
        monthNumber = "01"

    case MonthNameTypeEnum.February.rawValue:
      monthNumber = "02"

    case MonthNameTypeEnum.March.rawValue:
      monthNumber = "03"

    case MonthNameTypeEnum.April.rawValue:
      monthNumber = "04"

    case MonthNameTypeEnum.May.rawValue:
      monthNumber = "05"

    case MonthNameTypeEnum.June.rawValue:
      monthNumber = "06"

    case MonthNameTypeEnum.July.rawValue:
      monthNumber = "07"

    case MonthNameTypeEnum.August.rawValue:
      monthNumber = "08"

    case MonthNameTypeEnum.September.rawValue:
      monthNumber = "09"

    case MonthNameTypeEnum.October.rawValue:
      monthNumber = "10"

    case MonthNameTypeEnum.November.rawValue:
      monthNumber = "11"

    case MonthNameTypeEnum.December.rawValue:
      monthNumber = "12"
      
    default :
      monthNumber = "01"
    }
    
    return monthNumber
  }
  
  
}
