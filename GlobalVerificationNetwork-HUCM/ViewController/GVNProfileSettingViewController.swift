//
//  GVNProfileSettingViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 15/05/17.
//

import UIKit

class GVNProfileSettingViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var labelHeaderTitle: UILabel!
  
  @IBOutlet weak var scrollViewUpdateProfileForm: UIScrollView!
  @IBOutlet weak var viewUpdateRecordsButtonView: UIView!
  @IBOutlet weak var buttonUpdateRecords: UIButton!
  @IBOutlet weak var viewGeneralInformation: UIView!
  @IBOutlet weak var viewGeolocationAddress: UIView!
  @IBOutlet weak var viewContactAddress: UIView!
  @IBOutlet weak var imageViewGeneralInformationSection: UIImageView!
  @IBOutlet weak var imageViewGeolocationAddressSection: UIImageView!
  @IBOutlet weak var imageViewContactAddressSection: UIImageView!
  
  @IBOutlet weak var textFieldFirstName: UITextField!
  @IBOutlet weak var textFieldLastName: UITextField!
  @IBOutlet weak var textFieldEmailAddress: UITextField!
  @IBOutlet weak var textFieldDob: UITextField!
  @IBOutlet weak var textFieldSsn: UITextField!
  @IBOutlet weak var textFieldStreet: UITextField!
  @IBOutlet weak var textFieldCity: UITextField!
  @IBOutlet weak var textFieldState: UITextField!
  @IBOutlet weak var textFieldMobile: UITextField!
  @IBOutlet weak var textFieldHome: UITextField!
  
  @IBOutlet weak var formSuperViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var generalInformationViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var geolocationAddressViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var contactAddressViewHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var viewChooseDobView: UIView!
  @IBOutlet weak var chooseDatePickerView: UIDatePicker!
  
  
  // MARK:  instance variables, constant decalaration and define with infer type with default values.
  var generalInformationViewOpenFlag = true
  var geolocationAddressViewOpenFlag = true
  var contactAddressViewOpenFlag = true
  var dimView = UIView()
  
  
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
    self.automaticallyAdjustsScrollViewInsets = false
    self.updateProfileFormViewHeightConstraint()
    
    self.labelHeaderTitle.font = HEADERLABELTITLEFONT
    
    self.viewUpdateRecordsButtonView.layer.cornerRadius = 5.0
    self.viewUpdateRecordsButtonView.layer.masksToBounds = true
    self.viewUpdateRecordsButtonView.layer.borderColor = SUBMITBUTTONBORDERCOLOR.cgColor
    self.viewUpdateRecordsButtonView.layer.borderWidth = 1.0
    self.buttonUpdateRecords.setTitleColor(BUTTONTITLECOLOR, for: UIControlState.normal)
    
    self.viewChooseDobView.layer.cornerRadius = 5.0
    self.viewChooseDobView.layer.masksToBounds = true
    self.viewChooseDobView.isHidden = true
    
    chooseDatePickerView.minimumDate = Date().addingTimeInterval(-100*365*24*60*60)
    chooseDatePickerView.maximumDate = Date()
    
    // Add a custom toolBar to Mobile and Home phone number textfield for the Done BatButtonItem.
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = BUTTONTITLECOLOR
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(GVNProfileSettingViewController.numberKeyboardDonePressed))
    toolBar.setItems([doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    toolBar.sizeToFit()
    textFieldMobile.inputAccessoryView = toolBar
    textFieldHome.inputAccessoryView = toolBar
    
    // Code to Show Choose Date Picker View.
    self.showOrHideChooseDatePickerViewByShowBoolean(isShowFlag: false)
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
  }
  
  // MARK:  numberKeyboardDonePressed method.
  func numberKeyboardDonePressed(){
    
    // Code to hide the number keyboard.
    view.endEditing(true)
  }
  
  
  
  
  
  
  
  // MARK:  ................. IBAction Selector Target methods.
  
  // MARK:  buttonLoginTapped method.
  @IBAction func buttonBackTapped(sender: UIButton){
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK:  buttonUpdateProfileTapped method.
  @IBAction func buttonUpdateProfileTapped(sender: UIButton){
    if self.isUpdateProfileFormValid(){
      
      // Pop to last Setting viewController
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  // MARK:  buttonUpdateProfileTapped method.
  @IBAction func updateProfileFormViewBottomUpArrowButtonTapped(sender: UIButton){
    let tagIndex = sender.tag
    
    if tagIndex == 101{
      if generalInformationViewOpenFlag == true{
        generalInformationViewOpenFlag = false
        generalInformationViewHeightConstraint.constant = 0
        viewGeneralInformation.isHidden = true
      }
      else{
        generalInformationViewOpenFlag = true
        generalInformationViewHeightConstraint.constant = 340
        viewGeneralInformation.isHidden = false
      }
    }
    else if tagIndex == 201{
      if geolocationAddressViewOpenFlag == true{
        geolocationAddressViewOpenFlag = false
        geolocationAddressViewHeightConstraint.constant = 0
        viewGeolocationAddress.isHidden = true
      }
      else{
        geolocationAddressViewOpenFlag = true
        geolocationAddressViewHeightConstraint.constant = 200
        viewGeolocationAddress.isHidden = false
      }
    }
    else if tagIndex == 301{
      if contactAddressViewOpenFlag == true{
        contactAddressViewOpenFlag = false
        contactAddressViewHeightConstraint.constant = 0
        viewContactAddress.isHidden = true
      }
      else{
        contactAddressViewOpenFlag = true
        contactAddressViewHeightConstraint.constant = 130
        viewContactAddress.isHidden = false
      }
    }
    
    self.updateProfileFormViewHeightConstraint()
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
  
  // MARK:  updateProfileFormViewHeightConstraint method.
  func updateProfileFormViewHeightConstraint() {
    var formViewHeight = 900
    
    if generalInformationViewOpenFlag == false{
      formViewHeight = formViewHeight - 340
      imageViewGeneralInformationSection.image = UIImage(named: "whiteuparrow")
    }
    else{
      imageViewGeneralInformationSection.image = UIImage(named: "whitedownarrow")
    }
    
    if geolocationAddressViewOpenFlag == false{
      formViewHeight = formViewHeight - 200
      imageViewGeolocationAddressSection.image = UIImage(named: "whiteuparrow")
    }
    else{
      imageViewGeolocationAddressSection.image = UIImage(named: "whitedownarrow")
    }
    
    if contactAddressViewOpenFlag == false{
      formViewHeight = formViewHeight - 130
      imageViewContactAddressSection.image = UIImage(named: "whiteuparrow")
    }
    else{
      imageViewContactAddressSection.image = UIImage(named: "whitedownarrow")
    }
    
    formSuperViewHeightConstraint.constant = CGFloat(formViewHeight)
    scrollViewUpdateProfileForm.contentSize = CGSize(width: self.view.frame.size.width, height: CGFloat(formViewHeight))
  }
  
  
  
  
  
  // MARK:  ---------- Helper methods.
  
  // MARK:  isUpdateProfileFormValid method.
  func isUpdateProfileFormValid() -> Bool {
    var message = ""
    
    if textFieldFirstName.text?.characters.count == 0{
      message = NSLocalizedString("SETTINGFIRSTNAME_VALIDATION", comment: "")
    }
    else if textFieldLastName.text?.characters.count == 0{
      message = NSLocalizedString("SETTINGLASTNAME_VALIDATION", comment: "")
    }
    else if textFieldEmailAddress.text?.characters.count == 0{
      message = NSLocalizedString("SETTINGEMAILADDRESS_VALIDATION", comment: "")
    }
    else if !UtilManager.sharedInstance.isValidEmail(emailStr: textFieldEmailAddress.text!){
      message = NSLocalizedString("SETTINGVALIDEMAILADDRESS_VALIDATION", comment: "")
    }
    else if textFieldDob.text?.characters.count == 0{
      message = NSLocalizedString("SETTINGDOB_VALIDATION", comment: "")
    }
    else if textFieldSsn.text?.characters.count == 0{
      message = NSLocalizedString("SETTINGSSN_VALIDATION", comment: "")
    }
    else if textFieldStreet.text?.characters.count == 0{
      message = NSLocalizedString("SETTINGSTREETADDRESS_VALIDATION", comment: "")
    }
    else if textFieldCity.text?.characters.count == 0{
      message = NSLocalizedString("SETTINGCITY_VALIDATION", comment: "")
    }
    else if textFieldState.text?.characters.count == 0{
      message = NSLocalizedString("SETTINGSTATE_VALIDATION", comment: "")
    }
    else if textFieldMobile.text?.characters.count == 0{
      message = NSLocalizedString("SETTINGMOBILENUMBER_VALIDATION", comment: "")
    }
    
    if message.characters.count == 0{
      return true
    }
    else{
      self.showAlertWith(message: message)
      return false
    }
  }
  
  
  
  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}




/*
 * Extension of GVNProfileSettingViewController to add UITextField prototcol UITextFieldDelegate.
 * Override the protocol method of textfield delegate in GVNProfileSettingViewController to handle textfield action event and slector method.
 */
// MARK:  UITextField Delegates methods
extension GVNProfileSettingViewController: UITextFieldDelegate{
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let textFieldTagIndex = textField.tag
    
    switch textFieldTagIndex {
    case 101: // For First Name
      textFieldLastName.becomeFirstResponder()
      break
      
    case 201: // For Last Name
      textFieldEmailAddress.becomeFirstResponder()
      break
      
    case 301: // For Email Address
      textFieldEmailAddress.resignFirstResponder()
      break
      
    case 401: // For D.O.B
      textFieldSsn.becomeFirstResponder()
      break
      
    case 501: // For S.S.N
      if geolocationAddressViewOpenFlag == true{
        textFieldStreet.becomeFirstResponder()
      }
      else if contactAddressViewOpenFlag == true{
        textFieldMobile.becomeFirstResponder()
      }
      else{
        textFieldSsn.resignFirstResponder()
      }
      break
      
    case 601: // For Street
      textFieldCity.becomeFirstResponder()
      break
      
    case 701: // For City
      textFieldState.becomeFirstResponder()
      break
      
    case 801: // For State
      if contactAddressViewOpenFlag == true{
        textFieldMobile.becomeFirstResponder()
      }
      else{
        textFieldState.resignFirstResponder()
      }
      break
      
    case 901: // For Mobile
      textFieldHome.becomeFirstResponder()
      break
      
    case 102: // For Home
      textFieldHome.resignFirstResponder()
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

