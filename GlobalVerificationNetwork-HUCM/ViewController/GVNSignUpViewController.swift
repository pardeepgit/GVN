//
//  GVNSignUpViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 08/05/17.
//

import UIKit

class GVNSignUpViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var labelHeaderTitle: UILabel!

  @IBOutlet weak var labelFirstName: UILabel!
  @IBOutlet weak var labelLastName: UILabel!
  @IBOutlet weak var labelCompanyName: UILabel!
  @IBOutlet weak var labelIndustryName: UILabel!
  @IBOutlet weak var labelEmailName: UILabel!
  @IBOutlet weak var labelPhoneName: UILabel!
  
  @IBOutlet weak var viewSubmitButtonView: UIView!
  @IBOutlet weak var buttonSubmit: UIButton!
  @IBOutlet weak var textFieldFirstName: UITextField!
  @IBOutlet weak var textFieldLastName: UITextField!
  @IBOutlet weak var textFieldCompany: UITextField!
  @IBOutlet weak var textFieldIndustry: UITextField!
  @IBOutlet weak var textFieldEmail: UITextField!
  @IBOutlet weak var textFieldPhone: UITextField!
  
  @IBOutlet weak var textFieldCity: UITextField!
  @IBOutlet weak var textFieldState: UITextField!
  @IBOutlet weak var textFieldPostal: UITextField!


  
  
  // MARK:  instance variables, constant decalaration and define with infer type with default values.

  
  
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
  }
  
  
  
  
  
  // MARK:  preparedScreenDesign method.
  func preparedScreenDesign() {
    self.automaticallyAdjustsScrollViewInsets = false
    
    self.labelHeaderTitle.font = HEADERLABELTITLEFONT
    self.labelFirstName.font = ROBOTOREGULARTWELVE
    self.labelLastName.font = ROBOTOREGULARTWELVE
    self.labelCompanyName.font = ROBOTOREGULARTWELVE
    self.labelIndustryName.font = ROBOTOREGULARTWELVE
    self.labelEmailName.font = ROBOTOREGULARTWELVE
    self.labelPhoneName.font = ROBOTOREGULARTWELVE

    self.viewSubmitButtonView.layer.cornerRadius = 5.0
    self.viewSubmitButtonView.layer.masksToBounds = true
    self.viewSubmitButtonView.layer.borderColor = SUBMITBUTTONBORDERCOLOR.cgColor
    self.viewSubmitButtonView.layer.borderWidth = 1.0
    self.buttonSubmit.titleLabel?.textColor = BUTTONTITLECOLOR
    
    // Add a custom toolBar to Phone textfield for the Done BatButtonItem.
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.backgroundColor = UIColor.darkGray
    toolBar.tintColor = BUTTONTITLECOLOR
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(GVNSignUpViewController.numberKeyboardDonePressed))
    toolBar.setItems([doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    toolBar.sizeToFit()
    textFieldPhone.inputAccessoryView = toolBar
    textFieldPostal.inputAccessoryView = toolBar
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
  }
  
  
  // MARK:  numberKeyboardDonePressed method.
  func numberKeyboardDonePressed(){
    
    // Code to hide the number keyboard.
    view.endEditing(true)
  }
  
  
  // MARK:  buttonLoginTapped method.
  @IBAction func buttonBackTapped(sender: UIButton){
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK:  buttonLoginTapped method.
  @IBAction func buttonSubmitTapped(sender: UIButton){
    // Sign Up form validation.
    if self.isSignUpFormValid(){
      
      // Network validation checks.
      if Reachability.isConnectedToNetwork(){
        SwiftLoader.show(title: "Register...", animated: true)
        
        let delay = DispatchTime.now() + 1 // change 1 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
          
          // Code to execute login api service.
          self.executeNewUserSignUpApiService()
        }
      }
      else{
        DispatchQueue.main.async {
          self.showAlertWith(message: NSLocalizedString("NETWORK_VALIDATION", comment: ""))
        }
      }
    
    }
  }
  

  // MARK:  executeNewUserSignUpApiService method.
  func executeNewUserSignUpApiService() {
    
    var signUpRequestDict = [String: String]()
    signUpRequestDict["firstname"] = textFieldFirstName.text
    signUpRequestDict["lastname"] = textFieldLastName.text
    signUpRequestDict["industryName"] = textFieldIndustry.text
    signUpRequestDict["email"] = textFieldEmail.text
    signUpRequestDict["phone"] = textFieldPhone.text
    signUpRequestDict["deviceType"] = DEVICETYPE
    signUpRequestDict["deviceToken"] = DEVICETOKEN
    signUpRequestDict["city"] = textFieldCity.text
    signUpRequestDict["state"] = textFieldState.text
    signUpRequestDict["postalCode"] = textFieldPostal.text
    
    AuthenticationServices.authUserWith(inputFields: signUpRequestDict, serviceType: UserAuthApiRequestType.SignUp ,completion: { (apiStatus, response) -> () in
      
      DispatchQueue.main.async {
        // Hide the swift progress loader
        SwiftLoader.hide()
        
        switch apiStatus{
        case NetworkResponseStatus.Success:
          self.showSuccessMsgWith(message: response as! String, completion: {
            self.navigationController?.popToRootViewController(animated: true)
          })
          break
          
        case NetworkResponseStatus.Failure:
          self.showAlertWith(message: response as! String)
          break
          
        default:
          print(response)
          break
        }
      }
      
    })
  }
  
  
  
  // MARK:  ---------- Helper methods.
  
  // MARK:  isSignUpFormValid method.
  func isSignUpFormValid() -> Bool {
    var message = ""
    
    if textFieldFirstName.text?.characters.count == 0{
      message = NSLocalizedString("FIRSTNAME_VALIDATION", comment: "")
    }
    else if textFieldLastName.text?.characters.count == 0{
      message = NSLocalizedString("LASTNAME_VALIDATION", comment: "")
    }
//    else if textFieldCompany.text?.characters.count == 0{
//      message = NSLocalizedString("COMPANYNAME_VALIDATION", comment: "")
//    }
    else if textFieldIndustry.text?.characters.count == 0{
      message = NSLocalizedString("INDUSTRYNAME_VALIDATION", comment: "")
    }
    else if textFieldEmail.text?.characters.count == 0{
      message = NSLocalizedString("EMAILADDRESS_VALIDATION", comment: "")
    }
    else if !UtilManager.sharedInstance.isValidEmail(emailStr: textFieldEmail.text!){
      message = NSLocalizedString("VALIDEMAILADDRESS_VALIDATION", comment: "")
    }
    else if textFieldPhone.text?.characters.count == 0{
      message = NSLocalizedString("PHONENUMBER_VALIDATION", comment: "")
    }
    else if textFieldCity.text?.characters.count == 0{
      message = NSLocalizedString("CITY_VALIDATION", comment: "")
    }
    else if textFieldState.text?.characters.count == 0{
      message = NSLocalizedString("STATE_VALIDATION", comment: "")
    }
    else if textFieldPostal.text?.characters.count == 0{
      message = NSLocalizedString("POSTAL_VALIDATION", comment: "")
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
 * Extension of GVNSignUpViewController to add UITextField prototcol UITextFieldDelegate.
 * Override the protocol method of textfield delegate in GVNSignUpViewController to handle textfield action event and slector method.
 */
// MARK:  UITextField Delegates methods
extension GVNSignUpViewController: UITextFieldDelegate{
  
  internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let textFieldTagIndex = textField.tag
    
    switch textFieldTagIndex {
    case 101: // For First Name
      textFieldLastName.becomeFirstResponder()
      return true
      
    case 201: // For Last Name
      textFieldCompany.becomeFirstResponder()
      return true
      
    case 301: // For Company
      textFieldIndustry.becomeFirstResponder()
      return true

    case 401: // For Industry
      textFieldEmail.becomeFirstResponder()
      return true

    case 501: // For Email
      textFieldPhone.becomeFirstResponder()
      return true

    case 601: // For Phone
      textFieldPhone.resignFirstResponder()
      return true
      
    default:
      return true
    }
  }
  
}

