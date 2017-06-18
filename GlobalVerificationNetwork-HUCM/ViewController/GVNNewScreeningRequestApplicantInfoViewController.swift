//
//  GVNNewScreeningRequestApplicantInfoViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 16/05/17.
//

import UIKit

/*
 ApplicantInfo address locale enumeration....
 Enum types are Domestic and International or None....
 */
enum ApplicantAddressLocaleEnum {
  case Domestic
  case International
  case None
}


class GVNNewScreeningRequestApplicantInfoViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var labelHeaderTitle: UILabel!
  
  @IBOutlet weak var scrollViewApplicantInfoForm: UIScrollView!
  @IBOutlet weak var viewApplicantInfo: UIView!
  @IBOutlet weak var viewApplicantAddress: UIView!
  @IBOutlet weak var imageViewApplicantInfoSection: UIImageView!
  @IBOutlet weak var imageViewApplicantAddressSection: UIImageView!
  
  @IBOutlet weak var formSuperViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var applicantInfoViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var applicantAddressViewHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var textFieldFirstName: UITextField!
  @IBOutlet weak var textFieldLastName: UITextField!
  @IBOutlet weak var textFieldMiddleName: UITextField!
  @IBOutlet weak var textFieldSsn: UITextField!
  @IBOutlet weak var textFieldDob: UITextField!
  @IBOutlet weak var textFieldEmailAddress: UITextField!
  @IBOutlet weak var textFieldAddress: UITextField!
  @IBOutlet weak var textFieldPostalCode: UITextField!
  @IBOutlet weak var textFieldCity: UITextField!
  @IBOutlet weak var textFieldState: UITextField!
  
  @IBOutlet weak var viewChooseDobView: UIView!
  @IBOutlet weak var chooseDatePickerView: UIDatePicker!
  
  
  // MARK:  instance variables, constant decalaration and define with infer type with default values.
  var applicantInfoViewOpenFlag = true
  var applicantAddressViewOpenFlag = true
  var dimView = UIView()
  
  var applicantAddressLocaleValue = ApplicantAddressLocaleEnum.None
  
  /*
   * UIViewController class life cycle overrided method to handle viewController functionality on the basis of the state of method in application.
   * E.g viewDidLoad method to iniailize all the component before appear screem. viewWillAppear method to show loadder or UI related task.
   */
  // MARK:  UIViewController class overrided method.
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    self.addFormStaticData()
    
    self.preparedScreenDesign()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.loadScreenData()
  }
  
  
  
  // MARK:  preparedScreenDesign method.
  func preparedScreenDesign() {
    self.labelHeaderTitle.font = HEADERLABELTITLEFONT
    
    self.setApplicantInformationFormViewHeightConstraint()
    
    self.viewChooseDobView.layer.cornerRadius = 5.0
    self.viewChooseDobView.layer.masksToBounds = true
    self.viewChooseDobView.isHidden = true
    
    chooseDatePickerView.minimumDate = Date().addingTimeInterval(-100*365*24*60*60)
    chooseDatePickerView.maximumDate = Date()
    
    // Code to Show Choose Date Picker View.
    self.showOrHideChooseDatePickerViewByShowBoolean(isShowFlag: false)
    
    
    
    // Add a custom toolBar to Mobile and Home phone number textfield for the Done BatButtonItem.
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = BUTTONTITLECOLOR
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(GVNNewScreeningRequestApplicantInfoViewController.postalCodeKeyboardDonePressed))
    toolBar.setItems([doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    toolBar.sizeToFit()
    textFieldPostalCode.inputAccessoryView = toolBar
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
    
  }
  
  // MARK:  addFormStaticData method.
  func addFormStaticData() {
    // Code to add static data.
    textFieldFirstName.text = "William"
    textFieldLastName.text = "Smith"
    textFieldMiddleName.text = "James"
    textFieldSsn.text = "668-07-0151"
    textFieldDob.text = "08-10-1989"
    textFieldEmailAddress.text = "jsmith@hotmail.com"
    textFieldAddress.text = "1871 Lonely Oak Drive"
    textFieldPostalCode.text = "36527"
    textFieldCity.text = "Spanish Fort"
    textFieldState.text = "AL"
    
    applicantAddressLocaleValue = ApplicantAddressLocaleEnum.Domestic
  }
  
  // MARK:  postalCodeKeyboardDonePressed method.
  func postalCodeKeyboardDonePressed(){
    
    // Code to hide the number keyboard.
    view.endEditing(true)
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
  
  // MARK:  buttonSaveDraftTapped method.
  @IBAction func buttonSaveDraftTapped(sender: UIButton){
    
    if self.isApplicantInfoFormValid(){
      // Code to prepare ApplicantInfo model from form view.
      self.prepareApplicantInfoModel()
      
      
      let saveDraftOrderFlag = CoreDataManager.sharedInstance.saveDraftOrderFor(screeningOrder: ScreeningRequest.sharedInstance)
      if saveDraftOrderFlag == true{
      }
      else{
      }
      
      DispatchQueue.main.async {
        ScreeningRequest.sharedInstance.isScreeningRequestInProcess = false
        
        // Code to call buttonCancelTapped method to dismiss to pop to New Screening Order Controller.
        self.buttonCancelTapped(sender: UIButton())
      }
      
    }
  }
  
  // MARK:  buttonNextStepTapped method.
  @IBAction func buttonNextStepTapped(sender: UIButton){
    
    if self.isApplicantInfoFormValid(){
      // Code to prepare ApplicantInfo model from form view.
      self.prepareApplicantInfoModel()
      
      let driverSearchServiceFlag = ScreeningRequest.sharedInstance.verificationServiceFlag
      if driverSearchServiceFlag == true{ // Navigate to Driver search.
        NavigationViewModel.navigateToDriverSearchScreeningSearchPackageControllerFrom(viewController: self)
      }
      else{ // Navigate to Order Summary search.
        NavigationViewModel.navigateToOrderSummaryControllerFrom(viewController: self)
      }
    }
  }
  
  // MARK:  buttonCancelTapped method.
  @IBAction func buttonCancelTapped(sender: UIButton){
    ScreeningRequest.sharedInstance.isScreeningRequestInProcess = false
    
    // Code pop to new screening request TabBar Controller when cancel from current new screening request.
    NavigationViewModel.popToNewScreeningRequestOrderControllerFrom(viewController: self)
  }
  
  // MARK:  applicantInformationFormViewBottomUpArrowButtonTapped method.
  @IBAction func applicantInformationFormViewBottomUpArrowButtonTapped(sender: UIButton){
    let tagIndex = sender.tag
    
    switch tagIndex {
    case 101: // For Account Info
      if applicantInfoViewOpenFlag == true{
        applicantInfoViewOpenFlag = false
        applicantInfoViewHeightConstraint.constant = 0
        viewApplicantInfo.isHidden = true
      }
      else{
        applicantInfoViewOpenFlag = true
        applicantInfoViewHeightConstraint.constant = 410
        viewApplicantInfo.isHidden = false
      }
      break
      
    case 201: // For Account Address
      if applicantAddressViewOpenFlag == true{
        applicantAddressViewOpenFlag = false
        applicantAddressViewHeightConstraint.constant = 0
        viewApplicantAddress.isHidden = true
      }
      else{
        applicantAddressViewOpenFlag = true
        applicantAddressViewHeightConstraint.constant = 280
        viewApplicantAddress.isHidden = false
      }
      break
      
    default:
      print("")
    }
    
    self.setApplicantInformationFormViewHeightConstraint()
  }
  
  // MARK:  setApplicantInformationFormViewHeightConstraint method.
  func setApplicantInformationFormViewHeightConstraint() {
    var formViewHeight = 780
    
    if applicantInfoViewOpenFlag == false{
      formViewHeight = formViewHeight - 410
      imageViewApplicantInfoSection.image = UIImage(named: "whiteuparrow")
    }
    else{
      imageViewApplicantInfoSection.image = UIImage(named: "whitedownarrow")
    }
    
    if applicantAddressViewOpenFlag == false{
      formViewHeight = formViewHeight - 280
      imageViewApplicantAddressSection.image = UIImage(named: "whiteuparrow")
    }
    else{
      imageViewApplicantAddressSection.image = UIImage(named: "whitedownarrow")
    }
    
    formSuperViewHeightConstraint.constant = CGFloat(formViewHeight)
    scrollViewApplicantInfoForm.contentSize = CGSize(width: self.view.frame.size.width, height: CGFloat(formViewHeight))
  }
  
  // MARK:  buttonChooseDobDatePickerViewAddOrCancellButtonTapped method.
  @IBAction func buttonChooseDobDatePickerViewAddOrCancellButtonTapped(sender: UIButton){
    let tagIndex = sender.tag
    
    switch tagIndex {
    case 1001: // When Date is selected
      let dateObject = chooseDatePickerView.date
      let dateString = UtilManager.sharedInstance.getDateStringFromDateObject(date: dateObject, byDateFormattedString: DOBFORMATTER)
      textFieldDob.text = dateString
      break
      
    case 1002: // When Cancel to hide DatPickerView.
      break
      
    default:
      print("default")
    }
    
    // Code to Show Choose Date Picker View.
    self.showOrHideChooseDatePickerViewByShowBoolean(isShowFlag: false)
  }
  
  
  // MARK:  showOrHideChooseDatePickerViewByShowBoolean method.
  func showOrHideChooseDatePickerViewByShowBoolean(isShowFlag: Bool) {
    if isShowFlag == true{ // Show Choose County view.
      dimView = UIView()
      dimView.frame = self.view.frame
      dimView.backgroundColor = BLACKCOLOR
      dimView.alpha = 0.0
      self.view.addSubview(dimView)
      
      self.view.bringSubview(toFront: self.viewChooseDobView)
      UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
        self.dimView.alpha = 0.6
      }, completion: { finished in
        self.viewChooseDobView.isHidden = false
      })
    }
    else{ // Hide Choose County view.
      self.viewChooseDobView.isHidden = true
      UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
        self.dimView.alpha = 0.0
      }, completion: { finished in
        self.dimView.removeFromSuperview()
      })
    }
  }
  
  
  
  
  
  
  
  // MARK:  ---------- Helper methods.
  
  // MARK:  isApplicantInfoFormValid method.
  func isApplicantInfoFormValid() -> Bool {
    var message = ""
    
    if textFieldFirstName.text?.characters.count == 0{
      message = "Please enter First Name"
    }
    else if textFieldLastName.text?.characters.count == 0{
      message = "Please enter Last Name"
    }
    else if textFieldMiddleName.text?.characters.count == 0{
      message = "Please enter Middle Name"
    }
    else if textFieldSsn.text?.characters.count == 0{
      message = "Please enter S.S.N"
    }
    else if textFieldDob.text?.characters.count == 0{
      message = "Please enter D.O.B"
    }
    else if textFieldEmailAddress.text?.characters.count == 0{
      message = "Please enter Email Address"
    }
    else if !UtilManager.sharedInstance.isValidEmail(emailStr: textFieldEmailAddress.text!){
      message = "Please enter a valid Email Address"
    }
    else if applicantAddressLocaleValue == ApplicantAddressLocaleEnum.None{
      message = "Please select User Locale"
    }
    else if textFieldAddress.text?.characters.count == 0{
      message = "Please enter Address"
    }
    else if textFieldPostalCode.text?.characters.count == 0{
      message = "Please enter Postal Code"
    }
    else if textFieldCity.text?.characters.count == 0{
      message = "Please enter City"
    }
    else if textFieldState.text?.characters.count == 0{
      message = "Please enter State"
    }
    
    if message.characters.count == 0{
      return true
    }
    else{
      self.showAlertWith(message: message)
      return false
    }
  }
  
  // MARK:  prepareApplicantInfoModel method.
  func prepareApplicantInfoModel() {
    let applicantInfoModel = ApplicantInfo()
    
    applicantInfoModel.firstName = textFieldFirstName.text
    applicantInfoModel.lastName = textFieldLastName.text
    applicantInfoModel.middleName = textFieldMiddleName.text
    applicantInfoModel.ssnNumber = textFieldSsn.text
    applicantInfoModel.dob = textFieldDob.text
    applicantInfoModel.email = textFieldEmailAddress.text
    applicantInfoModel.address = textFieldAddress.text
    applicantInfoModel.postalCode = textFieldPostalCode.text
    applicantInfoModel.city = textFieldCity.text
    applicantInfoModel.state = textFieldState.text
    
    ScreeningRequest.sharedInstance.applicantInfo = applicantInfoModel
  }
  
  
  
  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

