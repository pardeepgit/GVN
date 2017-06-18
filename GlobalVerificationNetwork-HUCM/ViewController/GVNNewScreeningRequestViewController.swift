//
//  GVNNewScreeningRequestViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 09/05/17.
//

import UIKit

class GVNNewScreeningRequestViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var labelHeaderTitle: UILabel!
  @IBOutlet weak var tableViewScreeningOrderPackages: UITableView!

  
  // MARK:  instance variables, constant decalaration and define with infer type with default values.
  var visibleSectionIndexArray = [Int]()
  var sectionPackagesOptionDictArrayArray = [String: [[String: Any]]]()
  
  var screeningSearchPackage = ScreeningSearchPackagesType.None
  var verificationDriverSearchServiceFlag = false

  
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
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
    
    // Code to prepare array for the visible section of search screening packages.
    visibleSectionIndexArray.append(0)
    visibleSectionIndexArray.append(1)
    
    if ScreeningRequest.sharedInstance.isScreeningRequestInProcess == false{
      screeningSearchPackage = ScreeningSearchPackagesType.None
      verificationDriverSearchServiceFlag = false
    }
    
    self.tableViewScreeningOrderPackages.reloadData()
  }
  
  
  
  // MARK:  imageForPackageCellBy method.
  func imageForPackageCellBy(rowIndexPath: IndexPath) -> UIImage {
    var imageName = ""
    
    let section = rowIndexPath.section
    let row = rowIndexPath.row

    if section == 0{
      switch row {
      case 0:
        if screeningSearchPackage == ScreeningSearchPackagesType.Bronze{
          imageName = "bronzefilled"
        }
        else{
          imageName = "bronzeunfilled"
        }
        break
        
      case 1:
        if screeningSearchPackage == ScreeningSearchPackagesType.Silver{
          imageName = "silverfilled"
        }
        else{
          imageName = "silverunfilled"
        }
        break
        
      case 2:
        if screeningSearchPackage == ScreeningSearchPackagesType.Gold{
          imageName = "goldfilled"
        }
        else{
          imageName = "goldunfilled"
        }
        break
        
      default:
        print("default")
      }
    }
    else{
      if verificationDriverSearchServiceFlag == false{
        imageName = "starunfilled"
      }
      else{
        imageName = "starfilled"
      }
    }
    
    let image = UIImage(named: imageName)
    return image!
  }
  
  // MARK:  packageOptionSelector method.
  func packageOptionSelector(_ sender: UIButton) {
    let section = sender.tag / 100
    let row = sender.tag % 100
    
    if section == 0{
      switch row {
      case 0:
        if screeningSearchPackage == ScreeningSearchPackagesType.Bronze{
          screeningSearchPackage = ScreeningSearchPackagesType.None
        }
        else{
          screeningSearchPackage = ScreeningSearchPackagesType.Bronze
        }
        break

      case 1:
        if screeningSearchPackage == ScreeningSearchPackagesType.Silver{
          screeningSearchPackage = ScreeningSearchPackagesType.None
        }
        else{
          screeningSearchPackage = ScreeningSearchPackagesType.Silver
        }
        break

      case 2:
        if screeningSearchPackage == ScreeningSearchPackagesType.Gold{
          screeningSearchPackage = ScreeningSearchPackagesType.None
        }
        else{
          screeningSearchPackage = ScreeningSearchPackagesType.Gold
        }
        break
        
      default:
        print("default")
      }
    }
    else{
      if verificationDriverSearchServiceFlag == false{
        verificationDriverSearchServiceFlag = true
      }
      else{
        verificationDriverSearchServiceFlag = false
      }
    }
    
    self.tableViewScreeningOrderPackages.reloadData()
  }
  
  
  
  
  // MARK:  ................. IBAction Selector Target methods.

  // MARK:  buttonSettingsTapped method.
  @IBAction func buttonSettingsTapped(sender: UIButton){
    // Code to navigate to Setting ViewController from current fron viewController.
    NavigationViewModel.navigateToSettingViewControllerFrom(viewController: self)
  }

  // MARK:  buttonNextStepTapped method.
  @IBAction func buttonNextStepTapped(sender: UIButton){
    if screeningSearchPackage == ScreeningSearchPackagesType.None{ // Code to Validate for Screening search packages array.
      self.showAlertWith(message: NSLocalizedString("SCREENINGPACKAGE_VALIDATION", comment: ""))
    }
    else{
      if verificationDriverSearchServiceFlag == true{
        self.navigateToNextStepOfScreeningService()
      }
      else{
        self.showAlertDialogueWith(stringMessage: NSLocalizedString("DRIVERSEARCH_VALIDATION", comment: ""), withYesAction: {
          self.verificationDriverSearchServiceFlag = true
          
          self.navigateToNextStepOfScreeningService()
          }, withNoAction: {
            
            self.navigateToNextStepOfScreeningService()
          })
      }
    }
  }
  
  // MARK:  buttonSectionVisibilityTapped method.
  func buttonSectionVisibilityTapped(sender: UIButton){
    let sectionTagIndex = sender.tag
    
    if visibleSectionIndexArray.contains(sectionTagIndex){
      for index in 0..<visibleSectionIndexArray.count {
        if sectionTagIndex == visibleSectionIndexArray[index]{
          visibleSectionIndexArray.remove(at: index)
          break
        }
      }
    }
    else{
      visibleSectionIndexArray.append(sectionTagIndex)
    }

    tableViewScreeningOrderPackages.reloadData()
  }
  
  
  
  // MARK:  navigateToNextStepOfScreeningService method.
  func navigateToNextStepOfScreeningService() {
    ScreeningRequest.sharedInstance.isScreeningRequestInProcess = true
    
    ScreeningRequest.sharedInstance.screeningPackageType = screeningSearchPackage
    
    ScreeningRequest.sharedInstance.verificationServiceFlag = self.verificationDriverSearchServiceFlag

    self.tableViewScreeningOrderPackages.reloadData()

    NavigationViewModel.navigateToApplicantInfoForSsnTraceSearchPackageControllerFrom(viewController: self)
  }
  
  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}


