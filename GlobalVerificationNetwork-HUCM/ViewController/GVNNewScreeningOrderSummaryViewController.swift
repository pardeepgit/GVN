//
//  GVNNewScreeningOrderSummaryViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 23/05/17.
//

import UIKit


class GVNNewScreeningOrderSummaryViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var viewConfirmOrderView: UIView!
  @IBOutlet weak var buttonConfirmOrder: UIButton!
  @IBOutlet weak var viewOrderSummaryView: UIView!
  @IBOutlet weak var tableViewOrderSummary: UITableView!
  
  @IBOutlet weak var labelOrderSummaryHeaderTitle: UILabel!
  @IBOutlet weak var labelApplicantName: UILabel!
  @IBOutlet weak var labelApplicantSsnDob: UILabel!
  @IBOutlet weak var labelApplicantStreetAddress: UILabel!
  @IBOutlet weak var labelApplicantCityState: UILabel!
  
  
  // MARK:  instance variables, constant decalaration and define with infer type with default values.
  let applicantInfoObject = ScreeningRequest.sharedInstance.applicantInfo
  var arrayOfScreeningPackageServices =  [[String: String]]()
  var totalScreeningFee = 0.0
  
  
  
  /*
   * UIViewController class life cycle overrided method to handle viewController functionality on the basis of the state of method in application.
   * E.g viewDidLoad method to iniailize all the component before appear screem. viewWillAppear method to show loadder or UI related task.
   */
  // MARK:  UIViewController class overrided method.
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    self.preparedScreenDesign()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.loadScreenData()
  }
  
  
  
  // MARK:  preparedScreenDesign method.
  func preparedScreenDesign() {
    self.viewConfirmOrderView.layer.cornerRadius = 3.0
    self.viewConfirmOrderView.layer.masksToBounds = true
    self.viewConfirmOrderView.layer.borderColor = SUBMITBUTTONBORDERCOLOR.cgColor
    self.viewConfirmOrderView.layer.borderWidth = 1.0
    self.buttonConfirmOrder.titleLabel?.textColor = BUTTONTITLECOLOR
    
    self.viewOrderSummaryView.layer.cornerRadius = 5.0
    self.viewOrderSummaryView.layer.masksToBounds = true
    
    let driverSearchServiceFlag = ScreeningRequest.sharedInstance.verificationServiceFlag
    if driverSearchServiceFlag == true{ // When Driver Search Service true
      labelOrderSummaryHeaderTitle.text = NSLocalizedString("HEADERSTEPFOUR_TITLE", comment: "")
    }
    else{ // When Driver Search Service false
      labelOrderSummaryHeaderTitle.text = NSLocalizedString("HEADERSTEPTHREE_TITLE", comment: "")
    }
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
    let firstName = applicantInfoObject?.firstName
    let middleName = applicantInfoObject?.middleName
    let lastName = applicantInfoObject?.lastName
    let ssnNumber = applicantInfoObject?.ssnNumber
    let dob = applicantInfoObject?.dob
    let address = applicantInfoObject?.address
    // let postalCode = applicantInfoObject?.postalCode
    let city = applicantInfoObject?.city
    let state = applicantInfoObject?.state
    
    labelApplicantName.text = ScreeningRequestViewModel.getApplicantFullNameFrom(firstName: firstName!, with: middleName!, and: lastName!)
    labelApplicantSsnDob.text = String(format: "(%@) %@", ssnNumber!, dob!)
    labelApplicantStreetAddress.text = address
    labelApplicantCityState.text = String(format: "%@ %@", city!, state!)
    
    
    arrayOfScreeningPackageServices = self.getArrayOfScreeningPackageServices()
    tableViewOrderSummary.reloadData()
  }
  
  
  
  
  // MARK:  ................. IBAction Selector Target methods.
  
  // MARK:  buttonLoginTapped method.
  @IBAction func buttonBackTapped(sender: UIButton){
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK:  buttonSettingsTapped method.
  @IBAction func buttonSettingsTapped(sender: UIButton){
    // Code to navigate to Setting ViewController from current fron viewController.
    NavigationViewModel.navigateToSettingViewControllerFrom(viewController: self)
  }
  
  // MARK:  buttonConfirmOrderTapped method.
  @IBAction func buttonConfirmOrderTapped(sender: UIButton){
    
    let storyBoard : UIStoryboard = UIStoryboard(name: MAIN, bundle:nil)
    let gvnScreeningPaymentViewController = storyBoard.instantiateViewController(withIdentifier: "gvnScreeningPaymentViewController") as! GVNScreeningPaymentViewController
    self.present(gvnScreeningPaymentViewController, animated: true, completion: nil)

    
    /*
    // Network validation checks.
    if Reachability.isConnectedToNetwork(){
      DispatchQueue.global(qos: .userInitiated).async {
        
        // Code to call method for new screening api request.
        self.executeNewScreeningApiRequest()
      }
    }
    else{
      DispatchQueue.main.async {
        self.showAlertWith(message: NSLocalizedString("NETWORK_VALIDATION", comment: ""))
      }
    }
    */
  }
  
  
  // MARK:  executeNewScreeningApiRequest method.
  func executeNewScreeningApiRequest(){
    let xmlRequestBodyString = ScreeningRequestViewModel.prepareXmlStringNewScreeningRequestByModel(screeningRequest: ScreeningRequest.sharedInstance)
    
    let apiRequest = NSMutableURLRequest(url: NSURL(string: APIBASEURL)! as URL)
    let session = URLSession.shared
    // var err: NSError?
    
    apiRequest.httpMethod = POST
    apiRequest.addValue("application/xml", forHTTPHeaderField: "Content-Type")
    apiRequest.httpBody = xmlRequestBodyString.data(using: String.Encoding.utf8)
    
    let task = session.dataTask(with: apiRequest as URLRequest, completionHandler: {data, response, error -> Void in
      if let responseXmlString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
        
        // Code to save TazWork api request and response to local DataBase.
        self.saveTazWorkXmlApiResponseToLocalDB(responseXml: responseXmlString as String, andRequestXml: xmlRequestBodyString)
      }
      
    })
    task.resume()
  }
  
  func saveTazWorkXmlApiResponseToLocalDB(responseXml: String, andRequestXml requestXml: String) {
    let screeningDate = UtilManager.sharedInstance.getDateStringFromDateObject(date: Date(), byDateFormattedString: DOBFORMATTER)
    let screeningTime = UtilManager.sharedInstance.getDateStringFromDateObject(date: Date(), byDateFormattedString: TIMEFORMATTER)
    let fee = String(format: "%.2f", totalScreeningFee)
    let packageType = ScreeningRequestViewModel.getPackageNameForScreeningPackage(type: ScreeningRequest.sharedInstance.screeningPackageType!)
    
    let saveFlag = CoreDataManager.sharedInstance.saveNewScreeningRecordFor(response: responseXml, andWithRequest: requestXml, andDate: screeningDate, andTime: screeningTime, andFee: fee, andPackageType: packageType)
    if saveFlag == true{
      print("Record Saved")
      
      DispatchQueue.main.async {
        ScreeningRequest.sharedInstance.isScreeningRequestInProcess = false
        
        // Code to navigate to Home ViewController from New Order Confirmation.
        NavigationViewModel.popToHomeViewControllerFrom(viewController: self)
      }
    }
    else{
      print("Record Not Saved")
    }
  }
  
  
  
  
  
  // MARK:  ---------- Helper methods.
  
  
  // MARK:  getApplicantStreetAddressFrom method.
  func getApplicantStreetAddressFrom(street1: String, andWith street2: String) -> String {
    var street = ""
    
    if street1.characters.count > 0{
      street = street1
    }
    if street2.characters.count > 0{
      street = String(format: "%@ %@", street, street2)
    }
    
    return street
  }
  
  
  
  
  // MARK:  prepareScreeningServicesListing method.
  func getArrayOfScreeningPackageServices() ->  [[String: String]] {
    var arrayOfPackagesServices =  [[String: String]]() // self.prepareBronzePackageServicesListing()
    
    let screeningPackageType: ScreeningSearchPackagesType = ScreeningRequest.sharedInstance.screeningPackageType!
    var packageDict = [String: String]()
    switch screeningPackageType {
    case ScreeningSearchPackagesType.Bronze:
      packageDict["name"] = NSLocalizedString("BRONZEPACKAGECOST_TITLE", comment: "")
      packageDict["fee"] = "19.95"
      totalScreeningFee = 19.95
      
    case ScreeningSearchPackagesType.Silver:
      packageDict["name"] = NSLocalizedString("SILVERPACKAGECOST_TITLE", comment: "")
      packageDict["fee"] = "34.95"
      totalScreeningFee = 34.95
      
    case ScreeningSearchPackagesType.Gold:
      totalScreeningFee = 49.95
      packageDict["name"] = NSLocalizedString("GOLDPACKAGECOST_TITLE", comment: "")
      packageDict["fee"] = "49.95"
      
    case ScreeningSearchPackagesType.None:
      print("None")
    }
    arrayOfPackagesServices.append(packageDict)
    

    let verificationServiceFlag: Bool = ScreeningRequest.sharedInstance.verificationServiceFlag!
    if verificationServiceFlag == true{
      totalScreeningFee = totalScreeningFee + 15.0
      var driverHistory = [String: String]()
      driverHistory["name"] = NSLocalizedString("DRIVERSEARCHCOST_TITLE", comment: "")
      driverHistory["fee"] = "15.0"
      arrayOfPackagesServices.append(driverHistory)
    }
    
    
    let totalFeeChargeInString = String(format: "%.2f", totalScreeningFee)
    var total = [String: String]()
    total["name"] = "Total"
    total["fee"] = totalFeeChargeInString
    arrayOfPackagesServices.append(total)
    
    return arrayOfPackagesServices
  }
  
  
  
  
  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

/*
 * Extension of GVNNewScreeningOrderSummaryViewController to add UITableView prototcol UITableViewDataSource and UITableViewDelegate.
 * Override the protocol method to add tableview in GVNNewScreeningOrderSummaryViewController.
 */
// MARK:  Extension of GVNNewScreeningOrderSummaryViewController by UITableView DataSource & Delegates method.
extension GVNNewScreeningOrderSummaryViewController: UITableViewDataSource, UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40.0
  }
  
  func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
    return arrayOfScreeningPackageServices.count
  }
  
  func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
    let cell: GVNNewScreeningOrderSummaryTableViewCell = (tableViewOrderSummary.dequeueReusableCell(withIdentifier: GVNNEWSCREENINGORDERSUMMARYTABLEVIEWCELL) as? GVNNewScreeningOrderSummaryTableViewCell!)!
    
    let screeningService: [String: String] = arrayOfScreeningPackageServices[indexPath.row]
    let serviceName = screeningService["name"]
    let serviceFee = screeningService["fee"]
    
    cell.labelSearchSummaryAction.text = serviceName
    cell.labelFee.text = String(format: "$%@", serviceFee!)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.tableViewOrderSummary.reloadData()
  }
  
}
