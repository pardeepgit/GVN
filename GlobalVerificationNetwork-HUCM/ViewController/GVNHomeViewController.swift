//
//  GVNHomeViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 20/04/17.
//

import UIKit

class GVNHomeViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var labelHeaderTitle: UILabel!
  @IBOutlet weak var viewAllButtonView: UIView!
  @IBOutlet weak var buttonViewAll: UIButton!
  @IBOutlet weak var viewRecentOrderView: UIView!
  @IBOutlet weak var tableViewRecentOrder: UITableView!
  @IBOutlet weak var labelScreeningOrderStatus: UILabel!
  
  
  // MARK:  instance variables, constant decalaration and define with infer type with default values.
  var arrayOfScreeningOrder = [ScreeningOrder]()
  
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
    self.labelHeaderTitle.font = HEADERLABELTITLEFONT
    
    self.viewAllButtonView.layer.cornerRadius = 5.0
    self.viewAllButtonView.layer.masksToBounds = true
    self.viewAllButtonView.layer.borderColor = SUBMITBUTTONBORDERCOLOR.cgColor
    self.viewAllButtonView.layer.borderWidth = 1.0
    self.buttonViewAll.titleLabel?.textColor = BUTTONTITLECOLOR
    
    self.viewRecentOrderView.layer.cornerRadius = 5.0
    self.viewRecentOrderView.layer.masksToBounds = true
    self.viewRecentOrderView.layer.borderColor = RECENTORDERBACKGROUNDCOLOR.cgColor
    self.viewRecentOrderView.layer.borderWidth = 1.0
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
    
    arrayOfScreeningOrder = CoreDataManager.sharedInstance.fetchRecentScreeningOrderFromLocalDB()
    
    self.reloadTableViewData()
  }
  
  
  // MARK:  reloadTableViewData method.
  func reloadTableViewData() {
    if arrayOfScreeningOrder.count > 0{
      labelScreeningOrderStatus.frame.size.height = 0.0
      labelScreeningOrderStatus.isHidden = true
    }
    else{
      labelScreeningOrderStatus.frame.size.height = 40.0
      labelScreeningOrderStatus.isHidden = false
    }
    
    // Code to Notify UITableView for record.
    self.tableViewRecentOrder.reloadData()
  }
  
  
  
  
  // MARK:  buttonSettingsTapped method.
  @IBAction func buttonSettingsTapped(sender: UIButton){
    // Code to navigate to Setting ViewController from current fron viewController.
    NavigationViewModel.navigateToSettingViewControllerFrom(viewController: self)
  }
  
  @IBAction func buttonViewAllTapped(sender: UIButton){
    // Code to navigate to Order ViewController from current fron viewController.
    NavigationViewModel.navigateToOrderControllerFrom(viewController: self)
  }
  
  
  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}



/*
 * Extension of GVNHomeViewController to add UITableView prototcol UITableViewDataSource and UITableViewDelegate.
 * Override the protocol method to add tableview in GVNHomeViewController.
 */
// MARK:  Extension of GVNHomeViewController by UITableView DataSource & Delegates method.
extension GVNHomeViewController: UITableViewDataSource, UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
  
  func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
    return arrayOfScreeningOrder.count
  }
  
  func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
    let cell: GVNHomeTableViewCell = (tableViewRecentOrder.dequeueReusableCell(withIdentifier: GVNHOMETABLEVIEWCELL) as? GVNHomeTableViewCell!)!
    
    /*
     if indexPath.row == 1 || indexPath.row == 4{
     cell.imageViewOrderStatus.image = UIImage(named: "pending")
     cell.buttonOrderStatus.backgroundColor = PENDINGORDERBACKGROUNDCOLOR
     cell.buttonOrderStatus.setTitle("PENDING", for: UIControlState.normal)
     }
     else{
     cell.imageViewOrderStatus.image = UIImage(named: "complete")
     cell.buttonOrderStatus.backgroundColor = COMPLETEORDERBACKGROUNDCOLOR
     cell.buttonOrderStatus.setTitle("COMPLETE", for: UIControlState.normal)
     }
     */
    
    cell.imageViewOrderStatus.image = UIImage(named: "pending")
    cell.buttonOrderStatus.backgroundColor = PENDINGORDERBACKGROUNDCOLOR
    cell.buttonOrderStatus.setTitle("PENDING", for: UIControlState.normal)
    
    let screeningOrder: ScreeningOrder = arrayOfScreeningOrder[indexPath.row]
    let orderDate = screeningOrder.orderdate
    let orderPackageType = screeningOrder.packagetype
    
    cell.labelScreeningPackageType.text = String(format: "%@ Package", orderPackageType!)
    cell.buttonOrderDate.setTitle(orderDate, for: UIControlState.normal)
    
    if let responseXml = screeningOrder.xmlresponse{
      var responseDataDict = NSDictionary()
      do{
        responseDataDict = try XMLReader.dictionary(forXMLString: responseXml) as NSDictionary
        
        if let backgroundReports = responseDataDict["BackgroundReports"] as? NSDictionary{
          if let backgroundReportPackage = backgroundReports["BackgroundReportPackage"] as? NSDictionary{
            if let orderIdDict = backgroundReportPackage["OrderId"] as? NSDictionary{
              if let orderId = orderIdDict.value(forKey: "text") as? String{
                cell.labelOrderId.text = orderId
              }
            }
          }
        }
        
      }
      catch{
      }
    }
    
    if let requestXmlString = screeningOrder.xmlrequest{
      let applicant = ScreeningRequestViewModel.getApplicantInfoFromApiRequest(xmlString: requestXmlString)
      
      let firstName = applicant.firstName!
      let middleName = applicant.middleName!
      let lastName = applicant.lastName!
      let applicantName = ScreeningRequestViewModel.getApplicantFullNameFrom(firstName: firstName, with: middleName, and: lastName)
      cell.labelApplicantName.text = applicantName
    }
    
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.tableViewRecentOrder.reloadData()
    let screeningOrder: ScreeningOrder = arrayOfScreeningOrder[indexPath.row]
    
    // Navigate to the Screening Order Detail screen.
    let storyBoard : UIStoryboard = UIStoryboard(name: MAIN, bundle:nil)
    let gvnScreeningOrderDetailViewController = storyBoard.instantiateViewController(withIdentifier: GVNSCREENINGORDERDETAILVIEWCONTROLLER) as! GVNScreeningOrderDetailViewController
    gvnScreeningOrderDetailViewController.hidesBottomBarWhenPushed = true
    gvnScreeningOrderDetailViewController.screeningOrder = screeningOrder
    self.navigationController?.pushViewController(gvnScreeningOrderDetailViewController, animated: true)
  }
  
}


