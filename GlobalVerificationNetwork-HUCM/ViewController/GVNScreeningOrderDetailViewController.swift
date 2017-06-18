//
//  GVNScreeningOrderDetailViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 06/06/17.
//

import UIKit

class GVNScreeningOrderDetailViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var viewScreeningOrderInfoView: UIView!
  @IBOutlet weak var viewScreeningOrderApplicantInfoView: UIView!
  @IBOutlet weak var viewScreeningOrderServicesView: UIView!
  @IBOutlet weak var scrollViewScreeningOrderDetail: UIScrollView!
  @IBOutlet weak var buttonOrderStatus: UIButton!

  @IBOutlet weak var labelOrderNumber: UILabel!
  @IBOutlet weak var labelOrderDate: UILabel!
  @IBOutlet weak var labelOrderReportDate: UILabel!
  @IBOutlet weak var labelOrderPackageType: UILabel!
  @IBOutlet weak var labelOrderFee: UILabel!

  @IBOutlet weak var labelApplicantName: UILabel!
  @IBOutlet weak var labelApplicantEmail: UILabel!
  @IBOutlet weak var labelApplicantSsn: UILabel!
  @IBOutlet weak var labelApplicantDob: UILabel!
  @IBOutlet weak var labelApplicantPhone: UILabel!

  
  // MARK:  instance variables, constant decalaration and define with infer type with default values.
  var screeningOrder = ScreeningOrder()
  
  
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
    self.viewScreeningOrderInfoView.layer.cornerRadius = 5.0
    self.viewScreeningOrderInfoView.layer.masksToBounds = true
    self.viewScreeningOrderInfoView.layer.borderColor = ORDERDETAILBORDERCOLOR.cgColor
    self.viewScreeningOrderInfoView.layer.borderWidth = 1.0

    self.viewScreeningOrderApplicantInfoView.layer.cornerRadius = 5.0
    self.viewScreeningOrderApplicantInfoView.layer.masksToBounds = true
    self.viewScreeningOrderApplicantInfoView.layer.borderColor = ORDERDETAILBORDERCOLOR.cgColor
    self.viewScreeningOrderApplicantInfoView.layer.borderWidth = 1.0

    self.viewScreeningOrderServicesView.layer.cornerRadius = 5.0
    self.viewScreeningOrderServicesView.layer.masksToBounds = true
    self.viewScreeningOrderServicesView.layer.borderColor = ORDERDETAILBORDERCOLOR.cgColor
    self.viewScreeningOrderServicesView.layer.borderWidth = 1.0
    
    self.buttonOrderStatus.layer.cornerRadius = CGFloat(FIVERADIUS)
    self.buttonOrderStatus.backgroundColor = PENDINGORDERBACKGROUNDCOLOR
    self.buttonOrderStatus.setTitle("PENDING", for: UIControlState.normal)

    /*
    self.viewScreeningOrderInfoView.layer.cornerRadius = 5
    self.viewScreeningOrderInfoView.layer.masksToBounds = false
    self.viewScreeningOrderInfoView.layer.shadowColor = UIColor.black.cgColor
    self.viewScreeningOrderInfoView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    self.viewScreeningOrderInfoView.layer.shadowOpacity = 0.45
    self.viewScreeningOrderInfoView.layer.shadowPath = UIBezierPath(rect: self.viewScreeningOrderInfoView.bounds).cgPath
    self.viewScreeningOrderInfoView.layer.shadowRadius = 1.0
    */
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
    scrollViewScreeningOrderDetail.contentSize = CGSize(width: self.view.frame.size.width, height: CGFloat(750))

    self.updateOrderDetailnfo()
    
    self.updateApplicantInfo()
  }
  
  
  
  
  
  // MARK:  updateApplicantInfo method.
  func updateApplicantInfo() {
    let requestXmlString = screeningOrder.xmlrequest
    let applicant = ScreeningRequestViewModel.getApplicantInfoFromApiRequest(xmlString: requestXmlString!)
    
    let firstName = applicant.firstName!
    let middleName = applicant.middleName!
    let lastName = applicant.lastName!
    let ssn = applicant.ssnNumber!
    let dob = applicant.dob!
    let email = applicant.email!
    let applicantName = ScreeningRequestViewModel.getApplicantFullNameFrom(firstName: firstName, with: middleName, and: lastName)

    labelApplicantName.text = applicantName
    labelApplicantEmail.text = email
    labelApplicantDob.text = dob
    labelApplicantSsn.text = ssn
  }
  
  // MARK:  updateOrderDetailnfo method.
  func updateOrderDetailnfo() {
    let orderDate = screeningOrder.orderdate
    let orderTime = screeningOrder.ordertime
    let orderPackageType = screeningOrder.packagetype
    let orderFee = screeningOrder.fee
    
    labelOrderDate.text = String(format: "%@, %@", orderDate!, orderTime!)
    labelOrderReportDate.text = String(format: "%@, %@", orderDate!, orderTime!)
    labelOrderPackageType.text = String(format: "%@ Package", orderPackageType!)
    labelOrderFee.text = String(format: "%@", orderFee!)

    if let responseXml = screeningOrder.xmlresponse{
      var responseDataDict = NSDictionary()
      do{
        responseDataDict = try XMLReader.dictionary(forXMLString: responseXml) as NSDictionary
        
        if let backgroundReports = responseDataDict["BackgroundReports"] as? NSDictionary{
          if let backgroundReportPackage = backgroundReports["BackgroundReportPackage"] as? NSDictionary{
            if let orderIdDict = backgroundReportPackage["OrderId"] as? NSDictionary{
              if let orderId = orderIdDict.value(forKey: "text") as? String{
                labelOrderNumber.text = String(format: "#%@", orderId)
              }
            }
          }
        }
        
      }
      catch{
      }
    }
    
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

  
  
  
  
  // MARK:  ---------- Helper methods.

  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
