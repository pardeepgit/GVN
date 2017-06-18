//
//  CustomTabBarController.swift
//  GlobalVerificationNetwork-HUCM
//
//  Created by Chetu India on 09/05/17.
//

import UIKit

class CustomTabBarController: UITabBarController {
  
  let storyBoard : UIStoryboard = UIStoryboard(name: MAIN, bundle:nil)

  
  // MARK:  UIViewController overrided method.
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    self.tabBar.barTintColor = TABBARBACKGROUNDCOLOR
    self.tabBar.tintColor = WHITECOLOR

    let appearance = UITabBarItem.appearance()
    let attributes = [NSFontAttributeName:ROBOTOREGULARTWELVE]
    appearance.setTitleTextAttributes(attributes, for: UIControlState.normal)
    
    viewControllers = [self.prepareHomeNavigationControllerForTabBar(), self.prepareNewScreeningRequestNavigationControllerForTabBar(), self.prepareOrderNavigationControllerForTabBar(), self.prepareTransactionNavigationControllerForTabBar()]
  }
  
  
  
  // MARK:  prepareHomeNavigationControllerForTabBar method.
  func prepareHomeNavigationControllerForTabBar() -> UIViewController {
    let gvnHomeViewController = storyBoard.instantiateViewController(withIdentifier: GVNHOMEVIEWCONTROLLER) as! GVNHomeViewController
    gvnHomeViewController.tabBarItem.title = NSLocalizedString("HOME", comment: "")
    gvnHomeViewController.tabBarItem.image = UIImage(named: "home")
    
    return gvnHomeViewController
  }
  
  
  // MARK:  prepareOrderNavigationControllerForTabBar method.
  func prepareOrderNavigationControllerForTabBar() -> UIViewController {
    let gvnOrderViewController = storyBoard.instantiateViewController(withIdentifier: GVNORDERVIEWCONTROLLER) as! GVNOrderViewController
    gvnOrderViewController.tabBarItem.title = NSLocalizedString("ORDER", comment: "")
    gvnOrderViewController.tabBarItem.image = UIImage(named: "order")

    return gvnOrderViewController
  }
  
  
  // MARK:  prepareTransactionNavigationControllerForTabBar method.
  func prepareTransactionNavigationControllerForTabBar() -> UIViewController {
    let gvnTransactionViewController = storyBoard.instantiateViewController(withIdentifier: GVNTRANSACTIONVIEWCONTROLLER) as! GVNTransactionViewController
    gvnTransactionViewController.tabBarItem.title = NSLocalizedString("TRANSACTION", comment: "")
    gvnTransactionViewController.tabBarItem.image = UIImage(named: "transaction")

    return gvnTransactionViewController
  }
  
  
  // MARK:  prepareNewScreeningRequestNavigationControllerForTabBar method.
  func prepareNewScreeningRequestNavigationControllerForTabBar() -> UIViewController {
    let gvnNewScreeningRequestViewController = storyBoard.instantiateViewController(withIdentifier: GVNNEWSCREENINGREQUESTVIEWCONTROLLER) as! GVNNewScreeningRequestViewController
    gvnNewScreeningRequestViewController.tabBarItem.title = NSLocalizedString("NEW_ORDER", comment: "")
    gvnNewScreeningRequestViewController.tabBarItem.image = UIImage(named: "newrequest")

    return gvnNewScreeningRequestViewController
  }
  
  
  
  // MARK:  Memory management method.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