/*
 * Extension of GVNNewScreeningRequestApplicantInfoViewController to add UITextField prototcol UITextFieldDelegate.
 * Override the protocol method of textfield delegate in GVNNewScreeningRequestApplicantInfoViewController to handle textfield action event and slector method.
 */
// MARK:  UITextField Delegates methods
extension GVNNewScreeningRequestApplicantInfoViewController: UITextFieldDelegate{
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let textFieldTagIndex = textField.tag
    
    switch textFieldTagIndex {
    case 0: // For First Name
      textFieldLastName.becomeFirstResponder()
      break
      
    case 1: // For Last Name
      textFieldMiddleName.becomeFirstResponder()
      break
      
    case 2: // For Middle Name
      textFieldSsn.becomeFirstResponder()
      break
      
    case 3: // For SSN
      textFieldSsn.resignFirstResponder()
      break
      
    case 4: // For DOB
      textFieldEmailAddress.becomeFirstResponder()
      break
      
    case 5: // For Email
      if applicantAddressViewOpenFlag == true{
        textFieldAddress.becomeFirstResponder()
      }
      else{
        textFieldEmailAddress.resignFirstResponder()
      }
      break
      
    case 6: // For First Street
      textFieldPostalCode.becomeFirstResponder()
      break
      
    case 7: // For Second Street
      textFieldCity.becomeFirstResponder()
      break
      
    case 8: // For City
      textFieldState.becomeFirstResponder()
      break
      
    case 9: // For State
      textFieldState.resignFirstResponder()
      break
      
    default:
      print("default")
    }
    
    return true
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if textField == textFieldDob{
      // Code to hide the keyboard.
      view.endEditing(true)
      
      if textFieldDob.text?.characters.count != 0{
        let dateString = textFieldDob.text
        let dateObject = UtilManager.sharedInstance.getDateObjectFromDateString(dateString: dateString!, byDateFormattedString: DOBFORMATTER)
        chooseDatePickerView.date = dateObject
      }
      else{
        chooseDatePickerView.date = Date()
      }
      
      // Code to Show Choose Date Picker View.
      self.showOrHideChooseDatePickerViewByShowBoolean(isShowFlag: true)
      return false
    }
    else{
      return true
    }
  }
  
}


