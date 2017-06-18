//
//  GVNSettingViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 11/05/17.
//

import UIKit

class GVNSettingViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  @IBOutlet weak var labelHeaderTitle: UILabel!
  
  
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
    
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
  }
  
  
  
  
  // MARK:  ................. IBAction Selector Target methods.
  
  // MARK:  buttonLoginTapped method.
  @IBAction func buttonBackTapped(sender: UIButton){
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK:  buttonProfileInformationTapped method.
  @IBAction func buttonProfileInformationTapped(sender: UIButton){
    let storyBoard : UIStoryboard = UIStoryboard(name: MAIN, bundle:nil)
    let gvnProfileSettingViewController = storyBoard.instantiateViewController(withIdentifier: GVNPROFILESETTINGVIEWCONTROLLER) as! GVNProfileSettingViewController
    self.navigationController?.pushViewController(gvnProfileSettingViewController, animated: true)
  }
  
  // MARK:  buttonChangePasswordTapped method.
  @IBAction func buttonChangePasswordTapped(sender: UIButton){
    let storyBoard : UIStoryboard = UIStoryboard(name: MAIN, bundle:nil)
    let gvnChangePasswordViewController = storyBoard.instantiateViewController(withIdentifier: GVNCHANGEPASSWORDVIEWCONTROLLER) as! GVNChangePasswordViewController
    self.navigationController?.pushViewController(gvnChangePasswordViewController, animated: true)
  }
  
  // MARK:  buttonSignOutTapped method.
  @IBAction func buttonSignOutTapped(sender: UIButton){
    self.navigationController?.popToRootViewController(animated: true)
  }
  
  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
