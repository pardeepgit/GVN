//
//  GVNChangePasswordViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 12/05/17.
//

import UIKit

class GVNChangePasswordViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var labelHeaderTitle: UILabel!
  
  @IBOutlet weak var viewUpdateButtonView: UIView!
  @IBOutlet weak var buttonUpdate: UIButton!
  @IBOutlet weak var textFieldOldPassword: UITextField!
  @IBOutlet weak var textFieldNewPassword: UITextField!
  @IBOutlet weak var textFieldConfirmPassword: UITextField!
  
  
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
    
    self.loadScreenData()
  }
  
  
  
  // MARK:  preparedScreenDesign method.
  func preparedScreenDesign() {
    self.labelHeaderTitle.font = HEADERLABELTITLEFONT
    
    self.viewUpdateButtonView.layer.cornerRadius = 5.0
    self.viewUpdateButtonView.layer.masksToBounds = true
    self.viewUpdateButtonView.layer.borderColor = SUBMITBUTTONBORDERCOLOR.cgColor
    self.viewUpdateButtonView.layer.borderWidth = 1.0
    self.buttonUpdate.titleLabel?.textColor = BUTTONTITLECOLOR
    
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
    
  }
  
  
  
  // MARK:  ................. IBAction Selector Target methods.
  
  // MARK:  buttonLoginTapped method.
  @IBAction func buttonBackTapped(sender: UIButton){
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK:  buttonLoginTapped method.
  @IBAction func buttonUpdatePasswordTapped(sender: UIButton){
    if self.isUpdatePasswordFormValid(){
      
      // Pop to last Setting viewController
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  
  
  
  
  // MARK:  ---------- Helper methods.
  
  
  // MARK:  isUpdatePasswordFormValid method.
  func isUpdatePasswordFormValid() -> Bool {
    var message = ""
    
    if textFieldOldPassword.text?.characters.count == 0{
      message = NSLocalizedString("UPDATEPASSWORDOLDPASSWORD_VALIDATION", comment: "")
    }
    else if textFieldNewPassword.text?.characters.count == 0{
      message = NSLocalizedString("UPDATEPASSWORDNEWPASSWORD_VALIDATION", comment: "")
    }
    else if textFieldConfirmPassword.text?.characters.count == 0{
      message = NSLocalizedString("UPDATEPASSWORDCONFIRMPASSWORD_VALIDATION", comment: "")
    }
    else if textFieldConfirmPassword.text != textFieldNewPassword.text{
      message = NSLocalizedString("UPDATEPASSWORDCONFIRMPASSWORDMISMATCH_VALIDATION", comment: "")
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
 * Extension of GVNChangePasswordViewController to add UITextField prototcol UITextFieldDelegate.
 * Override the protocol method of textfield delegate in GVNChangePasswordViewController to handle textfield action event and slector method.
 */
// MARK:  UITextField Delegates methods
extension GVNChangePasswordViewController: UITextFieldDelegate{
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let textFieldTagIndex = textField.tag
    
    switch textFieldTagIndex {
    case 101: // For Old Password
      textFieldNewPassword.becomeFirstResponder()
      break
      
    case 201: // For New Password
      textFieldConfirmPassword.becomeFirstResponder()
      break
      
    case 301: // For Confirm Password
      textFieldConfirmPassword.resignFirstResponder()
      break
      
    default:
      print("")
    }
    
    return true
  }
  
}

