//
//  BaseController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 08/05/17.
//

import UIKit


typealias OkClickCompletion = () -> ()
typealias YesActionCompletion = () -> ()
typealias NoActionCompletion = () -> ()


class BaseController: UIViewController {
  
  /*
   * UIViewController class life cycle overrided method to handle viewController functionality on the basis of the state of method in application.
   * E.g viewDidLoad method to iniailize all the component before appear screem. viewWillAppear method to show loadder or UI related task.
   */
  // MARK:  UIViewController class overrided method.
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  
  // MARK:  showSuccessMsgWith String message and with OkClickCompletion method.
  func showSuccessMsgWith(message: String, completion: @escaping OkClickCompletion) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
    let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel) { action -> Void in
      
      //Just dismiss the action sheet
      completion()
    }
    alert.addAction(cancelAction)
    self.present(alert, animated: true)
  }
  
  
  // MARK:  showSuccessMsgWith String message and with OkClickCompletion method.
  func showAlertDialogueWith(stringMessage message: String, withYesAction yesActionCompletion: @escaping YesActionCompletion, withNoAction noActionCompletion: @escaping NoActionCompletion) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
    let yesAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: .default) { action -> Void in
      //Just dismiss the action sheet
      yesActionCompletion()
    }
    alert.addAction(yesAction)
    
    let noAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: .default) { action -> Void in
      //Just dismiss the action sheet
      noActionCompletion()
    }
    alert.addAction(noAction)
    self.present(alert, animated: true)
  }
  
  // MARK:  showAlertWith String message method.
  func showAlertWith(message: String) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
    alert.addAction(okAction)
    
    self.present(alert, animated: true)
  }
  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