/*
 * Extension of GVNNewScreeningRequestViewController to add UITableView prototcol UITableViewDataSource and UITableViewDelegate.
 * Override the protocol method to add tableview in GVNHomeViewController.
 */
// MARK:  Extension of GVNNewScreeningRequestViewController by UITableView DataSource & Delegates method.
extension GVNNewScreeningRequestViewController: UITableViewDataSource, UITableViewDelegate{
  
  func numberOfSections(in tableView: UITableView) -> Int{
    return 2
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60.0
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let viewForTableViewCellSection = UIView()
    viewForTableViewCellSection.backgroundColor = WHITECOLOR
    
    let subViewForTableViewCellSection = UIView()
    subViewForTableViewCellSection.frame = CGRect(x: 0, y: 10, width: tableViewScreeningOrderPackages.frame.size.width, height: 50)
    subViewForTableViewCellSection.backgroundColor = WHITECOLOR
    subViewForTableViewCellSection.layer.cornerRadius = CGFloat(FIVERADIUS)
    subViewForTableViewCellSection.layer.masksToBounds = true
    subViewForTableViewCellSection.layer.borderColor = RECENTORDERBACKGROUNDCOLOR.cgColor
    subViewForTableViewCellSection.layer.borderWidth = 1.0

    let packageTypeLabel = UILabel()
    packageTypeLabel.frame = CGRect(x: 20, y: 0, width: tableViewScreeningOrderPackages.frame.size.width-20, height: 50)
    packageTypeLabel.textColor = PACKAGETYPEFONTCOLOR
    packageTypeLabel.font = UIFont(name: "System", size: 14)
    
    if section == 0{
      packageTypeLabel.text = "Investigative"
    }
    else{
      packageTypeLabel.text = "Verification"
    }
    
    let rightArrowSubView = UIView()
    rightArrowSubView.frame = CGRect(x: tableViewScreeningOrderPackages.frame.size.width-50, y: 0, width: tableViewScreeningOrderPackages.frame.size.width, height: 50)
    rightArrowSubView.backgroundColor = CLEARCOLOR

    let rightArrowImageView = UIImageView()
    rightArrowImageView.frame = CGRect(x: 16, y: 20, width: 18, height: 10)
    rightArrowImageView.backgroundColor = CLEARCOLOR
    
    if visibleSectionIndexArray.contains(section){
      rightArrowImageView.image = UIImage(named: "downarrow")
    }
    else{
      rightArrowImageView.image = UIImage(named: "uparrow")
    }

    let arrowButton = UIButton()
    arrowButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    arrowButton.backgroundColor = CLEARCOLOR
    arrowButton.tag = section
    arrowButton.addTarget(self, action: #selector(GVNNewScreeningRequestViewController.buttonSectionVisibilityTapped), for: UIControlEvents.touchUpInside)

    rightArrowSubView.addSubview(rightArrowImageView)
    rightArrowSubView.addSubview(arrowButton)
    
    subViewForTableViewCellSection.addSubview(packageTypeLabel)
    subViewForTableViewCellSection.addSubview(rightArrowSubView)

    viewForTableViewCellSection.addSubview(subViewForTableViewCellSection)
    return viewForTableViewCellSection
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0{
      if indexPath.row == 0{ // For Bronze Package
        return 160
      }
      else if indexPath.row == 1{ // For Silver Package
        return 195
      }
      else{ // For Gold Package
        return 230
      }
    }
    else{ // For Driver Search
      return 55.0
    }
  }
  
  func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
    if visibleSectionIndexArray.contains(section){
      if section == 0{ // For Investigation
        return 3
      }
      else{ // For Verification
        return 1
      }
    }
    else{
      return 0
    }
  }
  
