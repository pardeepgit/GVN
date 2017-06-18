//
//  Constant.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 08/05/17.
//

import Foundation
import UIKit



enum MonthNameTypeEnum: String {
  case January, February, March, April, May, June, July, August, September, October, November, December
}


/*
 *
 *
 */
enum ApiResponseStatusEnum {
  case Success
  case Failure
  case NetworkError
  case ClientTokenExpiry
}


// MARK:  ------------------------------  Global Constant declaration for TazWorks Api  ----------------------------.
let TAZWORKAPIURL = "https://redridgevs.net/send/interchange"

let APIBASEURL = "http://globalverificationnetwork.getsandbox.com"
let SIGNINMETHOD = "Login"
let REGISTERMETHOD = "Registration"


// http Methods.
let POST = "POST"
let GET = "GET"
let DELETE = "DELETE"
let PUT = "PUT"

//DeviceInfo
let DEVICETYPE = "iPhone"
let DEVICETOKEN = "jhjdshfjdhsfjh3423h3h4jh34jjhjh43h4jh34j"

// MARK:  --------------------------------------------------- End ----------------------------------------------------------.







// MARK:  ------------------------------  Global Constant NSArray collection declaration  -------------------------------.

let arrayOfMonth = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

let arrayOfStates = ["AL", "AK", "AZ", "AR", "CA", "CT", "DE", "DC", "FL", "GA", "HI", "IL", "IN", "KS", "KY", "LE", "MA", "ME", "MN", "MS", "MO", "NY", "NH", "OH", "OK", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WV"]

let arrayOfCounty = ["Alachua County", "Baker County", "Bay County", "Bradford County", "Brevard County", "Broward County", "Calhoun County", "Charlotte County", "Dixie County", "Duval County", "Escambia County", "Franklin County", "Gilchrist County", "Gulf County", "Hamilton County", "Hernando County", "Indian River County", "Jefferson County", "Lake County", "Lee County", "Madison County"]

let arrayOfFederal = ["Alabama", "Alaska", "Arizona", "California", "Colorado", "District of Columbia", "Georgia", "Hawaii", "Indiana", "Kansas", "Maryland", "Michigan", "New Jersey", "New York", "North Dakota", "Oregon", "Tennessee", "Texas", "Virginia", "Washington", "Wisconsin", "Wyoming"]

// MARK:  --------------------------------------------------- End ----------------------------------------------------------.





// MARK:  ------------------------------  Global Constant Storyboard identifiers declaration  -------------------------------.

let CELL = "cell"
let MAIN = "Main"
let GVNSIGNUPVIEWCONTROLLER = "gvnSignUpViewController"
let GVNHOMEVIEWCONTROLLER = "gvnHomeViewController"
let GVNORDERVIEWCONTROLLER = "gvnOrderViewController"
let GVNTRANSACTIONVIEWCONTROLLER = "gvnTransactionViewController"
let GVNNEWSCREENINGREQUESTVIEWCONTROLLER = "gvnNewScreeningRequestViewController"
let GVNNEWSCREENINGREQUESTAPPLICANTINFOVIEWCONTROLLER = "gvnNewScreeningRequestApplicantInfoViewController"
let GVNNEWSCREENINGFEDERALCRIMINALVIEWCONTROLLER = "gvnNewScreeningFederalCriminalViewController"
let GVNNEWSCREENINGCOUNTYCRIMINALVIEWCONTROLLER = "gvnNewScreeningCountyCriminalViewController"
let GVNNEWSCREENINGNATIONALCRIMINALVIEWCONTROLLER = "gvnNewScreeningNationalCriminalViewController"
let GVNNEWSCREENINGDRIVERSEARCHVIEWCONTROLLER = "gvnNewScreeningDriverSearchViewController"
let GVNNEWSCREENINGORDERSUMMARYVIEWCONTROLLER = "gvnNewScreeningOrderSummaryViewController"

let GVNSCREENINGORDERDETAILVIEWCONTROLLER = "gvnScreeningOrderDetailViewController"
let GVNSETTINGVIEWCONTROLLER = "gvnSettingViewController"
let GVNCHANGEPASSWORDVIEWCONTROLLER = "gvnChangePasswordViewController"
let GVNPROFILESETTINGVIEWCONTROLLER = "gvnProfileSettingViewController"

let GVNHOMETABLEVIEWCELL = "gvnHomeTableViewCell"
let GVNSCREENINGORDERTABLEVIEWCELL = "gvnScreeningOrderTableViewCell"
let GVNDRAFTORDERTABLEVIEWCELL = "gvnDraftOrderTableViewCell"

let GVNNEWSCREENINGORDERBRONZEPACKAGETABLEVIEWCELL = "gvnNewScreeningOrderBronzePackageTableViewCell"
let GVNNEWSCREENINGORDERSILVERPACKAGETABLEVIEWCELL = "gvnNewScreeningOrderSilverPackageTableViewCell"
let GVNNEWSCREENINGORDERGOLDPACKAGETABLEVIEWCELL = "gvnNewScreeningOrderGoldPackageTableViewCell"
let GVNNEWSCREENINGORDERDRIVERSEARCHTABLEVIEWCELL = "gvnNewScreeningOrderDriverSearchTableViewCell"

let GVNNEWSCREENINGFEDERALCRIMINALTABLEVIEWCELL = "gvnNewScreeningFederalCriminalTableViewCell"
let GVNNEWSCREENINGCOUNTYCRIMINALTABLEVIEWCELL = "gvnNewScreeningCountyCriminalTableViewCell"
let GVNNEWSCREENINGNATIONALCRIMINALTABLEVIEWCELL = "gvnNewScreeningNationalCriminalTableViewCell"
let GVNNEWSCREENINGORDERSUMMARYTABLEVIEWCELL = "gvnNewScreeningOrderSummaryTableViewCell"

// MARK:  --------------------------------------------------- End ----------------------------------------------------------.





// MARK:  ------------------------------  Global Constant UIFont instances declaration  -------------------------------.

let ROBOTOREGULARTWELVE = UIFont(name: "Roboto-Regular", size: 12)
let ROBOTOREGULARFIVETEEN = UIFont(name: "Roboto-Regular", size: 15)
let HEADERLABELTITLEFONT = UIFont(name: "Norwester", size: 18)
let FIVERADIUS = 5

// MARK:  --------------------------------------------------- End ----------------------------------------------------------.





// MARK:  ------------------------------  Global Constant UIColor instances declaration  -------------------------------.

let SUBMITBUTTONBORDERCOLOR: UIColor = UIColor(red: 22/255.0, green: 34/255.0, blue: 60/255.0, alpha: 1.0)
let LOGINBUTTONBORDERCOLOR: UIColor = UIColor(red: 255/255.0, green: 59/255.0, blue: 126/255.0, alpha: 1.0)
let BACKGROUNDCHECKBUTTONBORDERCOLOR: UIColor = UIColor.darkGray
let TABBARBACKGROUNDCOLOR: UIColor = UIColor(red: 25/255.0, green: 43/255.0, blue: 81/255.0, alpha: 1.0)
let WHITECOLOR: UIColor = UIColor.white
let BLACKCOLOR: UIColor = UIColor.black
let CLEARCOLOR: UIColor = UIColor.clear

let BUTTONTITLECOLOR: UIColor = UIColor(red: 57/255.0, green: 68/255.0, blue: 91/255.0, alpha: 1.0)
let RECENTORDERBACKGROUNDCOLOR: UIColor = UIColor(red: 57/255.0, green: 68/255.0, blue: 91/255.0, alpha: 0.35)

let COMPLETEORDERBACKGROUNDCOLOR: UIColor = UIColor(red: 76/255.0, green: 175/255.0, blue: 80/255.0, alpha: 1.0)
let PENDINGORDERBACKGROUNDCOLOR: UIColor = UIColor(red: 255/255.0, green: 127/255.0, blue: 39/255.0, alpha: 1.0)

let PACKAGETYPEFONTCOLOR: UIColor = UIColor(red: 243/255.0, green: 66/255.0, blue: 53/255.0, alpha: 1.0)
let DELETEBUTTONBGCOLOR: UIColor = UIColor(red: 235/255.0, green: 52/255.0, blue: 114/255.0, alpha: 1.0)

let ORDERDETAILBORDERCOLOR: UIColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1.0)

// MARK:  --------------------------------------------------- End ----------------------------------------------------------.




// MARK:  ------------------------------  Global Constant Date Formmater declaration  -------------------------------.
let DOBFORMATTER = "MM-dd-yyyy"
let TIMEFORMATTER = "hh:mm a"
let XMLAPIREQUESTDOBFORMATTER = "YYYY-MM-dd"



// MARK:  --------------------------------------------------- End ----------------------------------------------------------.

