//
//  GVNLoginViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 20/04/17.
//

import UIKit

class GVNLoginViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var scrollViewTop: UIScrollView!
  @IBOutlet weak var viewUsernameView: UIView!
  @IBOutlet weak var viewPasswordView: UIView!
  @IBOutlet weak var viewLoginButtonView: UIView!
  @IBOutlet weak var viewBackgroundCheckView: UIView!
  
  @IBOutlet weak var buttonLogin: UIButton!
  @IBOutlet weak var buttonBackgroundCheck: UIButton!
  @IBOutlet weak var textFieldUserName: UITextField!
  @IBOutlet weak var textFieldPassWord: UITextField!

  
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
    self.automaticallyAdjustsScrollViewInsets = false
    
    buttonLogin.titleLabel?.font = HEADERLABELTITLEFONT

    self.viewUsernameView.layer.cornerRadius = 20.0
    self.viewPasswordView.layer.cornerRadius = 20.0
    
    self.viewLoginButtonView.layer.cornerRadius = 20.0
    self.viewLoginButtonView.layer.masksToBounds = true
    self.viewLoginButtonView.layer.borderColor = LOGINBUTTONBORDERCOLOR.cgColor
    self.viewLoginButtonView.layer.borderWidth = 1.0

    self.viewBackgroundCheckView.layer.cornerRadius = 17.0
    self.viewBackgroundCheckView.layer.masksToBounds = true
    self.viewBackgroundCheckView.layer.borderColor = BACKGROUNDCHECKBUTTONBORDERCOLOR.cgColor
    self.viewBackgroundCheckView.layer.borderWidth = 1.0

  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
    self.textFieldUserName.text = "test@chetu.com"
    self.textFieldPassWord.text = "Chetu@123"
  }
  
  
  
  
  // MARK:  buttonLoginTapped method.
  @IBAction func buttonLoginTapped(sender: UIButton){
    if self.isLoginFormValid(){
      
      // Network validation checks.
      if Reachability.isConnectedToNetwork(){
        SwiftLoader.show(title: "Validate...", animated: true)
        
        let delay = DispatchTime.now() + 1 // change 1 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
          
          // Code to execute login api service.
          self.executeUserLoginAuthApiService()
        }
      }
      else{
        DispatchQueue.main.async {
          self.showAlertWith(message: NSLocalizedString("NETWORK_VALIDATION", comment: ""))
        }
      }
      
    }
  }
  
  // MARK:  buttonLoginTapped method.
  @IBAction func buttonCreateAccountTapped(sender: UIButton){
    let storyBoard : UIStoryboard = UIStoryboard(name: MAIN, bundle:nil)
    let gvnSignUpViewController = storyBoard.instantiateViewController(withIdentifier: GVNSIGNUPVIEWCONTROLLER) as! GVNSignUpViewController
    self.navigationController?.pushViewController(gvnSignUpViewController, animated: true)
  }
  
  
  
  // MARK:  executeUserLoginAuthApiService method.
  func executeUserLoginAuthApiService() {
    var signInRequestDict = [String: String]()
    signInRequestDict["username"] = textFieldUserName.text
    signInRequestDict["password"] = textFieldPassWord.text
    AuthenticationServices.authUserWith(inputFields: signInRequestDict, serviceType: UserAuthApiRequestType.Login ,completion: { (apiStatus, response) -> () in
      
      DispatchQueue.main.async {
        // Hide the swift progress loader
        SwiftLoader.hide()
        
        switch apiStatus{
        case NetworkResponseStatus.Success:
          let tabBarController = CustomTabBarController()
          self.navigationController?.pushViewController(tabBarController, animated: true)
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
  
  // MARK:  isLoginFormValid method.
  func isLoginFormValid() -> Bool {
    var message = ""
    
    if textFieldUserName.text?.characters.count == 0{
      message = NSLocalizedString("USERNAMEVALIDATION", comment: "")
    }
    else if !UtilManager.sharedInstance.isValidEmail(emailStr: textFieldUserName.text!){
      message = NSLocalizedString("VALIDAEMAILVALIDATION", comment: "")
    }
    else if textFieldPassWord.text?.characters.count == 0{
      message = NSLocalizedString("PASSWORDVALIDATION", comment: "")
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
 * Extension of GVNLoginViewController to add UITextField prototcol UITextFieldDelegate.
 * Override the protocol method of textfield delegate in GVNLoginViewController to handle textfield action event and slector method.
 */
// MARK:  UITextField Delegates methods
extension GVNLoginViewController: UITextFieldDelegate{
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let textFieldTagIndex = textField.tag
    
    switch textFieldTagIndex {
    case 101: // For Email and Username
      textFieldPassWord.becomeFirstResponder()
      return true

    case 201: // For Password
      textFieldPassWord.resignFirstResponder()
      return true

    default:
      return true
    }
  }
  
}
