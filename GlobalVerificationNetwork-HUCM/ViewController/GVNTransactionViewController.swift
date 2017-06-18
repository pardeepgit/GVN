//
//  GVNTransactionViewController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 09/05/17.
//

import UIKit

class GVNTransactionViewController: BaseController {
  
  // MARK:  Widget elements declarations.
  
  
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
  }
  
  // MARK:  loadScreenData method.
  func loadScreenData() {
  }
  
  
  
  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