  func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
     let cell: GVNNewScreeningOrderBaseTableViewCell?
    
    if indexPath.section == 0{
      if indexPath.row == 0{ // For Bronze Package
        cell = (tableViewScreeningOrderPackages.dequeueReusableCell(withIdentifier: GVNNEWSCREENINGORDERBRONZEPACKAGETABLEVIEWCELL) as? GVNNewScreeningOrderBronzePackageTableViewCell!)!
      }
      else if indexPath.row == 1{ // For Silver Package
        cell = (tableViewScreeningOrderPackages.dequeueReusableCell(withIdentifier: GVNNEWSCREENINGORDERSILVERPACKAGETABLEVIEWCELL) as? GVNNewScreeningOrderSilverPackageTableViewCell!)!
      }
      else{ // For Gold Package
        cell = (tableViewScreeningOrderPackages.dequeueReusableCell(withIdentifier: GVNNEWSCREENINGORDERGOLDPACKAGETABLEVIEWCELL) as? GVNNewScreeningOrderGoldPackageTableViewCell!)!
      }
    }
    else{ // For Driver Search
      cell = (tableViewScreeningOrderPackages.dequeueReusableCell(withIdentifier: GVNNEWSCREENINGORDERDRIVERSEARCHTABLEVIEWCELL) as? GVNNewScreeningOrderDriverSearchTableViewCell!)!
    }
    
    cell?.buttonPackageOptionSelection.tag = (indexPath.section*100)+indexPath.row
    cell?.buttonPackageOptionSelection.addTarget(self, action: #selector(GVNNewScreeningRequestViewController.packageOptionSelector(_:)), for: .touchUpInside)
    
    cell?.imageViewPackageOptionSelection.image = self.imageForPackageCellBy(rowIndexPath: indexPath)
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.tableViewScreeningOrderPackages.reloadData()
  }

}

