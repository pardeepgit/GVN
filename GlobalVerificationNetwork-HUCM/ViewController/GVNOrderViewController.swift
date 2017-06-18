//
//  GVNOrderViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 09/05/17.
//

import UIKit

class GVNOrderViewController: BaseController {
  
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var labelHeaderTitle: UILabel!
  @IBOutlet weak var viewScreeningOrderView: UIView!
  @IBOutlet weak var tableViewScreeningAndSavedDraftOrder: UITableView!
  @IBOutlet weak var labelScreeningAndDraftOrderStatus: UILabel!
  @IBOutlet weak var segmentControlOfOrder: UISegmentedControl!

  
  // MARK:  instance variables, constant decalaration and define with infer type with default values.
  var arrayOfScreeningOrder = [ScreeningOrder]()
  var arrayOfDraftOrder = [DraftOrder]()
  var listViewType = OrderControllerListViewType.OrderHistory
  
  
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
    
    self.viewScreeningOrderView.layer.cornerRadius = 5.0
    self.viewScreeningOrderView.layer.masksToBounds = true
    self.viewScreeningOrderView.layer.borderColor = RECENTORDERBACKGROUNDCOLOR.cgColor
    self.viewScreeningOrderView.layer.borderWidth = 1.0

    segmentControlOfOrder.setEnabled(true, forSegmentAt: 0)
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
    
    listViewType = OrderControllerListViewType.OrderHistory
    self.updateTableViewDataFor(type: listViewType)
    
    self.reloadTableViewData()
  }
  
  
  
  // MARK:  updateTableViewDataFor method.
  func updateTableViewDataFor(type: OrderControllerListViewType) {
    switch type {
    case OrderControllerListViewType.OrderHistory:
      arrayOfScreeningOrder = CoreDataManager.sharedInstance.fetchAllScreeningOrderFromLocalDB()
      
    case OrderControllerListViewType.DraftOrder:
      arrayOfDraftOrder = CoreDataManager.sharedInstance.fetchAllDraftOrderFromLocalDB()
      print("")
    }
  }
  
  
  
  // MARK:  reloadTableViewData method.
  func reloadTableViewData() {
    if listViewType == OrderControllerListViewType.OrderHistory{
      if arrayOfScreeningOrder.count > 0{
        
        labelScreeningAndDraftOrderStatus.frame.size.height = 0.0
        labelScreeningAndDraftOrderStatus.isHidden = true
      }
      else{
        labelScreeningAndDraftOrderStatus.frame.size.height = 40.0
        labelScreeningAndDraftOrderStatus.isHidden = false
        labelScreeningAndDraftOrderStatus.text = NSLocalizedString("ORDERHISTORY_STATUS", comment: "")
      }
    }
    else{
      if arrayOfDraftOrder.count > 0{
        
        labelScreeningAndDraftOrderStatus.frame.size.height = 0.0
        labelScreeningAndDraftOrderStatus.isHidden = true
      }
      else{
        labelScreeningAndDraftOrderStatus.frame.size.height = 40.0
        labelScreeningAndDraftOrderStatus.isHidden = false
        labelScreeningAndDraftOrderStatus.text = NSLocalizedString("DRAFTORDER_STATUS", comment: "")
      }
    }
    
    
    // Code to Notify UITableView for record.
    self.tableViewScreeningAndSavedDraftOrder.reloadData()
  }

  
  
  
  
  
  // MARK:  buttonSettingsTapped method.
  @IBAction func buttonSettingsTapped(sender: UIButton){
    // Code to navigate to Setting ViewController from current fron viewController.
    NavigationViewModel.navigateToSettingViewControllerFrom(viewController: self)
  }

  // MARK:  createdAndDraftOrderSegmentSwitch method.
  @IBAction func createdAndDraftOrderSegmentSwitch(sender: UISegmentedControl){
    let selectedSegment = sender.selectedSegmentIndex;

    switch selectedSegment {
    case 0: // For Screening Order
      listViewType = OrderControllerListViewType.OrderHistory
      break

    case 1: // For Saved Draft Order
      listViewType = OrderControllerListViewType.DraftOrder
      break

    default: // For Deafult Option
      print("default")
    }
    
    self.updateTableViewDataFor(type: listViewType)
    
    self.reloadTableViewData()
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
extension GVNOrderViewController: UITableViewDataSource, UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if listViewType == OrderControllerListViewType.OrderHistory{
      return 80.0
    }
    else{
      return 80.0
    }
  }
  
  func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
    if listViewType == OrderControllerListViewType.OrderHistory{
      return arrayOfScreeningOrder.count
    }
    else{
      return arrayOfDraftOrder.count
    }
  }
  
  func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
    if listViewType == OrderControllerListViewType.OrderHistory{
      
      let cell: GVNScreeningOrderTableViewCell = (tableViewScreeningAndSavedDraftOrder.dequeueReusableCell(withIdentifier: GVNSCREENINGORDERTABLEVIEWCELL) as? GVNScreeningOrderTableViewCell!)!
      
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
    else{
      
      let cell: GVNDraftOrderTableViewCell = (tableViewScreeningAndSavedDraftOrder.dequeueReusableCell(withIdentifier: GVNDRAFTORDERTABLEVIEWCELL) as? GVNDraftOrderTableViewCell!)!
      
      let draftOrder: DraftOrder = arrayOfDraftOrder[indexPath.row]
      let draftDate = draftOrder.saveddraftdate
      let packageType = draftOrder.packagetype
      
      let applicantInfo = draftOrder.applicantsearch
      let applicantFirstName = applicantInfo?.firstname
      let applicantMiddleName = applicantInfo?.middlename
      let applicantLastName = applicantInfo?.lastname
      let applicantSsn = applicantInfo?.ssn

      let appllicantName = ScreeningRequestViewModel.getApplicantFullNameFrom(firstName: applicantFirstName!, with: applicantMiddleName!, and: applicantLastName!)
      cell.labelApplicantName.text = appllicantName
      cell.labelApplicantSsn.text = applicantSsn
      cell.buttonOrderDate.setTitle(draftDate, for: UIControlState.normal)
      
      switch packageType {
      case 1:
        cell.labelScreeningPackageType.text = NSLocalizedString("BRONZE_PACKAGE", comment: "")
        break

      case 2:
        cell.labelScreeningPackageType.text = NSLocalizedString("SILVER_PACKAGE", comment: "")
        break

      case 3:
        cell.labelScreeningPackageType.text = NSLocalizedString("GOLD_PACKAGE", comment: "")
        break

      default:
        cell.labelScreeningPackageType.text = ""
        break
      }
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.tableViewScreeningAndSavedDraftOrder.reloadData()
    
    if listViewType == OrderControllerListViewType.OrderHistory{
      let screeningOrder: ScreeningOrder = arrayOfScreeningOrder[indexPath.row]
      
      // Navigate to the Screening Order Detail screen.
      let storyBoard : UIStoryboard = UIStoryboard(name: MAIN, bundle:nil)
      let gvnScreeningOrderDetailViewController = storyBoard.instantiateViewController(withIdentifier: GVNSCREENINGORDERDETAILVIEWCONTROLLER) as! GVNScreeningOrderDetailViewController
      gvnScreeningOrderDetailViewController.hidesBottomBarWhenPushed = true
      gvnScreeningOrderDetailViewController.screeningOrder = screeningOrder
      self.navigationController?.pushViewController(gvnScreeningOrderDetailViewController, animated: true)
    }
    else{
      
    }
  }
  
}

